function grids = gridMove(grids, moveVector);

% GRIDMOVE Moves a grid to a new point.

% DRAWING

for i = 1:length(grids)
  grids(i).firstPoint = grids(i).firstPoint + moveVector;
  grids(i).secondPoint = grids(i).secondPoint + moveVector;
  grids(i) = gridDraw(grids(i));
end