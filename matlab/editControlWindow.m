% EDITCONTROLWINDOW Script which creates the window with the edit commands.

% DRAWING

global SHAPEINFO

% Set uicontrol size parameters
radioHeight = 0.025;
xyposHeight = 0.05;
editHeight = 0.04;

currentBottom = 1;
% Draw a window for edit control
VISUALISEINFO.editFigure = figure;
set(VISUALISEINFO.editFigure, 'Visible', 'off');

editPosition = [figPosition(3) + figPosition(1) ...
		30 editWidth 700];
set(VISUALISEINFO.editFigure, 'Resize', 'off', ...
		'units', 'pixels', ...
		'Position', editPosition, ...
		'menubar', 'none')
currentBottom = currentBottom - xyposHeight;
VISUALISEINFO.positionTxt = uicontrol('Style', 'text', ...
				      'String', [num2str(0) ',' num2str(0)], ...
				      'units', 'normalized', ...
				      'position', [0 currentBottom 1 xyposHeight]);

currentBottom = currentBottom - radioHeight;

shapeName{1} = 'Circle';
shapeType{1} = 'circle';
shapeName{2} = 'Oval';
shapeType{2} = 'oval';
shapeName{3} = 'Square';
shapeType{3} = 'square';
shapeName{4} = 'Rectangle';
shapeType{4} = 'rect';
shapeName{5} = 'Grid';
shapeType{5} = 'grid';

numShapes = length(shapeName);
for i = 1:numShapes
  currentBottom = currentBottom - radioHeight;
  shapeRadioPos{i} = [0 currentBottom 1 radioHeight];
end

% Create Radio buttons

for i = 1:numShapes
  SHAPEINFO.shapeRadio(i) = ...
      uicontrol('Style', 'radiobutton', ...
		'String', shapeName{i}, ...
		'units', 'normalized', ...
		'position', shapeRadioPos{i}, ...
		'Callback', ['drawControlCallBack(''' shapeType{i} ''', ' ...
		    num2str(i) ')']);
end

currentBottom = currentBottom - radioHeight;
modeName{1} = 'Edit';
modeName{2} = 'Copy';
modeName{3} = 'Move';

numModes = length(modeName);
for i = 1:numModes
  currentBottom = currentBottom - radioHeight;
  modeRadioPos{i} = [0 currentBottom 1 radioHeight];
end  
for i = 1:numModes
  SHAPEINFO.modeRadio(i) = ...
      uicontrol('Style', 'radiobutton', ...
		'String', modeName{i}, ...
		'units', 'normalized', ...
		'position', modeRadioPos{i}, ...
		'Callback', ['modeControlCallBack(''' modeName{i} ''', ' ...
		    num2str(i) ')']);
end

editName{1} = 'editBox1';
labelName{1} = 'labelBox1';
editName{2} = 'editBox2';
labelName{2} = 'labelBox2';
editName{3} = 'editBox3';
labelName{3} = 'labelBox3';
  currentBottom = currentBottom - editHeight;

numEdits = length(editName);
for i = 1:numEdits
  currentBottom = currentBottom - editHeight;
  editBoxPos{i} = [.5 currentBottom .5 editHeight];
  labelBoxPos{i} = [0 currentBottom .5 editHeight];
end  

for i = 1:numEdits
  SHAPEINFO.editBox(i) = ...
      uicontrol('Style', 'edit', ...
		'String', '', ...
		'units', 'normalized', ...
		'position', editBoxPos{i});
  SHAPEINFO.labelBox(i) = ...
      uicontrol('Style', 'text', ...
		'String', labelName{i}, ...
		'units', 'normalized', ...
		'position', labelBoxPos{i});
end

% Set the radio buttons so that first shape is pressed
drawControlCallBack(shapeType{1}, 1);

set(VISUALISEINFO.editFigure, 'Visible', 'on');






