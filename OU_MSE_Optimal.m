if ~exist('G')
    load('G.mat');
end
i=0;
%% Bisection Search 
l=(sigma_OU^2/(2*theta_OU))*mean(1-exp(-2.*theta_OU.*Y_i));
h=(sigma_OU^2)/2/theta_OU-0.1;
times=40;
for i=1:times  
    %i
    i
    beta_t=(l+h)/2;
    %threshold for beta_t
    g_0 = mean(exp(-2*theta_OU.*Y_i))/(1-2*theta_OU*beta_t/(sigma_OU^2));
    threshold = sigma_OU/sqrt(theta_OU)* G_inverse(g_0,x,G);
    %MSE calculation
    integral_intersampling_main
    %beta_t
    if (beta_t-MSE_t>=0)
        h=beta_t;
    else
        l=beta_t;
    end
    disp(h)
    disp(l)
    disp(g_0)
    disp(threshold)
end
beta_t-MSE_t

if (intersampling_time<1/f)
    l=(sigma_OU^2/(2*theta_OU))*mean(1-exp(-2.*theta_OU.*Y_i));
    h=(sigma_OU^2)/2/theta_OU;
    for i=1:times
        %i
        beta_t=(l+h)/2;

        %threshold for beta_t
        g_0 = mean(exp(-2.*theta_OU.*Y_i))./(1-2*theta_OU*beta_t/(sigma_OU^2));
        threshold = sigma_OU/sqrt(theta_OU)* G_inverse(g_0,x,G);

        %MSE calculation
        integral_intersampling_main
        if (intersampling_time>=1/f)
            h=beta_t;
        else
            l=beta_t;
        end
    end
end
1;
%OMSE=MSE_t;



