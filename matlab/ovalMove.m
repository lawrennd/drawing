function ovals = ovalMove(ovals, moveVector);

% OVALMOVE Moves a oval to a new point.

% DRAWING

for i = 1:length(ovals)
  ovals(i).centre = ovals(i).centre + moveVector;
  ovals(i) = ovalDraw(ovals(i));
end