function object = objectDraw(object);

% OBJECTDRAW Draws a object.

% DRAWING

object = feval([object.type 'Draw'], object);
