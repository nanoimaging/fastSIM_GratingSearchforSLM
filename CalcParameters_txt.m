% CalcParameters_txt(gratingparameter)
% calculates the parameters of a set of gratings and write them in a .txt
% file.
% Example: CalcParameters_txt([5 17 12 39 19 4;-26 -19 -4 8 17 12;2 19 3 6 17 2;4 -17 -4 4 19 -3])

% 2014 May, Hui-Wen Lu-Walther and Ronny Foerster


function CalcParameters_txt(gratingparameter,Numdir)

filename=strcat('GratingParameters','.txt'); 
fid = fopen(filename,'a'); 
%% Basic parameters
for number=1:Numdir   
    gratdir(number)=GratingDir(gratingparameter(1,number),gratingparameter(2,number));
    gratper(number)=GratingPer(gratingparameter(1,number),gratingparameter(2,number),gratingparameter(3,number),gratingparameter(4,number));
end
a= mat2str(gratingparameter);

fprintf(fid,'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \n');
fprintf(fid,'CalcParameters_txt(%s)\n\n',a);
fprintf(fid,'gratdir= ');
fprintf(fid,'%.4f  ',gratdir);
fprintf(fid,'\r\n');
fprintf(fid,'gratper= ');
fprintf(fid,'%.4f  ',gratper);
fprintf(fid,'\r\n');
%angles between the different directions and deviation
angles=[gratdir(2:end)-gratdir(1:end-1) gratdir(1)-gratdir(end)+(pi)];
eachangle=(gratdir(1:end))/2/pi*360;  
fprintf(fid,'eachangle= ');
fprintf(fid,'%.4f  ',eachangle);
fprintf(fid,'\r\n');
angles=angles/2/pi*360; % angle difference between the next one_HW
fprintf(fid,'angles= ');
fprintf(fid,'%.4f  ',angles);
fprintf(fid,'\r\n');
% disp('deviation of the perfect 30° angle:')

if Numdir==6
fprintf(fid,'deviation of the perfect 30° angle= ');
else
    fprintf(fid,'deviation of the perfect 60° angle= ');
end

fprintf(fid,'%.4f  ',abs(angles-(180/Numdir)));
fprintf(fid,'\r\n');
%grating period and deviation in %
% disp('average grating periode:')
per=sum(gratper)/Numdir;
fprintf(fid,'average grating periode= ');
fprintf(fid,'%.4f  ',per);
fprintf(fid,'\r\n');
% disp('deviation of the single orientations in %:')
divgp=(gratper-per)/per*100;

fprintf(fid,'deviation of the single orientations in percentage = ');
fprintf(fid,'%.4f  ',divgp);
fprintf(fid,'\r\n\n');

fclose(fid);
%% Unwanted orders test and write result into a txt file or not
TestUnwantedOrders(gratingparameter,Numdir, 1)


end
