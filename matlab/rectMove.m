function rects = rectMove(rects, moveVector);

% RECTMOVE Moves a rect to a new point.

% DRAWING

for i = 1:length(rects)
  rects(i).firstPoint = rects(i).firstPoint + moveVector;
  rects(i).secondPoint = rects(i).secondPoint + moveVector;
  rects(i) = rectDraw(rects(i));
end
