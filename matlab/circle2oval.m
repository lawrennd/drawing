function ovals = circle2oval(circles)

% CIRCLE2OVAL Converts a struct of the form circle to on of the form oval.

% DRAWING

for i = 1:length(circles)
  ovals(i).xradius = circles(i).radius;
  ovals(i).yradius = circles(i).radius;
  ovals(i).centre = circles(i).centre;
  ovals(i).selected = circles(i).selected;
  ovals(i).controlPointHandle = circles(i).controlPointHandle;
  if isfield(circles(i), 'handle')
    ovals(i).handle = circles(i).handle;
  end
  ovals(i).type = 'oval';
end
