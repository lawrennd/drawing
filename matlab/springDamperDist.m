function distance = springDamperDist(springDampers, point);

% SPRINGDAMPERDIST Computes the distance between a point and the centre of the spring-damper.

% DRAWING

  
distance = zeros(length(springDampers), 1);
for i = 1:length(springDampers)
  centre = springDampers(i).start + (springDampers(i).end - springDampers(i).start)/2;
  distance(i) = sqrt(dist2(centre, point(i, :)));
end
