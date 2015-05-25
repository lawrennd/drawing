function newDamper = damperCopy(damper);

% DAMPERCOPY Copies a damper structure into a new damper structure.

% DRAWING

newDamper = damper;
newDamper.handle = [];
newDamper.controlPointHandle = [];