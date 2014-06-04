% TestStepHor(ax,ay,bx,by,Numphases)
% check for n equi-phase steps in horizontal

% 2014 May, Hui-Wen Lu-Walther, Ronny Foerster

function StepHor=TestStepHor(ax,ay,bx,by,Numphases)


if ay==0
    StepHor=false;  % grating is horizontal no step possible
    
elseif by==0
    StepHor=(mod(bx,Numphases)==0);   %lattice vector horizontal
    
else  %one vector over and the other under the horizon
    if gcd(ax, ay)>1
        ax2=ax/gcd(ax, ay);
        ay2=ay/gcd(ax, ay);
        
        StepHor=(mod(lcm(abs(ay2),abs(by))*(ax2/ay2-bx/by),Numphases)==0);
    else
        
        StepHor=(mod(lcm(abs(ay),abs(by))*(ax/ay-bx/by),Numphases)==0);
    end
end
end