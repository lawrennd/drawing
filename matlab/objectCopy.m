function newObject = objectCopy(object);

% OBJECTCOPY Moves an object to a new point.

% DRAWING

newObject = feval([object.type 'Copy'], object);
