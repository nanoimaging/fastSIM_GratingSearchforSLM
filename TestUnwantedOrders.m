% TestUnwantedOrders(matchgrat,Numdir, wintxt)
% Sum the Fourier transform of all 6 orientations which convolves with
% residual diffraction orders.
% matched gratings found, all the parameters will be written in a .txt
% file.

% matchgrat: gratingparameters
% Numdir: 3 or 6 orientations of gratings
% wintxt: 1: write Unwanted Orders Information in a .txt file.; 0:when


% Example for manually check: 
% TestUnwantedOrders([5 17 12 39 19 4;-26 -19 -4 8 17 12;2 19 3 6 17 2;4 -17 -4 4 19 -3])

% 2014 May, Hui-Wen Lu-Walther, Ronny Foerster

function TestUnwantedOrders(matchgrat,Numdir, h, miniunwanted, wintxt)


if nargin<3
    h=10;
end

if nargin<4
    miniunwanted=0.03;
end

if nargin<5
    wintxt=0;
end

%% define the position of residual orders original from SLM in fourier plane_HW
pixels_slm=[512 512]; % # of pixels on SLM

residual=zeros(pixels_slm);

residual(1,256)=0.08; % Top
residual(512,256)=0.08; % Bottom
residual(128,1)=0.03; % Top Left
residual(384,1)=0.03; % Bottom Left
residual(128,512)=0.03; % Top Right
residual(384,512)=0.03; % Bottom Right
% zero order
residual(256,256)=1;  
% residual=gaussf(abs(residual),1); 
% dip_image(residual);
%%
pixels_slm=[512 512];

fourier=zeros(pixels_slm);
sumfourier=zeros(pixels_slm);

%illuminate the SLM with a gaussian beam
s=pixels_slm(1)/5;          %standard deviation of the gauss
illu=exp(-(rr(pixels_slm)).^2 / s.^2);  %calculate gaussian beam exp(r^2/s^2)

%holessize: square half edge length
% h=10;    
unwantedorder=zeros(2*h+1,2*h+1,Numdir);  

succesfull=false;%set to true if a grating is found

l=1; % loop variable

for i=1:size(matchgrat,3)  % # of match gratings found
    for j=1:size(matchgrat,2)   
        % calculate grating parameters
        fourier(:,:,j)=GratPara2FT(matchgrat(:,j,i),pixels_slm,illu);
                 fourier(:,:,j)=dip_image(fourier(:,:,j)); % show FT of each grating 20140320 HW
    end
        
    sumfourier(:,:)=sum(fourier,3); 
    convsumfourier=conv2(residual, sumfourier(:,:),'same');  
    convsumfourier=ShiftMatrix(convsumfourier,[1 1]);
    
%          dip_image(convsumfourier) 
%          dip_image(sumfourier)
    
    %bool which is set to false, if any unwanted orders is too strong.
    maskoperates=true;
    
    %look for unwanted orders at the holes
    for j=1:Numdir   
        %calcposition first order
        %delete first order - look for maximum
        [maxfirst,posx,posy]=PosMax(fourier(:,:,j));
        
        %         dip_image(fourier(:,:,j))
        unwantedorder(:,:,j)=abs(convsumfourier(posy-h:posy+h,posx-h:posx+h))-abs(fourier(posy-h:posy+h,posx-h:posx+h,j));  % HW
        %       dip_image(abs(unwantedorder(:,:,j)))  
        %       sum(sum(abs(unwantedorder(:,:,j)),1),2) 
        %calculate if unwanted ordes are lower than a specific
        
        
        if wintxt==1
            Iunwanted=sum(sum(abs(unwantedorder(:,:,j)),1),2);
            filename=strcat('GratingParameters','.txt');
            fid = fopen(filename,'a')
            fprintf(fid,'%d.grating (%d, %d), ',j,posx,posy);
            fprintf(fid,'Imaxfirst=%.4f , Iunwanted=%.4f',maxfirst,Iunwanted);
            fprintf(fid,'\r\n');           
            fclose(fid);
        end
        
        % check if less than 3% of the light is in unwanted orders
        if sum(sum(abs(unwantedorder(:,:,j)),1),2)>maxfirst*miniunwanted  
            maskoperates=false;
            %             disp('Iunwanted too high')
            %             Iunwanted=sum(sum(abs(unwantedorder(:,:,j)),1),2);
            %             sprintf('%d. Imaxfirst=%.4f , Iunwanted=%.4f',j,maxfirst,Iunwanted)
        end
        
    end
    
    
    if maskoperates==true
        succesfull=true;
        disp('grating found !!!');
        matchgrat(:,:,i)
        
        if wintxt==0
            filename=strcat('Matchgratings','.txt');
            fid = fopen(filename,'a');
            fprintf(fid,'[');
            for w=1:4
                for u=1:Numdir
                    if u<Numdir
                        fprintf(fid,'%d ',matchgrat(w,u,i));
                    else fprintf(fid,'%d',matchgrat(w,u,i));
                    end
                end
                if w<4
                    fprintf(fid,';');
                end
            end
            fprintf(fid,'] ');
            fprintf(fid,'\r\n');
            fclose(fid);
            
            for j=1:Numdir
                dip_image(abs(unwantedorder(:,:,j)));
            end
            dip_image(fourier);
            ShowGrating(matchgrat(:,:,i),Numdir)            

            dip_image(convsumfourier)
            dip_image(unwantedorder);
            disp('Click on the FT images and continue next process');
            waitforbuttonpress;
            close all
            
            CalcParameters_txt(matchgrat(:,:,i),Numdir, h, miniunwanted);
            PrimeNum4Phase(matchgrat(:,:,i));
            
        end
        
    end
    a=round(l/size(matchgrat,3)*100);  
    disp([sprintf('Progress of testing unwanted orders  %d', a) '%.....']);
    l=l+1;
    sumfourier=zeros(pixels_slm);  
end

if succesfull==true
    disp('calculation succesfull!');
else
    disp('calculation NOT succesfull!')
end

%dip_image(sumfourier)

end