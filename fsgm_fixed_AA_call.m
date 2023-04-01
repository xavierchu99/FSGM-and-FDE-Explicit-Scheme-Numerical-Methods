function OptVal=fsgm_fixed_AA_call(S0,X,r,T,sigma,q,N,Q)
 % step 1:set up tree parameters
dt = T/N; dx = sigma*sqrt(dt); dy = Q*dx;
u = exp(dx); d = 1/u;
p = (exp((r-q)*dt)-d)/(u-d);
m = 1/Q;
% step 2: set up terminal values
jshift = 1;
k = -N*m:1:N*m;
Vn = zeros(N+1,2*N*m + 1);
An = S0*exp(k*dy);
for j = 0:1:N
    Vn(j+jshift,:) = max(An - X, 0);
end
% step 3: backward time recursive
for n = N-1:-1:0
    k = -n*m:1:n*m;
    Vtemp = zeros(n+1,2*n*m+1); % Empty Array designated for option values for current iteration
    Averagesp1 = An; % Averages for (current iteration +1)
    Averages = S0*exp(k*dy); % Averages for current iteration
    kshift = n*m+1; % kshift for current iteration
    kshiftp1 = (n+1)*m+1; % kshift for (current iteration + 1)
    for j = 0:1:n
        Vp1up = Vn(j+1+jshift,:);
        Vp1down = Vn(j+jshift,:);
        S = S0*u^(2*j-n); % current price state
        Aup = (S*u + (n+1) * Averages) / (n+2);
        Adown = (S*d + (n+1) * Averages) / (n+2);
        Kup = floor(log(Aup/S0)/dy); Kdown = floor(log(Adown/S0)/dy);
        Iup = LinearInterpolate(Aup,Averagesp1(Kup+kshiftp1),Averagesp1(Kup+1+kshiftp1),Vp1up(Kup+kshiftp1), Vp1up(Kup+1+kshiftp1));
        Idown = LinearInterpolate(Adown,Averagesp1(Kdown+kshiftp1),Averagesp1(Kdown+1+kshiftp1),Vp1down(Kdown+kshiftp1), Vp1down(Kdown+1+kshiftp1));
        % store interpolated option prices to array containing option values for current iteration
        Vtemp(j+jshift,k+kshift) = exp(-r*dt)*(p*Iup + (1-p)*Idown); 
    end
    An = Averages; % assign averages for current iteration to An 
    Vn = Vtemp; % assign computed option prices for currrent iteration to be option prices for next iteration
end
OptVal = Vn;
end

            

