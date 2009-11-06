function square = squareCreate(centre, width, handle);

% SQUARECREATE Create a struct containing the parameters of an square.

% DRAWING 

square.width = width;
square.centre = centre;
square.selected = 1;
if nargin > 2
  square.handle = handle;
end
square.type = 'square';

