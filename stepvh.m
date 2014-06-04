% [v h minp]=stepvh(qq)
% check for n equi-phase steps in horizontal & vertical
% qq: gratingparameters

% 2014 May, Hui-Wen Lu-Walther, Martin Kielhorn


function [v h minp]=stepvh(qq)

minp=abs(720/(qq(3)*qq(2)-qq(4)*qq(1)));
q=int32(floor(qq));
ax=q(1);
ay=q(2);
bx=q(3);
by=q(4);
if gcd(ax, ay)>1
    ax2=ax/gcd(ax, ay);
    ay2=ay/gcd(ax, ay);

    p=lcm(abs(ay2),abs(by));
    h=idivide(ax2*p,ay2)-idivide(bx*p,by);    
    p=lcm(abs(ax2),abs(bx));
    v=idivide(ay2*p,ax2)-idivide(by*p,bx);
    
else   
    p=lcm(abs(ay),abs(by));
    h=idivide(ax*p,ay)-idivide(bx*p,by);    
    p=lcm(abs(ax),abs(bx));
    v=idivide(ay*p,ax)-idivide(by*p,bx);    
end

