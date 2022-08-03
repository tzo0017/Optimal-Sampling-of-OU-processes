l = 0; 
if theta_OU ==0
    u = 40;
else
    u = sigma_OU^2/theta_OU/2;
end
times = 40;
time_duration = 120;
dt = 0.01;
time_period = 0:dt:time_duration;
expected_g = mean(feval(fname_g,mplus(time_period,Y_i(2:sample_num)'),sigma_OU,theta_OU),1);
for i=1:times % bisection without sampling rate constraint
    i
    beta = (l+u)/2;
    if isempty(find(expected_g>= beta,1))
        Z = max(time_duration-Y_i(1:sample_num-1),0);
    else
        Z = max(find(expected_g>= beta,1)*dt-Y_i(1:sample_num-1),0);
    end
    Expectedz = mean(Z);
    Expectedq = mean(feval(fname_q,Y_i(1:sample_num-1),Z,Y_i(2:sample_num),sigma_OU,theta_OU));
    if Expectedq - beta*(Expectedz + mean(Y_i))<=0 
        u = beta;
    else
        l = beta;
    end
end
if Expectedz + mean(Y_i) < 1/f
    l = 0; 
    if theta_OU ==0
        u = 30;
    else
        u = sigma_OU^2/theta_OU/2;
    end
    for i1=1:times % bisection for sampling rate constraint
        i1
        beta = (l+u)/2;
        if isempty(find(expected_g>= beta,1))
            Z = max(time_duration-Y_i(1:sample_num-1),0);
        else
            Z = max(find(expected_g>= beta,1)*dt-Y_i(1:sample_num-1),0);
        end
        Expectedz = mean(Z);
        if Expectedz + mean(Y_i) > 1/f
            u = beta;
        else
            l = beta;
        end
    end
end
1;

