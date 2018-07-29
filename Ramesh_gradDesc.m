function [xSol, fSol, itrCount, stat]=Ramesh_gradDesc(f,df,x0,ftol,xtol,itrLimit,s)

xSol=NaN;
stat=1;
fSol=NaN;
terminate=false;

alpha=1;
xnew=x0;
itrCount=0;

while itrCount<itrLimit && terminate==false
    d=-feval(df,xnew);
    %d=-eval(sprintf('%s(%f)', df, xnew));
    if itrCount==0
        alphaLeft=0;
        alphaRight=1;
    end
    if s==1
        alpha=1;
        if norm(alpha*d)<xtol || isnan(alpha)==1
            terminate=true;
        else
            xnew=xnew+alpha*d;
        end
    end
    if s==2
        alpha2=1;
        alpha3=2;
        falpha1=feval(f,xnew);
        falpha2=feval(f,xnew+alpha2*d);
        falpha3=feval(f,xnew+alpha3*d);
        num=((-3)*falpha1+4*falpha2-falpha3);
        denom=(-2*falpha1+4*falpha2-2*falpha3);
        alpha=num/denom;
        if norm(alpha*d)<xtol || isnan(alpha)==1
            terminate=true;
        else
            xnew=xnew+alpha*d;
        end
    end
    if s==3
        z=@(alpha) feval(df,xnew+alpha*d)'*d;
        %z1=eval(sprintf('%s(%f)', df,xnew+alphaLeft*d))'*d;
        %z2=eval(sprintf('%s(%f)', df,xnew+alphaRight*d))'*d;
        tmt=false;
        if sign(z(alphaLeft))==sign(z(alphaRight))
        %if sign(z1)==sign(z2)
            alpha=1;
        else
            while tmt==false
                alphaNew=(alphaLeft+alphaRight)/2;
                falphaNew=feval(f,xnew+alphaNew*d);
                %falphaNew=eval(sprintf('%s(%f)',f, xnew+alphaNew*d));
                if norm(falphaNew)<0.00000000001
                    alpha=alphaNew;
                    tmt=true;
                elseif norm(alphaLeft-alphaRight)<0.00000000001
                    alpha=alphaNew;
                    tmt=true;
                end
                %z3=eval(sprintf('%s(%f)', df,xnew+alphaNew*d))'*d;
                if sign(z(alphaNew))==sign(z(alphaLeft))
                %if sign(z3)==sign(z1)
                    alphaLeft=alphaNew;
                end
                if sign(z(alphaNew))==sign(z(alphaRight))
                %if sign(z3)==sign(z2)
                    alphaRight=alphaNew;
                end
            end
        end
        if norm(alpha*d)<xtol || isnan(alpha)==1
            terminate=true;
        else
            xnew=xnew+alpha*d;
        end
    end
    if  abs(norm(d))<ftol 
        stat=0;
        xSol=xnew;
        fSol=feval(f,xnew);
        return;
    end
    if abs(norm(alpha*d))<xtol
        stat=0;
        xSol=xnew;
        fSol=feval(f,xnew);
        return;
    end
    if itrCount>=itrLimit
        stat=1;
        xSol=xnew;
        fSol=feval(f,xnew);
        %fSol=eval(sprintf('%s(%f)',f,xnew));
        return;
    end
    itrCount=itrCount+1;
end
xSol=xnew;
fSol=feval(f,xnew);
stat=1;
end