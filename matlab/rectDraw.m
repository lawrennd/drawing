function rects = rectDraw(rects)

% RECTDRAW Draw a rectangle.

% DRAWING

t = 0:pi/24:2*pi;
for i = 1:length(rects)
  x = [rects(i).firstPoint(1) rects(i).firstPoint(1) ...
       rects(i).secondPoint(1) rects(i).secondPoint(1) ...
       rects(i).firstPoint(1)];
  
  y = [rects(i).firstPoint(2) rects(i).secondPoint(2) ...
       rects(i).secondPoint(2) rects(i).firstPoint(2) ...
       rects(i).firstPoint(2)];

  try
    set(rects(i).handle, 'XData', x', 'YData', y');
  catch
    rects(i).handle = line(x', y');
  end
  if rects(i).selected
    try
      set(rects(i).controlPointHandle(1), ...
	  'XData', rects(i).firstPoint(1), ...
	  'YData', rects(i).firstPoint(2));
      set(rects(i).controlPointHandle(2), ...
	  'XData', rects(i).secondPoint(1), ...
	  'YData', rects(i).secondPoint(2));     
      set(rects(i).controlPointHandle, 'Visible', 'on')
    catch
      rects(i).controlPointHandle(1) = line(rects(i).firstPoint(1), ...
					    rects(i).firstPoint(2));
      rects(i).controlPointHandle(2) = line(rects(i).secondPoint(1), ...
					    rects(i).secondPoint(2));
      set(rects(i).controlPointHandle(:), 'Marker', '.', ...
			'MarkerSize', 20, ...
			'LineStyle', 'none', ...
			'EraseMode', 'xor');
    end
  else
    try
      set(rects(i).controlPointHandle, 'Visible', 'off')
    catch
    end
  end

end

