% calculates grating direction

% 2014 May, Hui-Wen Lu-Walther, Ronny Foerster


function phi=GratingDir(x,y)

if x==0
    phi=pi/2;
else
    phi=atan(y/x);
end

end