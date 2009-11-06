function newSpringDamper = springDamperCopy(springDamper);

% SPRINGDAMPERCOPY Copies a spring-damper structure into a new spring-damper structure.

% DRAWING

newSpringDamper = springDamper;
newSpringDamper.handle = [];
newSpringDamper.controlPointHandle = [];