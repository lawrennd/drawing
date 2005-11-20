function distance = ovalDist(ovals, point);

% OVALDIST Computes the distance between a point and the centre of the oval.
% DRAWING

distance = zeros(length(ovals), 1);
for i = 1:length(ovals)
  distance(i) = sqrt(dist2(ovals(i).centre, point(i, :)));
end
