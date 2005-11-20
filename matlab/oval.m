function handle = oval(centres, radiiX, radiiY, handle)

% OVAL Creates an oval object.

% DRAWING

t = 0:pi/24:2*pi;
x = centres(:, 1)*ones(size(t)) + radiiX*sin(t);
y = centres(:, 2)*ones(size(t)) + radiiY*cos(t);

if nargin > 1
  if nargin < 4
    handle = line(x', y');
  else
    if length(handle) ~= size(centres, 1)
      error('Number of handles must equal number of centres')
    end
    for i = 1:length(handle)
      set(handle(i), 'XData', x(i, :)', 'YData', y(i, :)');
    end
  end
else
  ovals = centres;
  for i = 1:length(ovals)
    x = ovals(i).centres(1)*ones(size(t)) + ovals.xradius*sin(t);
    y = ovals(i).centres(2)*ones(size(t)) + ovals.yradius*sin(t);
    if isfield(ovals(i), 'handle')
      set(ovals.handle(i), 'XData', x', 'YData', y');
    else
      ovals(i).handle = line(x', y');
    end
  end
end
    
      
