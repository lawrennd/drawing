function distance = damperDist(dampers, point);

% DAMPERDIST Computes the distance between a point and the centre of the damper.

% DRAWING

  
distance = zeros(length(dampers), 1);
for i = 1:length(dampers)
  centre = dampers(i).start + (dampers(i).end - dampers(i).start)/2;
  distance(i) = sqrt(dist2(centre, point(i, :)));
end
