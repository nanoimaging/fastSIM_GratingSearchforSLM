% PhaseCheck(m, Numdir, Numphase, pngortif,MeasureorDeEx)
% Check the phase of each images and see if those images have equiphasestep.

% m: gratingparameter
% Numdir: # of grating orientations
% Numphase: # of grating phase shifts
% pngortif: read timeseries images.  '1' .png, '0' .tif
% MeasureorDeEx:read timeseries images.  '0' LSIM images, '1' NLSIM Measure images, '2' NLSIM DeExcited images

% 2014 May, Hui-Wen Lu-Walther and Martin Kielhorn

function PhaseCheck(m, Numdir, Numphase, pngortif,MeasureorDeEx)

if nargin<4
    pngortif=0
end
if nargin<5
    MeasureorDeEx=0
end

gratdir=@(i)GratingDir(m(1,i),m(2,i));
gratper=@(i)GratingPer(m(1,i),m(2,i),m(3,i),m(4,i));

%calculate wavevector % k=(kx, ky)
% wave vector K locates at positon of the 1st order
k=@(i) 2*pi/gratper(i)*[sin(gratdir(i)); cos(gratdir(i))];
i=1;
posr= k(i)/(2*pi)*512;
posl=-k(i)/(2*pi)*512;

steps=Numphase;

for i=1:Numdir;
    phasestep=zeros(1,steps);
    for j=1:steps        

        if pngortif==1
            if MeasureorDeEx==0
                name=sprintf('dir%dstep%d',i,j);
            elseif MeasureorDeEx==1
                name=sprintf('Measure_dir%dstep%d',i,j);
            elseif MeasureorDeEx==2
                name=sprintf('DeEx_dir%dstep%d',i,j);
            end
            temp1=extract(readim([name '.png']), [512 512]);
            fttmp1=ft((temp1*2-1)*exp(-rr(512,512)^2/(80)^2));
            
        else
            name=sprintf('dir%dstep%d',i,j);
            temp1=extract(readim([name '.tif']), [512 512]);
            fttmp1=ft((temp1/255*2-1)*exp(-rr(512,512)^2/(80)^2));
            
        end
        
        posr= k(i)/(2*pi)*512;
        posl=-k(i)/(2*pi)*512;
        mask=exp(-((xx(512,512)-posr(1))^2+(yy(512,512)-posr(2))^2)/20)+ ...
            exp(-((xx(512,512)-posl(1))^2+(yy(512,512)-posl(2))^2)/20);
        conv=fttmp1.*mask;
        a=phase(conv(ceil(255-posr(1)+1),round(255-posr(2)+1)));
        
        phasestep(1,j)=a;
        
    end
    
    equiDiv=zeros(1,steps-1);
    for f=1:Numphase-1
        if phasestep(1, f+1)-phasestep(1,f)> 1
            equiDiv(1,f)=phasestep(1, f+1)-phasestep(1,f)-(2*pi);
        else
            equiDiv(1,f)=phasestep(1, f+1)-phasestep(1,f);
        end
        
    end
    
    filename=strcat('GratingParameters','.txt');
    fid = fopen(filename,'a');
    b=mat2str(phasestep,4);
    fprintf(fid,'%d. PhaseStep=%s\n',i,b);
    a=mat2str(equiDiv,4);
    fprintf(fid,'%d. equiPhaseStepDiv=%s\n',i,a);
    fclose(fid);
end
PrimeNum4Phase(m)
end


% hold off




