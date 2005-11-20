function squares = squareMove(squares, moveVector);

% SQUAREMOVE Moves a square to a new point.

% DRAWING

for i = 1:length(squares)
  squares(i).centre = squares(i).centre + moveVector;
  squares(i) = squareDraw(squares(i));
end
