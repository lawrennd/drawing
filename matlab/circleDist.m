function distance = circleDist(circles, point);

% CIRCLEDIST Computes the distance between a point and the centre of the circle.
% DRAWING

distance = zeros(length(circles), 1);
for i = 1:length(circles)
  distance(i) = sqrt(dist2(circles(i).centre, point(i, :)));
end
