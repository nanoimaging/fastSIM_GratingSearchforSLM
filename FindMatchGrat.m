% [matchgrat,numacceptgrat]=FindMatchGrat(gratpara,numgrat,para,Numdir )
% systematically searches for 6 gratings of matching angles

% gratpara: gratingparameters
% numgrat: number of gratings which are found in the previous process
% para: required parameters
% Numdir: 3 or 6 grating orientations

% 2014 May, Hui-Wen Lu-Walther, Ronny Foerster

function [matchgrat,numacceptgrat]=FindMatchGrat(gratpara,numgrat,para,Numdir )
%sort gratpara(grating parameters and properties) after angles
[angles,order] = sort(gratpara(:,5));
gratpara = gratpara(order,:);

%number of accepted gratings
numacceptgrat=0;
matchgrat=zeros(4,Numdir,1);   

%calc boundaries of angles for an efficient next loop
if Numdir==6
    gratmax1=max(find(angles+(5*para.angledif)+para.tolangle<(pi/2)));
    gratmax2=max(find(angles+(4*para.angledif)+para.tolangle<(pi/2)));
    gratmax3=max(find(angles+(3*para.angledif)+para.tolangle<(pi/2)));
    gratmax4=max(find(angles+(2*para.angledif)+para.tolangle<(pi/2)));
    gratmax5=max(find(angles+(para.angledif)+para.tolangle<(pi/2)));
else
    gratmax1=max(find(angles+(2*para.angledif)+para.tolangle<(pi/2)));
    gratmax2=max(find(angles+(para.angledif)+para.tolangle<(pi/2)));
end


disp('find matching gratings')
if Numdir==6
    for grat1=1:gratmax1   
        round(grat1/gratmax1*100)
        
        for grat2=grat1+1:gratmax2
            if abs(angles(grat1)-angles(grat2)+para.angledif)>para.tolangle
                continue
            end
            
            for grat3=grat2+1:gratmax3
                if abs(angles(grat1)-angles(grat3)+2*para.angledif)>para.tolangle
                    continue
                end
                
                for grat4=grat3+1:gratmax4
                    if abs(angles(grat1)-angles(grat4)+3*para.angledif)>para.tolangle
                        continue
                    end
                    
                    for grat5=grat4+1:gratmax5
                        if abs(angles(grat1)-angles(grat5)+4*para.angledif)>para.tolangle
                            continue
                        end
                        
                        for grat6=grat5+1:numgrat
                            if abs(angles(grat1)-angles(grat6)+5*para.angledif)>para.tolangle
                                continue
                            end
                            
                            numacceptgrat=numacceptgrat+1;
                            matchgrat(:,1,numacceptgrat)=gratpara(grat1,1:4);
                            matchgrat(:,2,numacceptgrat)=gratpara(grat2,1:4);
                            matchgrat(:,3,numacceptgrat)=gratpara(grat3,1:4);
                            matchgrat(:,4,numacceptgrat)=gratpara(grat4,1:4);
                            matchgrat(:,5,numacceptgrat)=gratpara(grat5,1:4);
                            matchgrat(:,6,numacceptgrat)=gratpara(grat6,1:4);
                            
                        end
                    end
                end
            end
        end
    end
else
    for grat1=1:gratmax1   
        round(grat1/gratmax1*100)
        
        for grat2=grat1+1:gratmax2
            if abs(angles(grat1)-angles(grat2)+para.angledif)>para.tolangle
                continue
            end
            
            for grat3=grat2+1:numgrat
                if abs(angles(grat1)-angles(grat3)+2*para.angledif)>para.tolangle
                    continue
                end
                
                numacceptgrat=numacceptgrat+1;
                matchgrat(:,1,numacceptgrat)=gratpara(grat1,1:4);
                matchgrat(:,2,numacceptgrat)=gratpara(grat2,1:4);
                matchgrat(:,3,numacceptgrat)=gratpara(grat3,1:4);
                
            end
        end
    end
end

end