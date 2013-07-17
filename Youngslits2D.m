function [cont] = Youngslits2D(field1,ps)
% plot visibility vs pinhole separation
% function [visibility,dx] = Youngslits2D(field1,ps)
% inputs: field1 - complex field at input plane
%         ps - pixel size [m]
% outputs:visibility - visibility vs. slit separation
%         dx - slit separation
%
% Laura Waller, 2011 Princeton University, lwaller@alum.mit.edu
[n,nummodes]=size(field1);
for x1=1:n
    for x2=1:n    %pinhole separation distance in pixels
        mask=zeros(n,1);mask(x1)=1;mask(x2)=1;
        for nn=1:nummodes
            kcoh(:,nn)=fftshift(fft(mask.*field1(:,nn)));
        end
        cInt=mean(abs(kcoh.^2),2);
        %figure(4);plot(cInt);v=axis;v(3)=0;v(4)=5;axis(v);
        %drawnow;pause(0.1)
        cont(x1,x2)=(max(cInt)-min(cInt))/(max(cInt)+min(cInt));
        if x1==x2
            cont(x1,x2)=mean(cInt);
        end
    end
    x1
    %figure(25);plot(cont(x1,:),'Linewidth',2)
    %xlabel('double pinhole separation [um]');ylabel('Fringe Visibility')
end
cont=fliplr(flipud(cont));