function object = objectMove(object, moveVector);

% OBJECTMOVE Moves an object to a new point.

% DRAWING

object = feval([object.type 'Move'], object, moveVector);
