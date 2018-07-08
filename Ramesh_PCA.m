function [z,v,mu,stat]=Ramesh_PCA(x,p)
z=NaN;
v=NaN;
mu=NaN;
stat=1;

[v,d]=eig(cov(x));
mu=mean(x);
[mx,nx]=size(x);
[h,sortIndx]=sort(diag(d),'descend');
v=v(:,sortIndx(1:find((cumsum(h)./sum(h))>=p,1)));
z=(x-ones(mx,1)*mu)*v;
stat=0;
end


