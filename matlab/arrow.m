function handle = arrow(X, Y, headType, arrowColor,lineThickness,headSize,arrowHeight)

% ARROW Draw an arrow. 

% Based on code from Mike Tipping.

% DRAWING

if nargin<7
  arrowHeight	= 2;
end
if nargin<6
  headSize = 1;
end
if nargin<5
  lineThickness = 1;
end
if nargin<4
  arrowColor = 'w';
end
if nargin<3
  headType = 'open';
end

% This is the standard size of an arrow as a percentage of the
% dimensions. This is multiplied by the parameter `headSize' to create arrow
% heads of differing relative sizes.
arroxAxisPercent = 2;
% This is the factor by which the arrow is `higher' than `wide'

APOSx = X(end-1);
APOSy = Y(end-1);
x = X(end);
y = Y(end);

APOSx		= [APOSx x];
APOSy		= [APOSy y];



% Create generic arrow head

xLim	= get(gca,'Xlim');
yLim	= get(gca,'Ylim');
xWidth = xLim(2)-xLim(1);
yWidth = yLim(2)-yLim(1);
units_	= get(gca,'Units');
set(gca,'Units','Pixels')
pos	= get(gca,'Position');
set(gca,'Units',units_)
xscale	= pos(4)/pos(3)*xWidth*arroxAxisPercent/100;
yscale  = yWidth*arroxAxisPercent/100;

TRIx = [-0.5; 0.5; 0]*headSize;
TRIy = [ -arrowHeight; -arrowHeight; 0]*headSize;

% Now rotate and shift it to an appropriate location
%  
dy	= APOSy(2)-APOSy(1);
dx	= APOSx(2)-APOSx(1);

angle	= atan2(1/yscale*dy,1/xscale*dx);
M	= [sin(angle) -cos(angle); cos(angle) sin(angle)];
TRI	= [TRIx TRIy]* M;
TRI(:,1) = xscale*TRI(:,1);
TRI(:,2) = yscale*TRI(:,2);

TRI	= TRI + ones(3,1)*[APOSx(2) APOSy(2)];
switch headType
 
 
 case 'line'
  
  h1 = line(X,Y,...
       'LineWidth',lineThickness,...
       'Color',arrowColor);
  TRI = [TRI(1, :); TRI(3, :); TRI(2, :)];
  h2 = line(TRI(:,1),TRI(:,2), ...
	    'color', arrowColor, ...
	    'lineWidth', lineThickness);
 
 
 case 'open'
  shortX = arrowHeight*cos(angle);
  shortY = arrowHeight*sin(angle);
  X(end) = X(end) - shortX*xscale;
  Y(end) = Y(end) - shortY*yscale;
  
  h1 = line(X,Y,...
       'LineWidth',lineThickness,...
       'Color',arrowColor);

  TRI = [TRI; TRI(1, :)];
  h2 = line(TRI(:,1),TRI(:,2), ...
	    'color', arrowColor, ...
	    'lineWidth', lineThickness);
 
 
 case 'closed'
  h1 = line(X,Y,...
       'LineWidth',lineThickness,...
       'Color',arrowColor);
  h2 = patch(TRI(:,1),TRI(:,2), arrowColor);
  set(h2,'EdgeColor','None')
end

handle = [h1 h2];
