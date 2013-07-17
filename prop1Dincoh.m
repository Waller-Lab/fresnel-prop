function [field1,h] = prop1Dincoh(field1,lambda,ztot,ps,zpad,n0)
% propagate a PARTIALLY COHERENT field
% function [field1] = prop1Dincoh(field1,lambda,ztot,ps,zpad,n0)
% inputs: field1 - complex field at input plane with dimensions (x,modes)
%         lambda - wavelength of light [m]
%         ztot - propagation distance (can be negative)
%         ps - pixel size [m]
%         zpad - size of propagation kernel desired
%         n0 - index of refraction of medium
% outputs:field2 - propagated complex field
%         h - propagation kernel to check for aliasing
%
% Laura Waller, June 2010, Princeton University, lwaller@alum.mit.edu

n=size(field1,1);
nummodes=size(field1,2);
Iz=mean(abs(field1.^2),2);
for nn=1:nummodes
    fieldnn=field1(:,nn);
    [field1(:,nn),h]=propagate1D(fieldnn,lambda,ztot/n0,ps,zpad);
end
   