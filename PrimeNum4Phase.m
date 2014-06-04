% PrimeNum4Phase(gratingparameter)
% Calculate possible equi-phase steps, the multiple of prime numbers are
% possible equi-phase steps as well. The result will be written in a .txt
% file.

% Example: PrimeNum4Phase([5 17 12 39 19 4;-26 -19 -4 8 17 12;2 19 3 6 17 2;4 -17 -4 4 19 -3])

% 2014 May, Hui-Wen Lu-Walther and Martin Kielhorn



function PrimeNum4Phase(gratingparameter)
filename=strcat('GratingParameters','.txt');
fid = fopen(filename,'a');

for i=1:size(gratingparameter,2)
    q=transpose(gratingparameter(:,i));
    [v h minp]=stepvh(q);  
    k=factor(abs(v));
    q=factor(abs(h));
    
    fprintf(fid,'grating%d\n',i);
    fprintf(fid,'AllowedPhaseStepinVertical= ');
    fprintf(fid,'%d  ',k);
    fprintf(fid,'\r\n');    
    fprintf(fid,'AllowedPhaseStepinHorizontal= ');
    fprintf(fid,'%d ',q);
    fprintf(fid,'\r\n');   
    fprintf(fid,'AllowedMinimumPhaseStep= ');
    fprintf(fid,'%f  degree ',minp);
    fprintf(fid,'\r\n');

end
fprintf(fid,'\r\n');
fclose(fid);
end
