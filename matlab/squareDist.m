function distance = squareDist(squares, point);

% SQUAREDIST Computes the distance between a point and the centre of the square.
% DRAWING

distance = zeros(length(squares), 1);
for i = 1:length(squares)
  distance(i) = sqrt(dist2(squares(i).centre, point)); 
end
