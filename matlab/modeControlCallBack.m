function modeControlCallBack(call, buttonNo)

% MODECONTROLCALLBACK Call back function which controls the selction of the modes.

% DRAWING

global MODE             % THe current mode - Draw, Edit, Move, Copy
global SHAPEINFO        % Information about the shapes in the figure
global ACTIVEFLAG       % Whether there is an operation in progress

% Switch off all the buttons except the one that was pressed
for i = 1:length(SHAPEINFO.modeRadio)
  if i ~= buttonNo
    set(SHAPEINFO.modeRadio(i), 'value', 0);
  else
    set(SHAPEINFO.modeRadio(i), 'value', 1);
  end
end
for i = 1:length(SHAPEINFO.shapeRadio)
  set(SHAPEINFO.shapeRadio(i), 'value', 0);
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

% Set the mode correctly
MODE = call;


% Deselect all objects
for i = 1:length(SHAPEINFO.shape)
  if SHAPEINFO.shape{i}.selected
    SHAPEINFO.shape{i}.selected = 0;
    SHAPEINFO.shape{i} = objectdraw(SHAPEINFO.shape{i});
  end
end

