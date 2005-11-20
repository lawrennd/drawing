function squares = squareDraw(squares);

% SQUAREDRAW Draw a square.

% DRAWING

rects = square2rect(squares);
rects = rectDraw(rects);
for i = 1:length(squares)
  squares(i).handle = rects(i).handle;
  squares(i).controlPointHandle = rects(i).controlPointHandle;
end