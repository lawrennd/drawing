function springDampers = springDamperDraw(springDampers);

% SPRINGDAMPERDRAW Draws a spring-damper system.

% DRAWING

for i = 1:length(springDampers)
  pointDist = sqrt(sum((springDampers(i).end - springDampers(i).start).^2));
  springDamperVec = springDampers(i).end - springDampers(i).start;
  width = springDampers(i).width/pointDist; 
  off = width;
  halfOff = off/2;
 % Create normalised springDamper box.
  points = [0 0];  
  x = points(end, 1);
  y = halfOff;
  points = [points; [x y]];
  x = points(end, 1) + width/3;
  y = points(end, 2);
  points = [points; [x y]];
  x = points(end, 1);
  y = off;
  points = [points; [x y]];
  springStartInd = size(points, 1);
  x = NaN;
  y = NaN;
  points = [points; [x y]];
  x = points(end-1, 1);
  y = 1-off;
  points = [points; [x y]];
  springEndInd = size(points, 1);
  x = points(end, 1);
  y = 1-halfOff;
  points = [points; [x y]];
  x = points(end, 1)-width/3;
  y = points(end, 2);
  points = [points; [x y]];
  x = points(end, 1);
  y = 1;
  points = [points; [x y]];
  x = points(end, 1);
  y = 1-halfOff;
  points = [points; [x y]];
  x = points(end, 1)-width/3;
  y = points(end, 2);
  points = [points; [x y]];
  x = points(end, 1);
  y = 1-2*off;
  points = [points; [x y]];
  damperEndInd = size(points, 1);
  x = NaN;
  y = NaN;
  points = [points; [x y]];
  x = points(end-1, 1);
  y = off*2;
  points = [points; [x y]];
  damperStartInd = size(points, 1);
  x = points(end, 1);
  y = halfOff;
  points = [points; [x y]];
  x = points(end, 1) + width/3;
  y = points(end, 2);
  points = [points; [x y]];
  x = points(end, 1);
  y = 0;
  points = [points; [x y]];

  theta = asin(springDamperVec(1)/pointDist);
  rotMatrix = [cos(theta) -sin(theta); sin(theta) cos(theta)];
  points = points*pointDist;
  points = points*rotMatrix;
  
  points = points + repmat(springDampers(i).start, size(points, 1), 1);
  
  springDampers(i).spring.start = points(springStartInd, :);
  springDampers(i).spring.end = points(springEndInd, :);
  springDampers(i).spring = springDraw(springDampers(i).spring);

  springDampers(i).damper.start = points(damperStartInd, :);
  springDampers(i).damper.end = points(damperEndInd, :);
  springDampers(i).damper = damperDraw(springDampers(i).damper);

  try
    if isempty(springDampers(i).handle)
      springDampers(i).handle = line(points(:, 1)', points(:, 2)');
    else
      set(springDampers(i).handle, 'XData', points(:, 1)', 'YData', points(:, 2)');
    end
  catch
    springDampers(i).handle = line(points(:, 1)', points(:, 2)');
  end
  if springDampers(i).selected
    try
     if isempty(springDampers(i).handle)
       springDampers(i).controlPointHandle(1) = line(springDampers(i).start(1), ...
					     springDampers(i).start(2));
       springDampers(i).controlPointHandle(2) = line(springDampers(i).end(1), ...
					     springDampers(i).end(2));
       set(springDampers(i).controlPointHandle(:), 'Marker', '.', ...
			 'MarkerSize', 20, ...
			 'LineStyle', 'none', ...
			 'EraseMode', 'xor');
     end
      set(springDampers(i).controlPointHandle(1), ...
	  'XData', springDampers(i).start(1), ...
	  'YData', springDampers(i).start(2));
      set(springDampers(i).controlPointHandle(2), ...
	  'XData', springDampers(i).end(1), ...
	  'YData', springDampers(i).start(2));
      set(springDampers(i).controlPointHandle, 'Visible', 'on')
    catch
      springDampers(i).controlPointHandle = [];
      springDampers(i).controlPointHandle(1) = line(springDampers(i).start(1), ...
					    springDampers(i).start(2));
      springDampers(i).controlPointHandle(2) = line(springDampers(i).end(1), ...
					    springDampers(i).end(2));
      set(springDampers(i).controlPointHandle(:), 'Marker', '.', ...
			'MarkerSize', 20, ...
			'LineStyle', 'none', ...
			'EraseMode', 'xor');
    end
  else
    try
      set(springDampers(i).controlPointHandle, 'Visible', 'off')
    catch
    end
  end

  
end