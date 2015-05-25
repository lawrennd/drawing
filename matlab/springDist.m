function distance = springDist(springs, point);

% SPRINGDIST Computes the distance between a point and the centre of the spring.

% DRAWING

  
distance = zeros(length(springs), 1);
for i = 1:length(springs)
  centre = springs(i).start + (springs(i).end - springs(i).start)/2;
  distance(i) = sqrt(dist2(centre, point(i, :)));
end
