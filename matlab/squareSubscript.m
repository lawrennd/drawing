function [iSub, jSub] = squareSubscript(squares)
% SQUARESUBSCRIPT Returns the subscripts of any pixels that would fall inside the square

% DRAWING

rects = square2rects(squares);
[iSub, jSub] = rectsubscript(rects);