function springs = springDraw(springs);

% SPRINGDRAW Draws a spring.

% DRAWING

for i = 1:length(springs)
  pointDist = sqrt(sum((springs(i).end - springs(i).start).^2));
  springVec = springs(i).end - springs(i).start;
  
%  normSpringVec = springVec/pointDist;
%  rotMatrix = [springVec
  barHeight = 1/springs(i).bars;
  width = springs(i).width/pointDist;
  % Create normalised spring box.
  points = [0 0];
  x = points(end, 1) + width/2;
  y = points(end, 2);
  points = [points; [x, y]];
  for j = 1:springs(i).bars -1
    x = points(end, 1) - width;
    y = points(end, 2) + barHeight;
    points = [points; [x y]];
    x = points(end, 1) + width;
    y = points(end, 2);
    points = [points; [x, y]];
  end
  x = points(end, 1) - width;
  y = points(end, 2) + barHeight;
  points = [points; [x, y]];
  x = points(end, 1) + width/2;
  y = points(end, 2);
  points = [points; [x, y]];
  theta = asin(springVec(1)/pointDist);
  rotMatrix = [cos(theta) -sin(theta); sin(theta) cos(theta)];
  points = points*pointDist;
  points = points*rotMatrix;
  
  points = points + repmat(springs(i).start, size(points, 1), 1);
  
  % Now draw it.
  try
    if isempty(springs(i).handle)
      springs(i).handle = line(points(:, 1)', points(:, 2)');
    else
      set(springs(i).handle, 'XData', points(:, 1)', 'YData', points(:, 2)');
    end
  catch
    springs(i).handle = line(points(:, 1)', points(:, 2)');
  end
  if springs(i).selected
    try
     if isempty(springs(i).handle)
       springs(i).controlPointHandle(1) = line(springs(i).start(1), ...
					     springs(i).start(2));
       springs(i).controlPointHandle(2) = line(springs(i).end(1), ...
					     springs(i).end(2));
       set(springs(i).controlPointHandle(:), 'Marker', '.', ...
			 'MarkerSize', 20, ...
			 'LineStyle', 'none', ...
			 'EraseMode', 'xor');
     end
      set(springs(i).controlPointHandle(1), ...
	  'XData', springs(i).start(1), ...
	  'YData', springs(i).start(2));
      set(springs(i).controlPointHandle(2), ...
	  'XData', springs(i).end(1), ...
	  'YData', springs(i).start(2));
      set(springs(i).controlPointHandle, 'Visible', 'on')
    catch
      springs(i).controlPointHandle = [];
      springs(i).controlPointHandle(1) = line(springs(i).start(1), ...
					    springs(i).start(2));
      springs(i).controlPointHandle(2) = line(springs(i).end(1), ...
					    springs(i).end(2));
      set(springs(i).controlPointHandle(:), 'Marker', '.', ...
			'MarkerSize', 20, ...
			'LineStyle', 'none', ...
			'EraseMode', 'xor');
    end
  else
    try
      set(springs(i).controlPointHandle, 'Visible', 'off')
    catch
    end
  end

  
end