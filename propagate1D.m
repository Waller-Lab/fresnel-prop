function [field2,H] = propagate1D(field1,lambda,z,ps,zpad)
% propagate a 1D field in z using Fresnel transfer function in FD
% function [field2,H] = propagate1D(field1,lambda,z,ps,zpad)
% inputs: field1 - 1D complex field at input plane
%         lambda - wavelength of light [m]
%         z - propagation distance [m] (can be negative)
%         ps - pixel size [m] (default is 12microns)
%         zpad - size of propagation kernel desired
% outputs:field2 - propagated complex field
%         H - propagation kernel to check for aliasing

m=length(field1);
if nargin==5
    M=zpad;
elseif nargin==4
    M=m;
else
    M=m;
    ps=12*10^-6;
end
x=[-M/2+1:M/2].';
x=x/(ps*M);     %width of CCD [m]
k=2*pi/lambda;
H=exp(i*k*z)*exp(-i*pi*lambda*z*(x.^2));
ff=ones(M,1);
ff(1:m)=field1;
objFT=fftshift(fft(ff));
field2=(ifft(fftshift(objFT.*H)));

field2=field2(1:m);

% subplot(2,2,1);imagesc(abs(field1));colorbar;title('field1 (amp)')
% subplot(2,2,2);imagesc(angle(field1));colorbar;title('field1 (phase)')
% subplot(2,2,3);imagesc(abs(field2));colorbar;title('field2 (amp)')
% subplot(2,2,4);imagesc(angle(field2));colorbar;title('field2 (phase)')
% colormap gray;
