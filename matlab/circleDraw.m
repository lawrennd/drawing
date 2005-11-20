function circles = circleDraw(circles);

% CIRCLEDRAW Draws a circle.

% DRAWING

ovals = circle2oval(circles);
ovals = ovalDraw(ovals);

for i = 1:length(circles)
  circles(i).handle = ovals(i).handle;
  circles(i).controlPointHandle = ovals(i).controlPointHandle;
end