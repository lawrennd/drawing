function object = objectDraw(object);

% OBJECTDRAW Draws a object.

% DRAWING

for i = 1:length(object)
  object(i) = feval([object(i).type 'Draw'], object(i));
end