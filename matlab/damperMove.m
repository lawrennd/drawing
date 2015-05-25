function dampers = damperMove(dampers, moveVector);

% DAMPERMOVE Moves a damper to a new point.

% DRAWING

for i = 1:length(dampers)
  dampers(i).start = dampers(i).start + moveVector;
  dampers(i).end = dampers(i).end + moveVector;
  dampers(i) = damperDraw(dampers(i));
end