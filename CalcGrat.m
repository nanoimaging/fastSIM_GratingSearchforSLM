% CalcGrat(gratpermin,gratpermax, Hsteps, Vsteps, Numdir)
% for searching 3 or 6 orientations of gratings.
% This code only work with either 3 grating orientations or 6 grating
% orientations.
% Example: CalcGrat(2.800, 2.850, 3, 1, 3)
% Example: CalcGrat(2.700, 2.850, 9, 4, 6)

% gratpermin: minumum grating period (unit: in pixels)
% gratpermin: maximum grating period (unit: in pixels)
% Hsteps: # of equi-phase steps in x
% Vsteps: # of equi-phase steps in y
% Numdir: 3 or 6 orientations of gratings


% The following boundaries parameters have to be defined manually as in this example
% para.axmax=28;   % large number is required for 6 Numdir, eg. 40
% para.aymax=28;   % large number is required for 6 Numdir, eg. 40
% para.bxmax=28;   % large number is required for 6 Numdir, eg. 40
% para.bxmin=2;
% para.bymax=28;   % large number is required for 6 Numdir, eg. 40
% para.bymin=2;

% 2014 May, Hui-Wen Lu-Walther, Ronny Foerster


function CalcGrat(gratpermin,gratpermax, Hsteps, Vsteps, Numdir)

%% declarations
%define boundaries of parameters
para.axmax=28;  % large number required for 6 Numdir, eg. 40
para.aymax=28;
para.bxmax=28;
para.bxmin=2;
para.bymax=28;
para.bymin=2;
%grating periode
para.gratpermin=gratpermin; 
para.gratpermax=gratpermax; 

para.angledif=pi/Numdir;  % in rad
%tolerance angle (1 degree = 0.01745 rad)
para.tolangle=0.01745;

%Due to floating number problems in comparisons
para.tol=1e-6;

%% calculate gratin parameters
%array includs the parameters and the consequently directions and periods of all possible gratings
gratpara(1,7)=0;

%number of gratings
numgrat=0;

disp('calculate grating properties out of the parameters')
for ax=0:para.axmax
    round(ax/para.axmax*100) %display value from 1 to 100
    for ay=-para.aymax:para.aymax
        gratdir=GratingDir(ax,ay); %calc grating dir --> independent from bx and by
        
        
        for bx=para.bxmin:para.bxmax
            for by=-para.bymax:para.bymax
                if abs(by)<=para.bymin continue
                end
                
                
                gratper=GratingPer(ax,ay,bx,by); %calculate grating period                
                
                %test phase steps
                if gratper>para.gratpermin && gratper<para.gratpermax
                    
                    %check if parameters are new
                    %first check if the direction is already known?
                    equaldir=find(abs(gratpara(:,5)-gratdir)<para.tol);
                    %seconds ADDITIONALLY the periode or first test was already negative?
                    if size(find(abs(gratpara(equaldir,6)-gratper)<para.tol),2)==0 || isempty(equaldir) 
%                     if  isempty(equaldir)                     
                        
                        if TestStepHor(ax,ay,bx,by,Hsteps) && TestStepVer(ax,ay,bx,by,Vsteps)                  
                            %include 0 in array
                            %save in array
                            numgrat=numgrat+1;
                            gratpara(numgrat,:)=[ax,ay,bx,by,gratdir,gratper,0];
                             
                        elseif TestStepVer(ax,ay,bx,by,Hsteps) && TestStepHor(ax,ay,bx,by,Vsteps)  
                            %include 1 i array
                            %save in struct
                            numgrat=numgrat+1;
                            gratpara(numgrat,:)=[ax,ay,bx,by,gratdir,gratper,1];

                        end
                    end
         
                end
                
            end
        end
    end
end


gratpara
numgrat


%% find matching gratings

[matchgrat,numacceptgrat]=FindMatchGrat(gratpara,numgrat,para,Numdir)


numgrat
numacceptgrat


%% create and rate Fourierplane
disp('Simulate Fourier plane')


TestUnwantedOrders(matchgrat,Numdir)


    