%% (v)
X = 100; S0 = 101; T = 0.25; sigma = 0.36; q = 0.01; r = 0.025;
I = 100 + 100*(0:1:11);
N = ceil(T*(r+sigma^2*(I-1).^2));
N

plot(I,N,'r*-')
title('N Values Obtained versus I')
xlabel('I')
ylabel('Time Steps (N)')

%% (vi)
numprices = length(I);
pricesvi = zeros(numprices,2);
for i = 1:numprices
    [a,b] = EdsI_Eu_Call(S0,X,r,T,sigma,q,N(i),I(i));
    pricesvi(i,:) = [a,b];
end
pricesvi

figure;
plot(I,pricesvi(:,1),'r*-')
title('Approximate Option Prices versus I(European Vanilla Call Option)')
xlabel('I')
ylabel('Option Prices ($)')

figure;
plot(I,pricesvi(:,2),'r*-')
title('Errors versus I')
xlabel('I')
ylabel('Errors')

%% (viii)

pricesviii = zeros(numprices,1);
for i = 1:numprices
    pricesviii(i) = EdsI_Am_Call(S0,X,r,T,sigma,q,N(i),I(i));
end
pricesviii

figure;
plot(I,pricesviii,'r*-')
title('Approximate Option Prices versus I(American Vanilla Call Option)')
xlabel('I')
ylabel('Option Prices ($)')





