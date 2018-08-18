close all
clc

j=0:0.01:1
f=j+2*j.^3;
plot(j,f)
ylabel force;
xlabel x;
grid on

x=0;
Gp=1+6*x^2;
for i=1:5
    G=x+2*x^3-.5;

    dx=-G/Gp;
    x=x+dx;
    fprintf('G=%4.2f,Gp=%5.3f,dx=%5.3f,x=%4.4f\n',G,Gp,dx,x);
end
 Gp=1+6*x^2;   
for i=1:10
    G=x+2*x^3-1;

    dx=-G/Gp;
    x=x+dx;
    fprintf('G=%4.2f,Gp=%5.3f,dx=%5.3f,x=%4.4f\n',G,Gp,dx,x);
end