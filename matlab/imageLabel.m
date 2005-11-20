% IMAGELABEL Incomplete script for drawing shapes on an image.

% DRAWING

global EDITMODE
global SHAPEMODE
global CURRENTIMAGE
global VISUALISEINFO
global SHAPEINFO
global ACTIVEFLAG

%SHAPEINFO.circles = [struct([])];

screenSize = get(0, 'ScreenSize');

SHAPEINFO.shape = cell(0);
SHAPEINFO.rects = [struct([])];
SHAPEINFO.gridParameters.numRows = 24;
SHAPEINFO.gridParameters.numColumns = 25;
SHAPEINFO.gridParameters.xradius = 6;
SHAPEINFO.gridParameters.yradius = 6;
SHAPEMODE = 'circle';
EDITMODE = 0;
ACTIVEFLAG = 0;
CURRENTIMAGE = imread(['testimage.jpg']);
colordef white
VISUALISEINFO.drawFigure = figure;
set(VISUALISEINFO.drawFigure, 'Visible', 'off');
editWidth = 100;
figPosition = screenSize - [0 -30 editWidth 70];
set(VISUALISEINFO.drawFigure, 'Position', figPosition);
VISUALISEINFO.imageAxes = axes('position', [0 0.05 1 0.95]);
image(CURRENTIMAGE);
axis equal
axis off


set(VISUALISEINFO.drawFigure, 'WindowButtonDownFcn', 'drawCallbackHandler(''click'')')
set(VISUALISEINFO.drawFigure, 'WindowButtonMotionFcn', 'drawCallbackHandler(''move'')')
set(VISUALISEINFO.drawFigure, 'KeyPressFcn', 'drawCallbackHandler(''keypress'')')

editControlWindow
set(VISUALISEINFO.drawFigure, 'Visible', 'on');



