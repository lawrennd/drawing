function springDampers = springDamperMove(springDampers, moveVector);

% SPRINGDAMPERMOVE Moves a spring-damper to a new point.

% DRAWING

for i = 1:length(springDampers)
  springDampers(i).start = springDampers(i).start + moveVector;
  springDampers(i).end = springDampers(i).end + moveVector;
  springDampers(i) = springDamperDraw(springDampers(i));
end