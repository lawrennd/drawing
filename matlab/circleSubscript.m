function [iSub, jSub] = circleSubscript(circles);

% CIRCLESUBSCRIPT Returns the subscripts of any pixels that would fall inside the circle

% DRAWING

ovals = circleToOval(circles);
[iSub, jSub] = ovalSubscript(ovals);


