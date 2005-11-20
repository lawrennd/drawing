function oval = ovalCreate(centre, xradius, yradius, handle);

% OVALCREATE Create a struct containing the parameters of an oval.

% DRAWING

oval.xradius = xradius;
oval.yradius = yradius;
oval.selected = 1;
oval.centre = centre;
oval.handle = [];
if nargin > 3
  oval.handle = handle;
end
oval.controlPointHandle = [];
oval.type = 'oval';

