% FourDimGrating2png_HW(gratingparameter, Numdir, Numphase, pngortif, foldername)
% produce pictures of the gratings including asigned phase steps
% produce 1-bit png images / tif images
% Also check equi-phase steps and generate a .txt file afterward

% Numdir: # of grating orientations
% Numphase: # of grating phase shifts
% pngortif: '1' .png, '0' .tif
% foldername: should be a string

% Example:
% .png
% FourDimGrating2png_HW([5 17 25 39 19 9;-26 -19 -9 8 17 25;2 19 33 6 17 9;4 -17 -9 4 19 33],3,3,1,'o3p3_LSIM')

% .tif
% FourDimGrating2png_HW([5 17 25 26 19 9;-26 -19 -9 5 17 25;2 19 33 30 17 9;4 -17 -9 3 19 33],3,3,0,'o3p3_LSIM')

% 2014 May, Hui-Wen Lu-Walther, Ronny Foerster

function FourDimGrating2png_HW(gratingparameter, Numdir, Numphase, pngortif, foldername)
if nargin<3
    Numphase=9
end
if nargin<2
    Numdir=6
end

if nargin<4
    pngortif=1
end

if nargin<5
    if pngortif==1
        foldername=sprintf('o%dp%d_PNG',Numdir,Numphase);
    else
        foldername=sprintf('o%dp%d_tif',Numdir,Numphase);
    end
end
%% Creating folder
mkdir(foldername) %Make new directory
cd(foldername) %Change working directory


%% Create gratings and save as PNG/Tiff file

%resolution of the SLM
pixels_slm=[1280 1024];
% if you want to have small size of grating images for testing, then define
% pixels_slm smaller
% example: pixels_slm=[128 128];

%phase step
phasestep=2*pi/Numphase;  

%WARNING DIP IMAGE CHANGES x and y direction
grating=zeros(pixels_slm(2),pixels_slm(1),Numdir,Numphase);

for number=1:Numdir   
    
    gratdir=GratingDir(gratingparameter(1,number),gratingparameter(2,number));
    gratper=GratingPer(gratingparameter(1,number),gratingparameter(2,number),gratingparameter(3,number),gratingparameter(4,number));
    
    %calculate wavevector % k=(kx, ky)
    k=2*pi/gratper*[sin(gratdir); cos(gratdir)];
    
    for phase=1:Numphase
        
            grating(:,:,number,phase)=sin(xx(pixels_slm).*k(1)+yy(pixels_slm).*k(2)+1E-4+phase*phasestep);
%             grating        
        savegrat=double(grating(:,:,number,phase));
        
        if pngortif==1
%             MeasureorDeEx==0
            filename=sprintf('dir%dstep%d.png',number,phase);           
            imwrite(savegrat,filename,'png','bitdepth',1);            
        else
            filename=sprintf('dir%dstep%d.tif',number,phase);
            imwrite(savegrat,filename,'tif');            
        end        
    end
end
filename=strcat('GratingParameters','.txt');
fid = fopen(filename,'w');
a=mat2str(gratingparameter);
fprintf(fid,'GratingParameters=%s\n\n',a);

%dip_image(grating)

PhaseCheck(gratingparameter, Numdir, Numphase, pngortif)

fclose(fid);
end