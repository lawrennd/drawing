function newObject = objectCopy(object);

% OBJECTMOVE Moves an object to a new point.

% DRAWING

newObject = feval([object.type 'Copy'], object);
