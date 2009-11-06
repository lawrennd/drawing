function springs = springMove(springs, moveVector);

% SPRINGMOVE Moves a spring to a new point.

% DRAWING

for i = 1:length(springs)
  springs(i).start = springs(i).start + moveVector;
  springs(i).end = springs(i).end + moveVector;
  springs(i) = springDraw(springs(i));
end