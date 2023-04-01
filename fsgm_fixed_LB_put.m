function OptVal=fsgm_fixed_LB_put(S0,X,r,T,sigma,q,N,r_min)
 % step 1:set up tree parameters
dt = T/N; dx = sigma*sqrt(dt);
u = exp(dx); d = 1/u;
p = (exp((r-q)*dt)-d)/(u-d);
runningmin = min(S0,r_min);
% step 2: set up terminal values
jshift = 1;
k = -N:1:N;
Vn = zeros(N+1,2*N + 1);
An = runningmin*exp(k*dx);
for j = 0:1:N
    Vn(j+jshift,:) = max(X-An, 0);
end
% step 3: backward time recursive
for n = N-1:-1:0
    k = -n:1:n;
    Vtemp = zeros(n+1,2*n+1); % Empty Array designated for option values for current iteration
    A = runningmin*exp(k*dx); % minimum values for current iteration
    kshift = n+1; % kshift for current iteration
    kshiftp1 = n+2; % kshift for current iteration +1
    for j = 0:1:n
        Vp1up = Vn(j+1+jshift,:);
        Vp1down = Vn(j+jshift,:);
        S = S0*u^(2*j-n); % current price state
        Aup = A;
        Adown = min(S*d,A);
        Kup = floor(log(Aup/runningmin)/dx); Kdown = floor(log(Adown/runningmin)/dx);
        Vup = Vp1up(Kup+kshiftp1);
        Vdown = Vp1down(Kdown+kshiftp1);
        % store option prices to array containing option values for current iteration
        Vtemp(j+jshift,k+kshift) = exp(-r*dt)*(p*Vup + (1-p)*Vdown);
    end
    Vn = Vtemp; % assign computed option prices for currrent iteration to be option prices for next iteration
end
OptVal = Vn;
end
