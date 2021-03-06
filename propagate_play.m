%check that kernel isn't aliased
[m,n]=size(field);
zpad=3000;
    tic
[x,y]=meshgrid(-zpad/2+1:zpad/2, -zpad/2+1:zpad/2);
x=x/ps*zpad;     %width of CCD [m]
y=y/ps*zpad;     %height of CCD [m]
k=2*pi/lambda;
for z=-[0.05:0.05:0.2]
    H=exp(i*k*z)*exp(-i*pi*lambda*z.*(x.^2+y.^2));
    clear X;clear Y;clear x;clear y
    objFT=fftshift(fft2(field,zpad,zpad));
    field2=(ifft2(fftshift(objFT.*H)));
    cplot(field2(1:m,1:n));title(z)
    %imagesc(real(H));axis image
    toc
end

% % find focus
% for z=[0.02:0.005:0.04]
%     figure;
%     imagesc(abs(propagate(hologram,lambda,-z)));colorbar
%     title(z)
%     drawnow
% end