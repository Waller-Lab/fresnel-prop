function [zf] = findfocus(hologram, lambda, zs)

%FINDFOCUS find the distance to best focus of a hologram
% function [zf] = findfocus(hologram, lambda, zs)
% lambda is the wavelength in meters
% zs is a vector of [start:step:stop]
% zf is the chosen best focus distance in meters

%figure;
for z=zs
    P=propagate(hologram, lambda, -z);
    subplot(2,1,1);imagesc(abs(P));
    subplot(2,1,2);imagesc(angle(P),[-pi pi]);
    colormap gray
    title(z)
    pause(0.5)
end
%zf=input('which was best distance?');
zf=1;