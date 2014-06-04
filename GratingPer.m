% Calculates the Grating periode

% 2014 May, Hui-Wen Lu-Walther, Ronny Foerster

function g=GratingPer(ax,ay,bx,by)

phi=GratingDir(ax,ay);
theta=GratingDir(bx,by);
g=hypot(bx,by)*abs(sin(phi-theta));
end