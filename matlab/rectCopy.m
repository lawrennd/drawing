function newRect = rectCopy(rect);

% RECTCOPY Copies a rect structure into a new rect structure.

% DRAWING

newRect = rect;
newRect.handle = [];
newRect.controlPointHandle = [];