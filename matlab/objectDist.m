function distance = objectDist(object, point);

% OBJECTDIST Computes the distance between an object and a point.

% DRAWING

distance = feval([object.type 'Dist'], object, point);

