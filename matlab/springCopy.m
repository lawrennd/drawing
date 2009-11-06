function newSpring = springCopy(spring);

% SPRINGCOPY Copies a spring structure into a new spring structure.

% DRAWING

newSpring = spring;
newSpring.handle = [];
newSpring.controlPointHandle = [];