function [xRoot, fRoot, itrCount, stat] = Ramesh_Secant(fName, l, r, xTol, fTol, itrLimit,verbose)

% Make some initializations
Terminate = false;
itrCount = 0;
xRoot = NaN; % Default to an unkown root
fRoot = NaN; % Default is an unknown estimate at the root
stat = 1;    % Default is failure
tmt=false;

%Get function values at end points
fLeft = feval(fName, l);
fRight = feval(fName, r);

% Enter the search for the root
while tmt==false
    if l==r
        stat=1;
        %fprintf('Initial guesses are the same');
        tmt=true;
    end
    if fLeft == fRight
        stat=1;
        tmt=true;
    end
    x = l-((fLeft)*(l-r))/(fLeft-fRight);
    funcEval=feval(fName,x);
    l=r;
    r=x;
    fLeft=feval(fName,l);
    fRight=feval(fName,r);
    itrCount = itrCount+1;
    %funcEval=feval(fName,r);
    if verbose
        fprintf('Iterate=%d;Root=%d;func Value=%d\n',itrCount,x,abs(funcEval));
    end
    if abs(funcEval)<fTol
        stat=0;
        fRoot=funcEval;
        xRoot=x;
        tmt=true;
    end
    if itrCount>=itrLimit
        stat=1;
        %fprintf('Iteration limit reached');
        fRoot=funcEval;
        xRoot=x;
        tmt=true;
    end
    if abs(l-r)<xTol
        stat=0;
        fRoot=funcEval;
        xRoot=x;
        %fprintf('the interval width is less than the interval Tolerance');
        tmt=true;
    end
    
end
%fprintf('The root is found to be equal to %d\n',xRoot);
%fprintf('The best function value is found to be %d\n',fRoot);
%stat=1;
return;
end
