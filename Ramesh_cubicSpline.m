
function [z,stat]=Ramesh_cubicSpline(x,y,varargin)
z=NaN;
stat=1;

if length(varargin)==1
    v = varargin{1};
elseif length(varargin)==0
    z=[];
else
    return;
end

%initializing the Delta Matrix
n=length(x);
deltaX=zeros((length(x)-1),1);
for i=1:(length(x)-1)
    deltaX(i)=x(i+1)-x(i);
end


% Assaigning values into the Delta Matrix
M=zeros(length(x)-2);
u=zeros(length(x)-2,1);
M(1,1) = 2*(deltaX(2)+deltaX(1));
M(1,2) = deltaX(2);
M(length(x)-2,length(x)-3)=deltaX(length(x)-2);
M(length(x)-2,length(x)-2)=2*(deltaX(length(x)-2)+deltaX(length(x)-1));

u(1)=6*(((y(3)-y(2))/(deltaX(2)))-((y(2)-y(1))/deltaX(1)));
u(length(x)-2)=6*(((y(n)-y(n-1))/(deltaX(n-1)))-((y(n-1)-y(n-2))/deltaX(n-2)));


for j=2:(length(x)-2)
    M(j,j)=2*(deltaX(j+1)+deltaX(j));
    M(j,j+1)=deltaX(j+1);
    M(j,j-1)=deltaX(j);
    u(j)=6*(((y(j+2)-y(j+1))/(deltaX(j+1)))-((y(j+1)-y(j))/deltaX(j)));
end

%creating the S matrix
s=M\u;
s=[0;s;0];
% assaigning the values of a,b,c,d
figure;
plot(x,y,'d');
hold on;

aVec=zeros(length(x),1);
bVec=zeros(length(x),1);
cVec=zeros(length(x),1);
dVec=zeros(length(x),1);

for i= 1:(length(x)-1)
    a=y(i);
    aVec(i)=a;
    b=(((y(i+1)-y(i))/deltaX(i))-(((s(i+1)+2*s(i))*deltaX(i))/6));
    bVec(i)=b;
    c=(s(i)/2);
    cVec(i)=c;
    d=((s(i+1)-s(i))/(6*deltaX(i)));
    dVec(i)=d;
    w = union(x(i):0.01:x(i)+deltaX(i),x(i)+deltaX(i));
    spline=a+b*(w-x(i))+c*(w-x(i)).^2+d*(w-x(i)).^3;
    plot(w,spline);
end

% printing Z

if length(varargin)==1
    z=zeros(length(v),1);
    for j=1:length(x)-1
        for i=1:length(v)
            if x(1)>=v(i)
                z(i)=aVec(1)+bVec(1)*(v(i)-x(1))+cVec(1)*(v(i)-x(1)).^2+dVec(1)*(v(i)-x(1)).^3;
            elseif x(j)<=v(i) && v(i)<x(j+1)
                z(i)=aVec(j)+bVec(j)*(v(i)-x(j))+cVec(j)*(v(i)-x(j)).^2+dVec(j)*(v(i)-x(j)).^3;
            elseif v(i)>=x(end)
               z(i)=aVec(end-1)+bVec(end-1)*(v(i)-x(end-1))+cVec(end-1)*(v(i)-x(end-1)).^2+dVec(end-1)*(v(i)-x(end-1)).^3;
            end
        end
    end
else
    z=[];
end

stat=0;
return;
end







