function distance = gridDist(grids, point);

% GRIDDIST Computes the distance between a point and the centre of the grid.

% DRAWING

distance = zeros(length(grids), 1);
for i = 1:length(grids)
  grids(i).type = 'rect';
  distance(i) = rectDist(grids(i), point);
  grids(i).type = 'grid';
end
