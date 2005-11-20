function rects = square2rect(squares)

% SQUARE2RECT Converts a struct of the form square to one of the form rect.

% DRAWING

for i = 1:length(squares)
  rects(i).firstPoint = [squares(i).centre(1)-squares(i).width/2 ...
		    squares(i).centre(2)-squares(i).width/2];
  rects(i).secondPoint = [squares(i).centre(1)+squares(i).width/2 ...
		    squares(i).centre(2)+squares(i).width/2];
  rects(i).selected = squares(i).selected;
  rects(i).type = 'rect';
  try
    rects(i).controlPointHandle = squares(i).controlPointHandle;
  catch
  end
  try
    rects(i).handle = squares(i).handle;
  catch
  end

end


