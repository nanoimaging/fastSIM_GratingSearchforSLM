function ShowGrating(gratingparameter,Numdir)
%show grating
pixels_slm=[512 512]

showgrating=zeros(pixels_slm(1),pixels_slm(1),Numdir);

for number=1:Numdir   
    gratdir=GratingDir(gratingparameter(1,number),gratingparameter(2,number));
    gratper=GratingPer(gratingparameter(1,number),gratingparameter(2,number),gratingparameter(3,number),gratingparameter(4,number));

    %calculate wavevector
    k=2*pi/gratper*[sin(gratdir); cos(gratdir)];

    showgrating(:,:,number)=sin(pi/2+xx(pixels_slm).*k(1)+yy(pixels_slm).*k(2)+1E-4)>0;

end

showgrating=showgrating*2-1;

dip_image(showgrating)

end