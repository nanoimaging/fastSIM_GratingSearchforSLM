% produce FT out of grating parameters

%2012 Ronny Foerster

function fourier=GratPara2FT(para,pixels_slm,illu)

gratdir=GratingDir(para(1),para(2));
gratper=GratingPer(para(1),para(2),para(3),para(4));

%calculate wavevector
k=2*pi/gratper*[sin(gratdir); cos(gratdir)];

%calculate grating
grating=sin(pi/2+xx(pixels_slm).*k(1)+yy(pixels_slm).*k(2)+1E-4)>0;  %discrete 1/0 grating
grating=grating*2-1;  %1/-1 grating
%calculate FourierTransform
fourier=ft(illu .* grating);

end