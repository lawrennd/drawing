function handle = circle(centres, radii, handle)

% CIRCLE Draw a circle.
% FORMAT
% ARG centres : centres of the circles to draw.
% ARG radii : radii of circles to draw.
% RETURN handle : handle of circles that were drawn.
%
% FORMAT
% ARG centres : centres of the circles to draw.
% ARG radii : radii of circles to draw.
% ARG handle : handles of circles to modify.
% RETURN handle : handle of circles that were drawn.
%
% SEEALSO : oval
%
% COPYRIGHT : Neil D. Lawrence, 2005

% DRAWING

if nargin < 3
  handle = oval(centres, radii, radii);
else 
  handle = oval(centres, radii, radii, handle);
end
