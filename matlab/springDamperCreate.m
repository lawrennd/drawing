function springDamper = springDamperCreate(startPoint, endPoint, width, ...
                                                 springConst, damperConst, handle)

% SPRINGDAMPERCREATE Create a struct containing the parameters of a spring-damper.

% DRAWING

springDamper.start = startPoint;
springDamper.end = endPoint;
springDamper.spring = springCreate(startPoint, endPoint, width/3, 30, ...
                                   springConst);
springDamper.spring.selected = 0;
springDamper.damper = damperCreate(startPoint, endPoint, width/3, ...
                                   0.4*sqrt(dist2(startPoint, endPoint)), ...
                                   damperConst);
springDamper.damper.selected = 0;
springDamper.selected = 1;
springDamper.width = width;
springDamper.handle = [];
if nargin > 5
  springDamper.handle = handle;
end
springDamper.controlPointHandle = [];
springDamper.type = 'springDamper';




