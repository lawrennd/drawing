function handle = rect(firstPoint, secondPoint, handle)

% RECT Create a rectangle.

% DRAWING

x = [firstPoint(:, 1) firstPoint(:, 1) ...
     secondPoint(:, 1) secondPoint(:, 1) firstPoint(:, 1) ];
y = [firstPoint(:, 2) secondPoint(:, 2) ...
     secondPoint(:, 2) firstPoint(:, 2) firstPoint(:, 2)]; 

if nargin < 3
  handle = line(x', y');
else
  if length(handle) ~= size(firstPoint, 1)
    error('Number of handles must equal number of centres')
  end
  for i = 1:length(handle)
    set(handle(i), 'XData', x(i, :)', 'YData', y(i, :)');
  end
end
