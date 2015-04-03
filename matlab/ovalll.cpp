#include "mex.h"
#include <cmath>
//#include <cassert>

const double MAX_INTENSITY = 65535.0;
const double NEGLOGMAX = -log(MAX_INTENSITY);
const double EPS = 1e-16;
//using namespace std;

double notSpotLl(double x, 
                 double i1,  // The lower limit for background
                 double i2,  // The upper limit for background 
                 double i3,
                 double m1, double c1, 
                 double m3, double c3,
                 double m4, double c4)

{
  // The log likelihood that a pixel is not a spot
  // Currently made up of three lines
 if(x < i1)
   return log(m1*x + c1);
 else if (x > i3)
   return log(m4*x + c4);
 else if (x >= i2) {
   if (x == MAX_INTENSITY)
     return log(EPS);       
   return log(m3*x + c3);
 }
 else 
   return NEGLOGMAX;
}



void ovalll(double* logLikelihoods,
            const int numOvals,
            const double centre[],
            const double xradius[],
            const double yradius[],
            const double limitsx[],
            const double limitsy[],
            const unsigned short imageData[],
            const int imageRows,
            const int imageCols,
            const double i1,
            const double i2,
            const double i3)
{
  // Box location should be laid out as top left point, bottom right
  int boxLeftMost = (int)floor(limitsx[0]);
  int boxTopMost = (int)floor(limitsy[0]);
  int boxRightMost = (int)ceil(limitsx[1]);
  int boxBottomMost = (int)ceil(limitsy[1]);
  int boxNumRows = boxBottomMost - boxTopMost + 1;
  int boxNumCols = boxRightMost - boxLeftMost + 1;
  
  double* backgroundLl = (double*)mxMalloc(boxNumRows*boxNumCols*sizeof(double));
  double* foregroundLl = (double*)mxMalloc(boxNumRows*boxNumCols*sizeof(double));
  double area2 = (i2 - i1)/MAX_INTENSITY;
  // comute m3 and c3 for the last line in the likelihood.
  double m3 = -1.0/(MAX_INTENSITY*(MAX_INTENSITY - i2));
  double c3 = 1.0/(MAX_INTENSITY - i2);
  double area3 = m3*(i3*i3 - i2*i2)/2 + c3*(i3 - i2);
// Compute m2 * c2 - at i2 y = 1/MAX_INTENSITY at MAX_INTENSITY y = 0;
  double m4 = (2.0/MAX_INTENSITY - m3*i3 - c3)/(MAX_INTENSITY -i3);
  double c4 = 2.0/MAX_INTENSITY - m4*MAX_INTENSITY;
  double area4 = m4*(MAX_INTENSITY*MAX_INTENSITY - i3*i3)/2 + c4*(MAX_INTENSITY - i3);
  // Compute the area left for the triangle on the left 
  double area1 = 1.0 - area2 - area3 - area4;
  double c1 = 1/MAX_INTENSITY + 2.0*area1/i1;
  double m1 = (1/MAX_INTENSITY - c1)/i1;
  
  int y = 0;
  int x = 0;
  for(int i = 0; i < boxNumRows; i++) {
    y = i + boxTopMost;
    for(int j = 0; j < boxNumCols; j++) {
      x = j + boxLeftMost;
      backgroundLl[i + boxNumRows*j] = notSpotLl(imageData[y-1 + imageRows*(x-1)], i1, i2, i3, m1, c1, m3, c3, m4, c4);
      foregroundLl[i + boxNumRows*j] = NEGLOGMAX;
    }
  }
  
  for(int ovalNo = 0; ovalNo < numOvals; ovalNo++) {
    // get the pixels associated with the oval
    logLikelihoods[ovalNo] = 0;
    double xRadius2 = xradius[ovalNo]*xradius[ovalNo];
    double yRadius2 = yradius[ovalNo]*yradius[ovalNo];
    
    for(int j = 0; j < boxNumCols; j++) {
      x = j + boxLeftMost;
      double xPos = (double)x - centre[ovalNo];
      double xPart = (xPos*xPos)/xRadius2;
      for(int i = 0; i < boxNumRows; i++) {
        y = i + boxTopMost;
        if(xPart <= 1) { 
          double yPos = (double)y - centre[ovalNo + numOvals];
          double yPart = (yPos*yPos)/yRadius2;
          // check if it is in oval or not and add to log likelihood.
          // no point in further checks if xPart > 1
          if(xPart + yPart <= 1) 
            logLikelihoods[ovalNo] += foregroundLl[i + boxNumRows*j];
          else 
            logLikelihoods[ovalNo] += backgroundLl[i + boxNumRows*j];
        }
        else
          logLikelihoods[ovalNo] += backgroundLl[i + boxNumRows*j];
      }
      
    }
  }
  mxFree(backgroundLl);
  mxFree(foregroundLl);
}


void mexFunction(
                 int nlhs,       mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{

  
  // ovals - struct, the structure containing the ovals
  if(mxGetClassID(prhs[0]) != mxSTRUCT_CLASS)
    mexErrMsgTxt("Error ovals should be STRUCT");  
  const int* ovalDims = mxGetDimensions(prhs[0]);
//  const mxArray ovalsType = mxGetField(prhs[0], 0, "type");
  const int numOvals = mxGetNumberOfElements(prhs[0]);
  double* centre = (double*)mxMalloc(2*numOvals*sizeof(double));
  double* xradius = (double*)mxMalloc(numOvals*sizeof(double));
  double* yradius = (double*)mxMalloc(numOvals*sizeof(double));
  double* centrePr;
  double* xradiusPr;
  double *yradiusPr;
  double* temp;
  for(int i = 0; i < numOvals; i++) {
    centrePr = mxGetPr(mxGetField(prhs[0], i, "centre"));
    xradiusPr = mxGetPr(mxGetField(prhs[0], i, "xradius"));
    yradiusPr = mxGetPr(mxGetField(prhs[0], i, "yradius"));
    
    xradius[i] = *xradiusPr;
    yradius[i] = *yradiusPr;

    for(int j = 0; j < 2; j++) 
      centre[i + j*numOvals] = centrePr[j];
  }  
  // limitsx - double, the limits of the rectangle in the x direction
  if(mxGetClassID(prhs[1]) != mxDOUBLE_CLASS)
    mexErrMsgTxt("Error limitsx should be DOUBLE");  
  double* limitsx = mxGetPr(prhs[1]);

  // limitsy - double, the limits of the rectangle in the y direction
  if(mxGetClassID(prhs[2]) != mxDOUBLE_CLASS)
    mexErrMsgTxt("Error limitsy should be DOUBLE");  
  double* limitsy = mxGetPr(prhs[2]);
  
  // imageData is assumed to be uint16
  if(mxGetClassID(prhs[3]) != mxUINT16_CLASS)
    mexErrMsgTxt("Error Image Data should be UINT16");  
  unsigned short *imageData = (unsigned short *)mxGetData(prhs[3]);
  const int *imageDims;
  imageDims = mxGetDimensions(prhs[3]);
  int imageRows = imageDims[0];
  int imageCols = imageDims[1];



  if(mxGetClassID(prhs[4]) != mxDOUBLE_CLASS)
    mexErrMsgTxt("Error background lower limit should be DOUBLE");  
  double* pI1 = mxGetPr(prhs[4]);
  double i1 = *pI1;

  if(mxGetClassID(prhs[5]) != mxDOUBLE_CLASS)
    mexErrMsgTxt("Error background upper limit should be DOUBLE");  
  double* pI2 = mxGetPr(prhs[5]);
  double i2 = *pI2;

  if(mxGetClassID(prhs[6]) != mxDOUBLE_CLASS)
    mexErrMsgTxt("Error dust spot point should be DOUBLE");  
  double* pI3 = mxGetPr(prhs[6]);
  double i3 = *pI3;


  int dims[2];
  dims[0] = numOvals;
  dims[1] = 1;
  plhs[0] = mxCreateNumericArray(2, dims, mxDOUBLE_CLASS, mxREAL);
  double* logLikelihoods = mxGetPr(plhs[0]);
  
  
  //mexPrintf("There are %d ovals.\n", numOvals);
  ovalll(logLikelihoods, numOvals, centre, xradius, yradius, limitsx, limitsy, imageData, imageRows, imageCols, i1, i2, i3);
  mxFree(centre);
  mxFree(xradius);
  mxFree(yradius);

}









