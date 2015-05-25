function dampers = damperDraw(dampers);

% DAMPERDRAW Draws a damper.

% DRAWING

for i = 1:length(dampers)
  pointDist = sqrt(sum((dampers(i).end - dampers(i).start).^2));
  damperVec = dampers(i).end - dampers(i).start;
  
  width = dampers(i).width/pointDist;
  height = dampers(i).height/pointDist;
  % Create normalised damper box.
  points = [0 0];
  x = points(end, 1) + width/2;
  y = points(end, 2);
  points = [points; [x y]];
  x = points(end, 1);
  y = height;
  points = [points; [x y]];
  x = NaN;
  y = NaN;
  points = [points; [x y]];  
  x = points(end-1, 1);
  y = .7;
  points = [points; [x, y]];
  x = points(end, 1) - width/2;
  y = points(end, 2);
  points = [points; [x y]];
  x = points(end, 1);
  y = 1;
  points = [points; [x y]];
  x = points(end, 1);
  y = .7;
  points = [points; [x y]];
  x = points(end, 1) - width/2;
  y = points(end, 2);
  points = [points; [x y]];
  x = NaN;
  y = NaN;
  points = [points; [x y]];  
  x = points(end-1, 1);
  y = height;
  points = [points; [x y]];
  x = points(end, 1);
  y = 0;
  points = [points; [x y]];
  x = 0;
  y = 0;
  points = [points; [x y]];

    
  theta = asin(damperVec(1)/pointDist);
  rotMatrix = [cos(theta) -sin(theta); sin(theta) cos(theta)];
  points = points*pointDist;
  points = points*rotMatrix;
  
  points = points + repmat(dampers(i).start, size(points, 1), 1);
  
  % Now draw it.
  try
    if isempty(dampers(i).handle)
      dampers(i).handle = line(points(:, 1)', points(:, 2)');
    else
      set(dampers(i).handle, 'XData', points(:, 1)', 'YData', points(:, 2)');
    end
  catch
    dampers(i).handle = line(points(:, 1)', points(:, 2)');
  end
  if dampers(i).selected
    try
     if isempty(dampers(i).handle)
       dampers(i).controlPointHandle(1) = line(dampers(i).start(1), ...
					     dampers(i).start(2));
       dampers(i).controlPointHandle(2) = line(dampers(i).end(1), ...
					     dampers(i).end(2));
       set(dampers(i).controlPointHandle(:), 'Marker', '.', ...
			 'MarkerSize', 20, ...
			 'LineStyle', 'none', ...
			 'EraseMode', 'xor');
     end
      set(dampers(i).controlPointHandle(1), ...
	  'XData', dampers(i).start(1), ...
	  'YData', dampers(i).start(2));
      set(dampers(i).controlPointHandle(2), ...
	  'XData', dampers(i).end(1), ...
	  'YData', dampers(i).start(2));
      set(dampers(i).controlPointHandle, 'Visible', 'on')
    catch
      dampers(i).controlPointHandle = [];
      dampers(i).controlPointHandle(1) = line(dampers(i).start(1), ...
					    dampers(i).start(2));
      dampers(i).controlPointHandle(2) = line(dampers(i).end(1), ...
					    dampers(i).end(2));
      set(dampers(i).controlPointHandle(:), 'Marker', '.', ...
			'MarkerSize', 20, ...
			'LineStyle', 'none', ...
			'EraseMode', 'xor');
    end
  else
    try
      set(dampers(i).controlPointHandle, 'Visible', 'off')
    catch
    end
  end

  
end