function spring = springCreate(startPoint, endPoint, width, bars, constant, handle)

% SPRINGCREATE Create a struct containing the parameters of a spring.

% DRAWING

spring.start = startPoint;
spring.end = endPoint;
spring.width = width;

spring.constant = constant;
spring.bars = bars;
if bars < 1
  error('Spring must have at least one bar.');
end
spring.selected = 1;

spring.handle = [];
if nargin > 5
  spring.handle = handle;
end
spring.controlPointHandle = [];
spring.type = 'spring';




