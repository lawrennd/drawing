function circle = circleCreate(centre, radius, handle);

% CIRCLECREATE Create a struct containing the parameters of an circle.

% DRAWING

circle.radius = radius;
circle.centre = centre;

circle.selected = 1;

circle.handle = [];
if nargin > 3
  circle.handle = handle;
end
circle.controlPointHandle = [];
circle.type = 'circle';




