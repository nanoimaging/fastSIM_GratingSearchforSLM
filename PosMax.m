function [maxfirst,posx,posy]=PosMax(matrix)
%calculates value and position of the maximum in a 2D-array

maxfirst=max(max(matrix));
[posy,posx,value]=find(matrix==maxfirst);

maxfirst=abs(maxfirst);

end