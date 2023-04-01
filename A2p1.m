%% (ii)
S0 = 100; X = 100; r = 0.1; T = 0.25; sigma = 0.4; q = 0; 
N = [50 100 200 400];
valuesii = zeros(3,4); timetakenii = zeros(3,4);
rou = [1 1/2 1/4];
norows = 3; nocols = 4;
for i = 1:norows
    for j = 1:nocols
        tstart = cputime;
        valuesii(i,j) = fsgm_fixed_AA_call(S0,X,r,T,sigma,q,N(j),rou(i));
        tend = cputime - tstart;
        timetakenii(i,j) = tend; 
    end
end

tablevaluesii = array2table(valuesii);
tablevaluesii.Properties.VariableNames = {'N=50','N=100','N=200','N=400'};
tablevaluesii.Properties.RowNames = {'rou=1','rou=1/2','rou=1/4'};
tabletimetakenii = array2table(timetakenii);
tabletimetakenii.Properties.VariableNames = {'N=50','N=100','N=200','N=400'};
tabletimetakenii.Properties.RowNames = {'rou=1','rou=1/2','rou=1/4'};

tablevaluesii
tabletimetakenii

%% 

plot(N,timetakenii(1,:),'r*-')
title('CPU Time Taken versus Number of Time Steps')
xlabel('Time Steps (N)')
ylabel('Time Taken (seconds)')
hold on
plot(N,timetakenii(2,:),'b*-')
plot(N,timetakenii(3,:),'g*-')
legend('rou = 1','rou = 1/2', 'rou = 1/4')

%% (iv)

q2 = 0.025; runningmin = 98.5;
valuesiv = zeros(1,nocols); timetakeniv = zeros(1,nocols);
for i = 1:nocols
    tstart = cputime;
    valuesiv(i) = fsgm_fixed_LB_put(S0,X,r,T,sigma,q2,N(i),runningmin);
    tend = cputime - tstart;
    timetakeniv(i) = tend;
end
valuesiv
timetakeniv

%% 
figure;
plot(N,timetakeniv,'r*-')
title('CPU Time Taken versus Number of Time Steps')
xlabel('Time Steps (N)')
ylabel('Time Taken (seconds)')
legend('rou = 1')

