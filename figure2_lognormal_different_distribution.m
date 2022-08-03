clear; close all; clc; clf;
sample_num = 1e4;
mu = 0; 
sigma_ =[0.01 0.1:0.05:4];
%sigma_ = 0.6;
fmax =1.6;
f=fmax;

sigma_OU = 1;
theta_OU = 0.5;
fname_g = 'g1_OU';
fname_q = 'q1_OU';
% sigma_ = 1.5;
%mpdc = distinguishable_colors(3);
curve_index = 1;

%uniform (measure-ignorant, channel-ignorant)

j = 0;

MSE=zeros(1,length(sigma_));
for sigma = sigma_
    sigma
    randn('seed',10);
    mu = 0; 
    mean_tmp = exp(mu+sigma^2/2);
    Y_i = lognrnd(mu,sigma,1,sample_num)/mean_tmp;  
    j = j + 1;
 
    real_inter_sampling_time = ones(1,sample_num) * (1/f);
    S_i = cumsum(real_inter_sampling_time);
    D_i = zeros(1,length(S_i));
    D_i(1) = S_i(1)+Y_i(1);
    for i= 1:length(S_i)-1 %S_i(0)=D_i(0)= 0;
        D_i(i+1) = max(S_i(i+1), D_i(i)) + Y_i(i+1);
        Expectedq = mean(feval(fname_q,D_i(1:sample_num-1)-S_i(1:sample_num-1),0,D_i(2:sample_num)-D_i(1:sample_num-1),sigma_OU,theta_OU));
    end
    MSE(j) = Expectedq/(D_i(end)/length(D_i));
 
end
plot(sigma_,MSE,'--k','LineWidth',2);
hold on
legendInfo{curve_index} = 'Uniform sampling';

% j = 0;
% curve_index = 1;
% MSE=zeros(1,length(sigma_));
% for j = 1: length(sigma_)
%     sigma = sigma_(j);
%     randn('seed',10);
%     Y_i = lognrnd(mu,sigma,1,sample_num);   
%     Y_i = Y_i/mean(Y_i);
%     Z = 0;
%     real_inter_sampling_time = ones(1,sample_num) * (1/f);
%     S_i = cumsum(real_inter_sampling_time);
%     D_i = zeros(1,length(S_i));
%     D_i(1) = S_i(1)+Y_i(1);
%     for i= 1:length(S_i)-1 
%         D_i(i+1) = max(S_i(i+1), D_i(i)) + Y_i(i+1);
%     end
%     Expectedq = mean(feval(fname_q,D_i(1:sample_num-1)-S_i(1:sample_num-1),0,D_i(2:sample_num)-D_i(1:sample_num-1),sigma_OU,theta_OU));
%     MSE(j) = Expectedq/(D_i(end)/length(D_i));
% end
% plot(sigma_,MSE,'--k','LineWidth',2);
% hold on
% legendInfo{curve_index} = 'Uniform sampling';

% Zero-wait sampling

% sigma_ =[0.01 0.1:0.2:4]
% 
% curve_index = curve_index + 1;
% MSE=zeros(1,length(sigma_));
% for j = 1: length(sigma_)
%     sigma = sigma_(j);
%     randn('seed',10);
%     Y_i = lognrnd(mu,sigma,1,sample_num);   
%     Y_i = Y_i/mean(Y_i);
%     Z = 0;
%     Expectedq = mean(feval(fname_q,Y_i(1:sample_num-1),Z,Y_i(2:sample_num),sigma_OU,theta_OU));
%     MSE(j) = Expectedq/(mean(Z)+mean(Y_i));
% end
% plot(sigma_,MSE,':o','Color',[0 0.5 0],'LineWidth',2,'MarkerSize',18);
% %,'Color',mpdc(curve_index,:));
% hold on;
% legendInfo{curve_index} = 'Zero-wait sampling';
% 
% Age optimal policy

sample_num=1e4;

%sigma_ =[0.01 0.1:0.1:4]

curve_index = curve_index + 1;
MSE=zeros(1,length(sigma_));
for j = 1: length(sigma_)
    sigma = sigma_(j);
    randn('seed',10);
    Y_i = lognrnd(mu,sigma,1,sample_num);  
    Y_i = Y_i/mean(Y_i);
    age_optimal_policy;
    Expectedq = mean(feval(fname_q,Y_i(1:sample_num-1),Z,Y_i(2:sample_num),sigma_OU,theta_OU));
    MSE(j) = Expectedq/(mean(Z)+mean(Y_i));
end
plot(sigma_,MSE,'b+:','LineWidth',2)
%,'Color',mpdc(curve_index,:));
hold on;
legendInfo{curve_index} = 'Age-optimal sampling';   

%% MSE optimal policy

sample_num=1e3;

curve_index = curve_index + 1;
MSE_OU=zeros(1,length(sigma_));
j1=0;

for sigma=sigma_
    j1=j1+1;
    %sigma
%     MSE_ti=zeros(1,10);
    
    randn('seed',10);
    Y_i = lognrnd(mu,sigma,1,sample_num);   
    Y_i = Y_i/mean(Y_i);    
    %OU_Optimal_log
    OU_MSE_optimal_new
    MSE_OU(j1)=MSE_t;
    
end
plot(sigma_,MSE_OU,'r','LineWidth',2,'Markersize',14);
legendInfo{curve_index} = 'MSE-optimal sampling';

axis([0 4 0.5 1.2]);
xlabel('\alpha');
ylabel('MSE');
legend('Uniform Sampling', 'Age-optimal sampling', 'MSE-optimal sampling'); 
saveas(figure(1),'figure2_lognormal_different_distribution.fig');

% figure(2)
% plot(sigma_, abs(beta_t-MSE_t))