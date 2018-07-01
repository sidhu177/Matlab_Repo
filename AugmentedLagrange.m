//Matlab program demonstrating Augmented Lagrange 

close all
clc
clear variables

Kl=[1,0,0;0,3,-3;0,-3,3];
F=[0;0;-1];
KBig=[30,-30;-30,30];
K=[31,-30,0;-30,33,-3;0,-3,3];
x=0;
for i=1:5
  U=inv(K)*F;
   x=x-KBig(1,1)*(U(2)-U(1));
  F(1)=(-x);
  F(2)=(+x);
end


