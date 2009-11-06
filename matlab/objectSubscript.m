function [iSub, jSub] = objectSubscript(object);

% OBJECTSUBSCRIPT Gives the subscript of pixels which fall within an object.

% DRAWING

[iSub, jSub] = feval([object.type 'Subscript'], object);
