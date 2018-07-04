function [x,stat] = Ramesh_CG(A,b,x0)

x=zeros(size(x0));
stat=1;
[m,n]=size(A);
if  m ~= n % test for symmetricity
    %fprintf('matrix is not symmetric');
    stat =1;
    return
else
    t = size(A,1); % test for positive definite
    L=eye(t);
    for j = 1:t
        temp = A(j,j) - dot(L(j,1:j-1),L(j,1:j-1));
        if temp < 0.0
            %fprintf('Matrix is not positive definite');
            stat=1;
            return;
        end
    end
    d=-(A*x0-b);
    for k=1:1000
        x=x-(((A*x-b)'*d)/(d'*A*d))*d;
        d=-(A*x-b)+((d'*A*(A*x-b))/(d'*A*d))*d;
        if norm(A*x-b)<0.0000000000000001
            %fprintf('minimum value for the norm has been reached');
            stat=0;
            return;
        end
    end
    
end
stat=0;
return;
end


