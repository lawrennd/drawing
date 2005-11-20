function drawCallbackHandler(call)

% DRAWCALLBACKHANDLER Function for handling call backs from draw window.

% DRAWING

global EDITMODE
global ACTIVEFLAG  % A flag which indicates whether each task is in progress
global SHAPEMODE
global VISUALISEINFO
global SHAPEINFO
global MODE
persistent INDEX
persistent STARTPOINT
persistent LASTPOINT

switch MODE

  case 'Draw'
   switch call 
    case 'click'
     [x, y]  = localCheckPointPosition(VISUALISEINFO);  
     % If the pointer was not in the axes the values will be empty 
     if ~isempty(x)
       if ~ACTIVEFLAG
	 SHAPEINFO.firstClickPoint = [x y]; 
	 switch SHAPEMODE
	  case 'circle'
	   SHAPEINFO.currentObject = circleCreate(SHAPEINFO.firstClickPoint, 0);
	   SHAPEINFO.currentObject = circleDraw(SHAPEINFO.currentObject);
	   
	  case 'oval'
	   SHAPEINFO.currentObject = ovalCreate(SHAPEINFO.firstClickPoint, 0, 0);
	   SHAPEINFO.currentObject = ovalDraw(SHAPEINFO.currentObject);
	   
	  case 'rect'
	   SHAPEINFO.currentObject = rectCreate(SHAPEINFO.firstClickPoint, ...
						SHAPEINFO.firstClickPoint);
	   SHAPEINFO.currentObject = rectDraw(SHAPEINFO.currentObject);
	  case 'square'
	   SHAPEINFO.currentObject = squareCreate(SHAPEINFO.firstClickPoint, 0);
	   SHAPEINFO.currentObject = squareDraw(SHAPEINFO.currentObject);
	   
	  case 'grid'
	   SHAPEINFO.currentObject = gridCreate(SHAPEINFO.firstClickPoint, ...
						SHAPEINFO.firstClickPoint, ...
						SHAPEINFO.gridParameters.numRows, ...
						SHAPEINFO.gridParameters.numColumns);
	   SHAPEINFO.currentObject = gridDraw(SHAPEINFO.currentObject);
	   
	 end
	 set(SHAPEINFO.currentObject.handle, 'EraseMode', 'xor');
	 ACTIVEFLAG = 1;
       else
	 SHAPEINFO.currentObject.selected = 0;
	 SHAPEINFO.currentObject = objectDraw(SHAPEINFO.currentObject);
	 SHAPEINFO.shape{end+1} = SHAPEINFO.currentObject;
	 ACTIVEFLAG = 0;
	 
       end
     end
     
    case 'move'
     
     [x, y] = localCheckPointPosition(VISUALISEINFO);  
     if ~isempty(x)
       set(VISUALISEINFO.positionTxt, ...
	   'String', [num2str(x) ', ' num2str(y)]);
       
       set(VISUALISEINFO.drawFigure, 'Pointer', 'fullcrosshair')
       if ACTIVEFLAG 
	 
	 % Check if escape pressed - improves responsiveness.
	 key = double(get(VISUALISEINFO.drawFigure, 'CurrentCharacter'));
	 if ~isempty(key) & (key == 27)
	   % Undo current Draw activity
	   set(VISUALISEINFO.drawFigure, 'CurrentCharacter', ' ')
	   objectDelete(SHAPEINFO.currentObject);
	   ACTIVEFLAG = 0;  
	 end
	 % Order points such that top left is first bottom right is second
	 startj = min([SHAPEINFO.firstClickPoint(1) x]);
	 endj = max([SHAPEINFO.firstClickPoint(1) x]);
	 starti = min([SHAPEINFO.firstClickPoint(2) y]);
	 endi = max([SHAPEINFO.firstClickPoint(2) y]);
	 
	 switch SHAPEMODE
	  case 'circle'
	   SHAPEINFO.currentObject.radius = sqrt(dist2(SHAPEINFO.firstClickPoint, [x y]));
	   SHAPEINFO.currentObject = circleDraw(SHAPEINFO.currentObject);
	   
	  case 'oval'
	   irad = (endi - starti)/2;
	   jrad = (endj - startj)/2;
	   SHAPEINFO.currentObject.centre = [startj + jrad starti + irad];
	   SHAPEINFO.currentObject.xradius = jrad;
	   SHAPEINFO.currentObject.yradius = irad;
	   SHAPEINFO.currentObject = ovalDraw(SHAPEINFO.currentObject);
	   
	  case 'rect'
	   SHAPEINFO.currentObject.firstPoint = [startj starti];
	   SHAPEINFO.currentObject.secondPoint = [endj endi];
	   SHAPEINFO.currentObject = rectDraw(SHAPEINFO.currentObject);
	   
	  case 'square'
	   
	   SHAPEINFO.currentObject.width = 2*max(abs(SHAPEINFO.firstClickPoint - [x y]));
	   SHAPEINFO.currentObject = squareDraw(SHAPEINFO.currentObject);
	   
	  case 'grid'
	   SHAPEINFO.currentObject.firstPoint = [startj, starti];
	   SHAPEINFO.currentObject.secondPoint = [endj, endi];
	   SHAPEINFO.currentObject.numRows = ...
	       SHAPEINFO.gridParameters.numRows;
	   SHAPEINFO.currentObject.numColumns = ...
	       SHAPEINFO.gridParameters.numColumns;
	   SHAPEINFO.currentObject = gridDraw(SHAPEINFO.currentObject);
	 end
       end
     else
       set(VISUALISEINFO.drawFigure, 'Pointer', 'arrow')
     end
    case 'deleteCurrent'
     delete(SHAPEINFO.currentObject)
     ACTIVEFLAG = 0;
     
    case 'keypress'
     % Look for escape key to stop current draw.
     if ACTIVEFLAG 
       key = double(get(VISUALISEINFO.drawFigure, 'CurrentCharacter'));
       if ~isempty(key) & key == 27
	 % Undo current Draw activity
	 set(VISUALISEINFO.drawFigure, 'CurrentCharacter', ' ')
	 objectdelete(SHAPEINFO.currentObject);
	 ACTIVEFLAG = 0;  
       end
     end
   end
   
 case 'Edit'
  % Edit mode is activated
  
  switch call
   case  'click'
    [x, y] = localCheckPointPosition(VISUALISEINFO);  
    if ~isempty(x)
      if ACTIVEFLAG
	SHAPEINFO.shape{INDEX}.selected = 0;
	SHAPEINFO.shape{INDEX} = objectDraw(SHAPEINFO.shape{INDEX});
      end
      indexNew = closestObject(x, y);
      if ~isempty(indexNew)
	if isempty(INDEX) | indexNew ~= INDEX
	  INDEX = indexNew;
	  SHAPEINFO.shape{INDEX}.selected = 1;
	  SHAPEINFO.shape{INDEX} = objectDraw(SHAPEINFO.shape{INDEX});
	  ACTIVEFLAG = 1;
	else
	  SHAPEINFO.shape{INDEX}.selected = 0;
	  SHAPEINFO.shape{INDEX} = objectDraw(SHAPEINFO.shape{INDEX});	
	  INDEX = [];
	  % There are now no objects selected.
	  ACTIVEFLAG = 0;
	end
      end
    end
   case 'move'
    
    [x, y] = localCheckPointPosition(VISUALISEINFO);  
    if ~isempty(x)
      set(VISUALISEINFO.positionTxt, ...
	  'String', [num2str(x) ', ' num2str(y)]);
      
      set(VISUALISEINFO.drawFigure, 'Pointer', 'arrow')
    end
   
   case 'keypress'
    % Look for delete key to be pressed to remove object
    key = double(get(VISUALISEINFO.drawFigure, 'CurrentCharacter'));
    if ~isempty(key)
      if key == 4 | key == 127
	for i = length(SHAPEINFO.shape):-1:1
	  if SHAPEINFO.shape{i}.selected
	    objectdelete(SHAPEINFO.shape{i});
	    SHAPEINFO.shape(i) = [];
	  end
	end
	% There are now no objects selected.
	ACTIVEFLAG = 0;
      end
    end
  end
  
 case 'Move'
  % Move mode is activated
  switch call
   
   case  'click'
    [x, y] = localCheckPointPosition(VISUALISEINFO);  
    if ~isempty(x)
      INDEX = closestObject(x, y);
      if ~isempty(INDEX)
	if ACTIVEFLAG
	  % Move is already started - click says to finish it.
	  moveVector = [x y] - LASTPOINT;
	  SHAPEINFO.shape{INDEX} = objectMove(SHAPEINFO.shape{INDEX}, ...
					      moveVector); 
	  SHAPEINFO.shape{INDEX}.selected = 0;
	  SHAPEINFO.shape{INDEX} = objectDraw(SHAPEINFO.shape{INDEX});
	  ACTIVEFLAG = 0;
	  STARTPOINT = [];
	  LASTPOINT = [];
	  INDEX = [];
	else
	  if isempty(STARTPOINT)
	    % Start a new move.
	    set(VISUALISEINFO.drawFigure, 'Pointer', 'fleur')      
	    SHAPEINFO.shape{INDEX}.selected = 1;
	    SHAPEINFO.shape{INDEX} = objectDraw(SHAPEINFO.shape{INDEX});
	    ACTIVEFLAG = 1;
	    STARTPOINT = [x y];
	    LASTPOINT = [x y];
	  else 
	    % ACTIVEFLAG has been changed by someone else
	    if ~isempty(INDEX)
	      % Move wasn't completed properly - undo it.
	      moveVector = STARTPOINT - LASTPOINT;
	      SHAPEINFO.shape{INDEX} = objectMove(SHAPEINFO.shape{INDEX}, ...
						  moveVector);
	      % Now clean up
	      INDEX = [];
	      LASTPOINT = [];
	      STARTPOINT = [];
	    else
	      error(['Move is not currently active but INDEX and' ...
		     ' STARTPOINT haven''t been cleared up.'])
	    end
	  end

	end
      end
    end
   
   case 'move'
     [x, y] = localCheckPointPosition(VISUALISEINFO);  
     if ~isempty(x)
       set(VISUALISEINFO.positionTxt, ...
	   'String', [num2str(x) ', ' num2str(y)]);
       
       if ACTIVEFLAG 
	 moveVector = [x y] - LASTPOINT;
	 set(VISUALISEINFO.drawFigure, 'Pointer', 'fleur')      
	 SHAPEINFO.shape{INDEX} = objectMove(SHAPEINFO.shape{INDEX}, ...
					     moveVector); 
	 
	 LASTPOINT = [x y];
       else
	 set(VISUALISEINFO.drawFigure, 'Pointer', 'arrow')      
       end
     end
  
  end
 
 case 'Copy'
  % Copy mode is activated
  
  switch call
    
   case 'click'
    [x, y] = localCheckPointPosition(VISUALISEINFO);  
    if ~isempty(x)
      index = closestObject(x, y);
      if ~isempty(index)
	if ACTIVEFLAG
	  % Copy is currently active - click ends copy
	  moveVector = [x y] - LASTPOINT;
	  SHAPEINFO.shape{INDEX} = objectMove(SHAPEINFO.shape{INDEX}, ...
					      moveVector); 
	  SHAPEINFO.shape{INDEX}.selected = 0;
	  SHAPEINFO.shape{INDEX} = objectDraw(SHAPEINFO.shape{INDEX});
	  ACTIVEFLAG = 0;
	  STARTPOINT = [];
	  LASTPOINT = [];
	  INDEX = [];
	else
	  % Copy is currently incactive
	  if isempty(STARTPOINT)
	    % Start a new copy
	    set(VISUALISEINFO.drawFigure, 'Pointer', 'fleur')      
	    SHAPEINFO.shape{end+1} = objectcopy(SHAPEINFO.shape{index});
	    SHAPEINFO.shape{end}.handle = [];
	    
	    STARTPOINT = [x y];
	    LASTPOINT = [x y];
	    INDEX = length(SHAPEINFO.shape);
	    SHAPEINFO.shape{INDEX}.selected = 1;
	    SHAPEINFO.shape{INDEX} = objectDraw(SHAPEINFO.shape{INDEX});
	    set(SHAPEINFO.shape{INDEX}.handle, 'EraseMode', 'xor');
	    ACTIVEFLAG = 1;
	  else 
	    % ACTIVEFLAG has been changed by someone else
	    if ~isempty(INDEX)
	      % Copy wasn't completed properly - delete it.
	      objectDelete(SHAPEINFO.shape{INDEX});
	      SHAPEINFO.shape(INDEX) = [];

	      % Now clean up
	      INDEX = [];
	      LASTPOINT = [];
	      STARTPOINT = [];
	    else
	      error(['Copy is not currently active but INDEX and' ...
		     ' STARTPOINT haven''t been cleared up.'])
	    end
	  end
	end
      end
    end

   case 'move'
     [x, y] = localCheckPointPosition(VISUALISEINFO);  
     if ~isempty(x)
       set(VISUALISEINFO.positionTxt, ...
	   'String', [num2str(x) ', ' num2str(y)]);
       
       if ACTIVEFLAG 
	 set(VISUALISEINFO.drawFigure, 'Pointer', 'fleur')      
	 moveVector = [x y] - LASTPOINT;
	 SHAPEINFO.shape{INDEX} = objectMove(SHAPEINFO.shape{INDEX}, ...
					     moveVector); 
	 
	 LASTPOINT = [x y];
       else
	 set(VISUALISEINFO.drawFigure, 'Pointer', 'arrow')      
       end
     end
     
  end
end
  
 

function index = closestObject(x, y)

global SHAPEINFO

% Return the index of the nearest shape

if length(SHAPEINFO.shape) == 0
  index = [];
  return
end
for i = 1:length(SHAPEINFO.shape)
  distance(i) = objectDist(SHAPEINFO.shape{i}, [x y]);
end
[void, index] = min(distance);

  

function point = localGetNormCursorPoint(figHandle)

point = get(figHandle, 'currentPoint');
figPos = get(figHandle, 'Position');
% Normalise the point of the curstor
point(1) = point(1)/figPos(3);
point(2) = point(2)/figPos(4);

function [x, y] = localGetNormAxesPoint(point, axesHandle)

position = get(axesHandle, 'Position');
yDir = get(axesHandle, 'YDir');
x = (point(1) - position(1))/position(3);
y = (point(2) - position(2))/position(4);

lim = get(axesHandle, 'XLim');
x = x*(lim(2) - lim(1));
x = x + lim(1);

lim = get(axesHandle, 'YLim');
switch yDir
 case 'reverse'
  y = y*(lim(1) - lim(2));
  y = y + lim(2);
 case 'normal'
  y = y*(lim(2) - lim(1));
  y = y + lim(1);
end


function [x, y] = localCheckPointPosition(VISUALISEINFO)

% Get the point of the cursor
point = localGetNormCursorPoint(VISUALISEINFO.drawFigure);

% get the position of the axes
position = get(VISUALISEINFO.imageAxes, 'Position');


% Check if the pointer is in the axes
if point(1) > position(1) ...
      & point(1) < position(1) + position(3) ...
      & point(2) > position(2) ...
      & point(2) < position(2) + position(4);
  
  % Rescale the point according to the axes
  [x y] = localGetNormAxesPoint(point, VISUALISEINFO.imageAxes);

else
  % Return nothing
  x = [];
  y = [];
end



function circlegridShape = circlegridCreate(firstPoint, ...
					    secondPoint, ...
					    thirdPoint, ...
					    fourthPoint, ...
					    gridRows, ...
					    gridCols, ...
					    xradius, ...
					    yradius, ...
					    handle);

% Store the parameters associated with a grid of circles.

numCircs = gridRows*gridCols;
[x y] = meshgrid(...
    linspace(firstPoint(1, 1), secondPoint(1, 1), gridCols)', ...
    linspace(firstPoint(1, 2), secondPoint(1, 2), gridRows)');
points = [x(:) y(:)];


for i = 1:numCircs
  circlegridShape.ovals(i) = ovalCreate(xradius, yradius, points(i, :), handle(i));
end

circlegridShape.border = rectCreate(firstPoint, secondPoint, handle(end));
circlegridShape.numRows = gridRows;
circlegridShape.numCols = gridCols;

circlegridShape.type = 'circlegrid';











