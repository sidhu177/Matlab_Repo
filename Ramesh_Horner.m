function [y,b] = Ramesh_Horner(a,z)
%Ramesh Horner - horner algorithm for polynomial root finding
n=length(a);
b=zeros(n,1);
b(1)=a(1);
for j=2:n
    b(j)=a(j)+b(j-1)*z;
end
y=b(n);
b=b(1:n-1);

end

