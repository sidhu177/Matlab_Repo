function [t,y,stat]=Ramesh_RK4(odeFunc,y0,t0,h)

t=NaN;
y=NaN;
stat=1;

ti=t0(1);
tf=t0(2);

if tf<=ti
    fprintf('both the limits are same');
end

t=ti:h:tf;
n=length(t);

t=t0(1)+(0:n-1)'*h;

y=y0;
for i=1:n-1
    f1=h*odeFunc(t(i),y(:,i));
    f2=h*feval(odeFunc,t(i)+0.5*h,y(:,i)+0.5*f1);
    f3=h*feval(odeFunc,t(i)+0.5*h,y(:,i)+0.5*f2);
    f4=h*feval(odeFunc,t(i)+h,y(:,i)+f3);
    y(:,i+1)=y(:,i)+(f1+2*(f2+f3)+f4)/6;
end
%y=y';
stat=0;

end