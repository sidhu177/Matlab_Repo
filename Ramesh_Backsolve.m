function [ x,stat ] = Ramesh_Backsolve( L,U,p,b )

x=NaN;
stat=3;

b=b(p);

[ml,nl]=size(L);
[mu,nu]=size(U);
y=zeros(ml,1);
x=zeros(nu,1);

% Forward Substitution
y(1)=b(1)/L(1,1);
for a=2:ml
    y(a)=(b(a)-L(a,1:a-1)*y(1:a-1))/L(a,a);
end
% Backward Substitution
%[val,indx]=max(abs(U(mu,:)));


for i=1:mu
    [val,indx]=max(abs(U(i,:)));
    [val2,indx2]=max(abs(y(i)));
    %[val3,indx3]=max(abs(b(1:end)));
    if abs(val)<0.00001 && abs(val2)>0.001 && rank(U)<(mu)
        %fprintf('Ax=b has no solution, i.e; Matrix is inconsistent');
        stat=2;
        return;
    %elseif  abs(val)<0.00001 && abs(val2)<0.0001 && rank(U)<mu && rank(U)<nu
    elseif (rank(U)<mu && rank(U)<nu) || (nu ~= mu && rank(U)==mu)
        %fprintf('Ax=b has infinite solutions');
        stat=1;
    end
end
if stat==3
    stat=0;
end
if rank(U)==mu
    %x(mu)=y(ml)/U(mu,mu);
    for c=mu:-1:1
        v=find(abs(U(c,:))>0.0001,1,'first');
        if isempty(v)==1
            continue;
        end
        x(v)=(y(c)-U(c,v+1:nu)*x(v+1:nu))/U(c,v);
        %x(c)=(y(c)-U(c,c+1:mu)*x(c+1:mu))/U(c,c);
        %stat=0;
    end
    %fprintf('Ax=b is consistent');
else
    %x(nu)=y(ml)/U(nu,nu);
    for c=nu:-1:1
        v=find(abs(U(c,:))>0.0001,1,'first');
        if isempty(v)==1
            continue;
        end
        x(v)=(y(c)-U(c,v+1:nu)*x(v+1:nu))/U(c,v);
        %x(c)=(y(c)-U(c,c+1:nu)*x(c+1:nu))/U(c,c);
        %stat=4;
    end
    %fprintf('Ax=b is consistent');
end
%stat=0;
return;

end

