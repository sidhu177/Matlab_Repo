function [xstar, fxstar, itrCount, stat] = Ramesh_Newton(func,dfunc,x0, xTol, fTol, itrLimit, verbose)

% Make some initializations
itrCount = 0;
xstar = NaN; % Default to an unkown root
fxstar = NaN; % Default is an unknown estimate at the root
stat = 1;    % Default is failure
tmt=false;

% Enter the search for the root
y=feval(func, x0);
dy=feval(dfunc, x0);

while tmt==false  
           
        if itrCount==0
            xnew=x0-(y/dy);
            xnew1=0;
        else
            xnew=xnew-(y/dy);
            y=feval(func, xnew);
            dy=feval(dfunc, xnew);
        end
        if abs(y)<fTol
            stat=0;
            xstar=xnew;
            fxstar=y;
            tmt=true;
        end
        b=abs(xnew1-xnew);
        if abs(xnew1-xnew)<xTol
            stat=0;
            xstar=xnew;
            fxstar=y;
            %fprintf('interval limit exceeded');
            tmt=true;
        end
        if itrCount>=itrLimit
            stat=1;
            xstar=xnew;
            fxstar=y;
            %fprintf('Iteration limit reached');
            tmt=true;
        end
        itrCount=itrCount+1;
        if verbose
            fprintf('Iteration %d: Best Root %d; function value %d\n',itrCount,x0,fxstar);
        end
       xnew1=xnew;
end
%fprintf('The root is found to be equal to %d\n',xstar);
%fprintf('The best function value is found to be %d\n',abs(fxstar));
end


