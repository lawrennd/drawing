function damper = damperCreate(startPoint, endPoint, width, height, constant, handle)

% DAMPERCREATE Create a struct containing the parameters of a damper.

% DRAWING

damper.start = startPoint;
damper.end = endPoint;
damper.width = width;
damper.height = height;
damper.constant = constant;
damper.selected = 1;

damper.handle = [];
if nargin > 5
  damper.handle = handle;
end
damper.controlPointHandle = [];
damper.type = 'damper';




