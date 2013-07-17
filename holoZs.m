close all; clc
z=0.015; lambda=658*10^-9;
tic
%_________________test object______________________________________________
%load squiggle.mat; %get 'test' object

%load guyobj2.mat;
%TEST=(1-phantom(256)).*exp(i*pi*phantom(256));
TEST=ones(256,256);
TEST(127:130,127:130)=exp(i*pi*0.3);

frame=1;
for z=0:0.05:2
hologram=(abs(propagate(TEST,lambda/50,z))).^2;     %get test obj hologram
imagesc(hologram,[0 2]);colormap gray;axis off;colorbar
%mesh(hologram)
title(sprintf('z=%1.1f',z))
drawnow;pause(0.1)
M(frame)=getframe;
frame=frame+1;
end
movie2avi(M,'holoZs.avi');