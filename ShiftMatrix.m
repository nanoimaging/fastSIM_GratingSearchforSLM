% 2012 Ronny Foerster


function result=ShiftMatrix(matrix,shift)
%2D shift of a matrix/image

[height width]=size(matrix);


matrix(1:(height-shift(1)),1:(width-shift(2)));
result(height, width)=0;

result(1+shift(1):height,1+shift(2):width)=matrix(1:(height-shift(1)),1:(width-shift(2)));






% for i=1:height
%     i
%     if i+a(1)>width | i+a(1)<1
%         B(i,:)=0;
%     else
%         for j=1:width
%             if j+a(2)>height | j+a(2)<1
%                 B(i,j)=0;
%             else
%                 B(i,j)=A(i+a(1),j+a(2));
%             end
%         end
%     end
% end





end