function objectDelete(object)

% OBJECTDELETE Clear up the graphics that portray and object.

% DRAWING

for i = 1:length(object)
  try
    delete(object(i).handle)
  catch
  end
  try
    delete(object(i).controlPointHandle)
  catch
  end
end