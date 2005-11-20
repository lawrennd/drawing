function [iSub, jSub] = ovalPerimeter(ovals);

% OVALPERIMETER Returns the subscripts of any pixels that fall on the perimeter of the ovals.

% DRAWING
maxCirc = 0;
for i = 1:length(ovals)
  maxCirc = maxCirc + 2*(ovals(i).xradius + ovals(i).yradius);
end
iSub = zeros(ceil(maxCirc), 1);
jSub = zeros(ceil(maxCirc), 1);
counter = 0;

for i = 1:length(ovals)
  
  % Get a square which contains the circle
  leftSquare = floor(ovals(i).centre(1) - ovals(i).xradius);
  rightSquare = ceil(ovals(i).centre(1) + ovals(i).xradius);
  bottomSquare = ceil(ovals(i).centre(2) + ovals(i).yradius);
  topSquare = floor(ovals(i).centre(2) - ovals(i).yradius);
  
  
  % Find index of pixels whose centre is within the circle
  xRadius2 = (ovals(i).xradius*ovals(i).xradius);
  for x = leftSquare:rightSquare
    xPos = x - ovals(i).centre(1); % Centre of x pixel    
    xPart = (xPos*xPos)/xRadius2;
    if xPart <= 1
       yPos = sqrt((1 - xPart))*ovals(i).yradius;
       y1 = ceil(ovals(i).centre(2) - yPos);
       y2 = floor(ovals(i).centre(2) + yPos); 
       counter = counter + 1;
       iSub(counter) = y1;
       jSub(counter) = x;
       if y1 ~= y2
	 counter = counter + 1;
	 iSub(counter) = y2;
	 jSub(counter) = x;
       end
    end
  end
  for y = topSquare:bottomSquare
    yPos = y - ovals(i).centre(2); % Centre of x pixel    
    yPart = (yPos*yPos)/(ovals(i).yradius*ovals(i).yradius);
    if yPart <= 1
      xPos = sqrt((1 - yPart))*ovals(i).xradius;
      x1 = ceil(ovals(i).centre(1) - xPos);
      x2 = floor(ovals(i).centre(1) + xPos); 
      if ~any(iSub == y & (jSub == x1))
	counter = counter + 1;
	jSub(counter) = x1;
	iSub(counter) = y;
      end
      if ~any(iSub == y & (jSub == x2))
	counter = counter + 1;
	jSub(counter) = x2;
	iSub(counter) = y;
      end
    end    
  end
end
iSub = iSub(1:counter)';
jSub = jSub(1:counter)';




