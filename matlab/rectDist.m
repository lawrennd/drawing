function distance = rectDist(rects, point);


% RECTDIST Computes the distance between a point and the centre of the rect.

% DRAWING

distance = zeros(length(rects), 1);
for i = 1:length(rects)
  distance(i) = min([dist2(rects(i).firstPoint, point(i, :)) ...
		    dist2(rects(i).secondPoint, point(i, :))]); 
  distance(i) = sqrt(distance(i));
end
