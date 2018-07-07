%
% Linear Regression
%
function[alpha,stat]=Ramesh_linearRegression(x,y,n)

stat=1;
alpha=NaN;

[mx,nx]=size(x);

[my,ny]=size(y);

if mx==1
    x=x';
end
if my==1
    y=y';
end
if length(x)~=length(y)
    return;
end
if length(x) <= n-1
    return;
end
m=length(x);
A=zeros(m,n+1);
for i = 1:m
    for j=1:n+1
       A(i,j)= x(i)^(n+1-j);
    end
end
alpha=(A'*A)\(A'*y);
stat=0;
%w = min(x):0.01:max(x);
%f1 = polyval(alpha,w);
%figure(1)
%      plot(x,y,'d')
%      hold on
%      plot(w,f1)
end

