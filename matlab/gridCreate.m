function grid = gridCreate(firstPoint, secondPoint, gridRows, gridCols, handle);

% GRIDCREATE Create a structure which stores a grid.

% DRAWING

grid.firstPoint = firstPoint;
grid.secondPoint = secondPoint;

grid.numRows = gridRows;
grid.numColumns = gridCols;

grid.selected = 1;

grid.handle = [];
if nargin > 4
  grid.handle = handle;
end
grid.controlPointHandle = [];

grid.type = 'grid';











