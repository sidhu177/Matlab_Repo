// Bisection code with input variables being function, start and end range, max iteration and tolerance

function [root,fx,ea,iter]=bisect1(func,xl,xu,es,maxit,varargin)
%test=func(xl,varargin{:})*func(xu,varargin{:});
if nargin<3, error('poda naaye!'), end
%if test>0, error('no sign change'), end
if nargin< 4|isempty(es), es=0.0001; end
if nargin<5|isempty(maxit),maxit=50;end
iter=0; xr=xl; ea=100;
while(1)
    xrold=xr;
    xr=(xl+xu)/2;
    iter=iter+1;
    if xr~=0, ea=abs((xr-xrold)/xr)*100;end
    test=func(xl,varargin{:})*func(xr,varargin{:});
    if test<0
        xu=xr;
    elseif test>0
        xl=xr;
    else
        ea=0;
    end
    if ea<=es|iter>=maxit,break,end
end
root=xr;fx=func(xr,varargin{:});