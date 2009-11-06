function handle = circle(centres, radii, handle)

% CIRCLE Draw a circle.

% DRAWING

if nargin < 3
  handle = oval(centres, radii, radii);
else 
  handle = oval(centres, radii, radii, handle);
end
