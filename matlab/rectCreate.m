function rect = rectCreate(firstPoint, secondPoint, handle);

% RECTCREATE Create a struct containing the parameters of an rectangle.

% DRAWING

rect.firstPoint = firstPoint;
rect.secondPoint = secondPoint;
rect.selected = 1;
if nargin > 2
  rect.handle = handle;
end

rect.type = 'rect';

