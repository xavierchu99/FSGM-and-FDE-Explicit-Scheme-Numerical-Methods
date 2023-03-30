% Names of group members: Xavier Chu

function [FD_c, FD_err] = EdsI_Eu_Call(S0, X, r, T, sigma, q, N, I)
% set up grid parameters
Smax = 3*X;
dt = T/N; dh = Smax / I;
VGrid=zeros(I+1,N+1);
% Boundary conditions 
VGrid(1,:)=0; % at S=0;
VGrid(I+1,:)=(Smax - X)*exp(-r*(T-(0:dt:T))); % at Smax
% Terminal condition
VGrid(:,N+1)=max((0:I)*dh-X,0);
i=(1:I-1)'; isq=i.^2;
% Explicit Scheme I
c=(0.5*sigma^2*isq+0.5*(r-q)*i)*dt;
b=1-sigma^2*isq*dt-r*dt;
a=(0.5*sigma^2*isq-0.5*(r-q)*i)*dt;
ishift=1;
for n=N:-1:1 % backward time recursive
    VGrid(i+ishift,n)= a.*VGrid(i-1+ishift,n+1) + b.*VGrid(i+ishift,n+1) + c.*VGrid(i+1+ishift,n+1);
end
kfloor = floor(S0/dh);
k = 1:I-1;
exact = BS_call(k*dh,X,r,T,sigma,q);
error =  exact' - VGrid(k+1,1);
FD_err = norm(error);
FD_c = LinearInterpolate(S0,kfloor*dh,(kfloor+1)*dh,VGrid(kfloor+ishift,1), VGrid((kfloor+1)+ishift,1));
end

% Black-Scholes formula for European vanilla call
% call syntax: c = BS_call(S0, X, r, T, sigma, q)
function  c = BS_call(S0, X, r, T, sigma, q)
d1=(log(S0/X)+(r-q+sigma^2/2)*T)/sigma/sqrt(T);
d2=d1-sigma*sqrt(T);
c=exp(-q*T)*S0.*normcdf(d1)-exp(-r*T)*X*normcdf(d2);
return
end

function value = LinearInterpolate(x,x0,x1,f0,f1)
value = (x1-x)./(x1-x0).*f0 + (x-x0)./(x1-x0).*f1;
end