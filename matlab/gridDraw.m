function grids = gridDraw(grids);

% GRIDDRAW Draws a grid.

% DRAWING

for i = 1:length(grids)
  xPoints = linspace(grids(i).firstPoint(1, 1), ...
		     grids(i).secondPoint(1, 1), ...
		     grids(i).numColumns)';
  yPoints = linspace(grids(i).firstPoint(1, 2), ...
		     grids(i).secondPoint(1, 2), ...
		     grids(i).numRows)';
  for j = 1:grids(i).numRows
    horizontalx(j, :) = [xPoints(1) xPoints(end)];
    horizontaly(j, :) = [yPoints(j) yPoints(j)];
  end
  for j = 1:grids(i).numColumns
    verticalx(j, :) = [xPoints(j) xPoints(j)];
    verticaly(j, :) = [yPoints(1) yPoints(end)];
  end
  try
    % If handles exist
    numLines = grids(i).numColumns+grids(i).numRows;
    if length(grids(i).handle) ~= numLines
      delete(grids(i).handle);
      grids(i).handle = [];
      grids(i) = gridDraw(grids(i));
    else
      for j = 1:grids(i).numRows
	set(grids(i).handle(j), 'XData', horizontalx(j, :), 'YData', horizontaly(j, :));
      end
      for j = 1:grids(i).numColumns
	set(grids(i).handle(j+grids(i).numRows)', 'XData', verticalx(j, :), 'YData', verticaly(j, :));
      end
    end
     
  catch
    % if they don't exist
    grids(i).handle = line(horizontalx', horizontaly');
    grids(i).handle = [grids(i).handle; line(verticalx', verticaly')];
    col = get(grids(i).handle(1), 'color');
    set(grids(i).handle, 'color', col);
    %    set(grids(i).handle, 'linestyle', ':');
  end
  if grids(i).selected
    try
      set(grids(i).controlPointHandle(1), ...
	  'XData', grids(i).firstPoint(1), ...
	  'YData', grids(i).firstPoint(2));
      set(grids(i).controlPointHandle(2), ...
	  'XData', grids(i).secondPoint(1), ...
	  'YData', grids(i).secondPoint(2));     
      set(grids(i).controlPointHandle, 'Visible', 'on')
    catch
      grids(i).controlPointHandle(1) = line(grids(i).firstPoint(1), ...
					    grids(i).firstPoint(2));
      grids(i).controlPointHandle(2) = line(grids(i).secondPoint(1), ...
					    grids(i).secondPoint(2));
      set(grids(i).controlPointHandle(:), 'Marker', '.', ...
			'MarkerSize', 20, ...
			'LineStyle', 'none', ...
			'EraseMode', 'xor');
    end
  else
    try
      set(grids(i).controlPointHandle, 'Visible', 'off')
    catch
    end
  end
end



