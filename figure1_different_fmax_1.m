clear; close all; clc;
df = 0.01;
fmax = [0.001 0.01:df:1.5];

mean_ = 1;
sample_num = 1e4; % more than 1e4 samples will greatly increase the simulation time of the age-optimal policy
sigma_OU = 1;
theta_OU = 0.5;
mu = 0; 
%sigma = 1.5; 

randn('seed',10);

% exponential
Y_i = exprnd(1,1,sample_num);
Y_i = Y_i/mean(Y_i);

fname_g = 'g1_OU';
fname_q = 'q1_OU';

curve_index = 1;
%% MSE optimal policy

curve_index = curve_index + 1;

j1=0;
MSE_OU=zeros(1,length(fmax));
for f=fmax
    j1=j1+1;
    f;
    Newton_optimal;
    MSE_OU(j1)=MSE_t;
end


axis([0 1.5 0.65 1.05]);

plot(fmax,MSE_OU,'r','LineWidth',2,'Markersize',8);
legendInfo{curve_index} = 'MSE-optimal sampling';
xlabel('f_{max}');
ylabel('MSE');
%legend(legendInfo);
%saveas(figure(1),'figure1_different_fmax_1.fig');
%save('Z.mat',Z);


