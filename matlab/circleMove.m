function circles = circleMove(circles, moveVector);

% CIRCLEMOVE Moves a circle to a new point.

% DRAWING

for i = 1:length(circles)
  circles(i).centre = circles(i).centre + moveVector;
  circles(i) = circleDraw(circles(i));
end