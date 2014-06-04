% TestStepVer(ax,ay,bx,by,Numphases)
% check for n equi-phase steps in horizontal

% 2014 May, Hui-Wen Lu-Walther, Ronny Foerster

function StepVer=TestStepVer(ax,ay,bx,by,Numphases)


if ax==0
    StepVer=false;  % grating is vertical no step possible
    
elseif bx==0
    StepVer=(mod(by,Numphases)==0);
else
    
    if gcd(ax, ay)>1
        ax2=ax/gcd(ax, ay);
        ay2=ay/gcd(ax, ay);
        
        StepVer=(mod(lcm(abs(ax2),abs(bx))*(ay2/ax2-by/bx),Numphases)==0);
    else
        StepVer=(mod(lcm(abs(ax),abs(bx))*(ay/ax-by/bx),Numphases)==0);
    end
end
end