function [iSub, jSub] = rectSubscript(rects)

% RECTSUBSCRIPT Returns the subscripts of any pixels that would fall inside the rect.

% DRAWING

maxArea = 0;
for i = 1:length(rects)
  maxArea = maxArea + ceil(rects(i).secondPoint(1) - rects(i).firstPoint(1)) ...
	    *ceil(rects(i).secondPoint(2) - rects(i).firstPoint(2));
end
iSub = zeros(ceil(maxArea), 1);
jSub = zeros(ceil(maxArea), 1);

counter =  0;
for i = 1:length(rects)
  for x = ceil(rects(i).firstPoint(1)):floor(rects(i).secondPoint(1))
    yPoints = (ceil(rects(i).firstPoint(2)):floor(rects(i).secondPoint(2)))';
    numPoints = length(yPoints);
    iSub((counter+1):(counter+numPoints)) = yPoints;
    jSub((counter+1):(counter+numPoints)) = x;
    counter = counter + numPoints;
  end
end
iSub = iSub(1:counter)';
jSub = jSub(1:counter)';


