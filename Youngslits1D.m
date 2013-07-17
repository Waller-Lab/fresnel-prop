function [cont,slitsep] = Youngslits1D(field1,ps)
% plot visibility vs pinhole separation
% function [visibility,dx] = Youngslits1D(field1,ps)
% inputs: field1 - complex field at input plane
%         ps - pixel size [m]
% outputs:visibility - visibility vs. slit separation
%         dx - slit separation
%
% Laura Waller, 2011 Princeton University, lwaller@alum.mit.edu
%field1=incohbeamIN;
[n,nummodes]=size(field1);
for ss=1:length(1:ceil(n/4))    %pinhole separation distance in pixels
    mask=zeros(n,1);mask(ceil(n/2))=1;mask(ceil(n/2)+ss)=1;
    for nn=1:nummodes
        kcoh(:,nn)=fftshift(fft(mask.*field1(:,nn)));
    end
    cInt=mean(abs(kcoh.^2),2);
    %figure(4);plot(cInt);v=axis;v(3)=0;v(4)=5;axis(v);
    %drawnow;pause(0.1)
    cont(ss)=(max(cInt)-min(cInt))/(max(cInt)+min(cInt));
    ss
end
slitsep=[1:length(cont)]*ps*10^6;
figure(5);plot(slitsep,cont,'Linewidth',2);hold on
xlabel('double pinhole separation [um]');ylabel('Fringe Visibility')
