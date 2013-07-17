function [as] = smooth2D(a,n,d)
% smooth in two dimensions
% inputs: a - input 2d variable
%         n - amount of smoothing by
%         d - dimension number
as=zeros(size(a));
if d==1
    for k=1:size(a,2)
        as(:,k)=smooth(a(:,k),n);
    end
else
    for k=1:size(a,1)
        as(k,:)=smooth(a(k,:),n);
    end
end

        