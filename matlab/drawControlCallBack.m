function drawControlCallBack(call, buttonNo)

% DRAWCONTROLCALLBACK Call back for the draw control interface.

% DRAWING

global SHAPEMODE
global SHAPEINFO
global MODE
global ACTIVEFLAG

% Switch off all the buttons except the one which was pressed
for i = 1:length(SHAPEINFO.shapeRadio)
  if i ~= buttonNo
    set(SHAPEINFO.shapeRadio(i), 'value', 0);
  else
    set(SHAPEINFO.shapeRadio(i), 'value', 1);
  end
end
for i = 1:length(SHAPEINFO.modeRadio)
  set(SHAPEINFO.modeRadio(i), 'value', 0);
end

% If active flag is set, something is going on and needs to be tidied up.
if ACTIVEFLAG
  switch MODE
   case 'Draw'
    % Undo current Draw activity
    objectdelete(SHAPEINFO.currentObject);
    ACTIVEFLAG = 0;  
   
   case 'Copy'
    % Undo current Copy activity
    ACTIVEFLAG = 0;   
    callbackhandler('click');

    case 'Move'
     % Undo any Move activity
     ACTIVEFLAG = 0;   
     callbackhandler('click');
  end
  
end

% Set the shape mode to that selected
SHAPEMODE = call;,

switch call
 case 'grid'
  g = SHAPEINFO.gridParameters;
  set(SHAPEINFO.labelBox(1), 'String', 'Rows', 'visible', 'on')
  set(SHAPEINFO.labelBox(2), 'String', 'Columns', 'visible', 'on')
  set(SHAPEINFO.labelBox(3), 'String', 'Radius', 'visible', 'on')
  set(SHAPEINFO.editBox(1), 'String', num2str(g.numRows), ...
		    'visible', 'on', ...
		    'Callback', 'gridControlCallBack(''setRows'', 1)');
  set(SHAPEINFO.editBox(2), 'String', num2str(g.numColumns), ...
		    'visible', 'on', ...
		    'Callback', 'gridControlCallBack(''setColumns'', 2)');
  set(SHAPEINFO.editBox(3), 'String', '', 'visible', 'on')
 otherwise
  set(SHAPEINFO.labelBox(1), 'String', '', 'visible', 'off')
  set(SHAPEINFO.labelBox(2), 'String', '', 'visible', 'off')
  set(SHAPEINFO.labelBox(3), 'String', '', 'visible', 'off')
  set(SHAPEINFO.editBox(1), 'String', '', 'visible', 'off')
  set(SHAPEINFO.editBox(2), 'String', '', 'visible', 'off')
  set(SHAPEINFO.editBox(3), 'String', '', 'visible', 'off')
end  
% Set the mode to drawing mode
MODE = 'Draw';

