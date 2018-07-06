function [L,stat] = Ramesh_CholeskyInner(A)

L=NaN;
stat=1;
tol=0.0000001;

[mA,nA] = size(A); % get size of matrix A
if (mA ~= nA) % test for squareness
    fprintf('matrix is not square');
    stat =1;
    return;
elseif norm(A'-A)>=tol
    fprintf('matrix is not symmetric');
    stat =1;
    return;
else
    n=size(A,1);
    L = eye(n);
    for j = 1:n
        temp = A(j,j) - dot(L(j,1:j-1),L(j,1:j-1));
        if temp < 0
            fprintf('Matrix is not positive definite');
            stat=1;
            %L=NaN;
            return;
        end
        L(j,j) = sqrt(temp);
        for i = j+1:n
            L(i,j)=(A(i,j) - dot(L(i,1:j-1),L(j,1:j-1)))/L(j,j);
        end
    end
end
%L=L';
stat=0;
return
end


