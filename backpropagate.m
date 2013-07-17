function [objBP,zf] = backpropagate(ph,Amp,colour)
% back propagate in z to digitally focus a hologram
% inputs: ph - output phase map
%         Amp - output amplitude map
%         Colour - 0 for green laser, anything else for red
% outputs:objBP - backpropagated complex field
%         zf- distance [m] it is reconstructed at

if colour==0
    lambda=532*10^(-9);
else
    lambda=632.8*10^(-9);
end
[m,n]=size(ph);
[x,y]=meshgrid(-n/2+1:n/2, -m/2+1:m/2);

ps=0.000012;      %pixel spacing [m]
z0=0.02;         %reconstruction start distance [m]
zs=0.04;         %z step [m]
nz=10;            %number of z steps

H=zeros(m,n,nz);
for zz=1:nz
    z=z0+zs*(zz-1);
    %Fresnel propogation TF
    H(:,:,zz)=exp(i*pi*lambda*2*z.*((x/(m*ps)).^2+(y/(n*ps)).^2));
end
objFT=fftshift(fft2((Amp.*exp(i*ph))));

%look for best focus
figure(1);set(1,'Position',[650,50,1200,500]);
for kk=1:nz
    z=z0+zs*(kk-1);
    objBP=(ifft2(fftshift(objFT.*H(:,:,kk))));
    subplot(2,1,1);imagesc(phaseo(objBP));colorbar;title(sprintf('plot %d',kk))
    subplot(2,1,2);imagesc(abs(objBP));colorbar;title(sprintf('z = %0.5g cm',z*100))
    colormap gray;
    pause;
end
zff=input('best reconstruction plot number = ');
zf=z0+zs*(zff-1)

objBP=(ifft2(fftshift(objFT.*H(:,:,zff))));
