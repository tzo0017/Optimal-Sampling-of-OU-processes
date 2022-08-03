if ~exist('HyperGeo')
    load('HyperGeo.mat');
end
% test_fast_hyper_geometric
v_beta= ones(1,sample_num)*threshold;

% UYi
UYi=zeros(1,sample_num);
variance_error=1-(exp(2*theta_OU*Y_i));
UYi=(sigma_OU/sqrt(-2*theta_OU))*exp(-theta_OU*Y_i).*sqrt(variance_error).*randn(1,sample_num);

    
% R1_v
%R1_v=(v_beta.^2/(sigma_OU^2)).*hypergeom([1,1],[3/2,2],(theta_OU/sigma_OU^2)*v_beta.^2);
% x1=hypergeom([1,1],[3/2,2],(theta_OU/sigma_OU^2)*v_beta.^2);
x1=HyperGeometric((theta_OU/sigma_OU^2)*v_beta.^2,HyperGeo);
R1_v=(v_beta.^2/(sigma_OU^2)).*x1;

%R1_UY1
%R1_UYi=(UYi.^2/(sigma_OU^2)).*hypergeom([1,1],[3/2,2],(theta_OU/sigma_OU^2)*UYi.^2);
% x2=hypergeom([1,1],[3/2,2],(theta_OU/sigma_OU^2)*UYi.^2);
x2=HyperGeometric((theta_OU/sigma_OU^2)*UYi.^2,HyperGeo);
R1_UYi=(UYi.^2/(sigma_OU^2)).*x2;

z0=zeros(1,sample_num);
%intersampling time
intersampling_time=mean(max(R1_v-R1_UYi,z0))+mean(Y_i);

%U_Y+Z
U_Y_Z=max(v_beta.^2,UYi.^2);

%R2(UYi)
R2_UYi=-UYi.^2/2/theta_OU+UYi.^2/2/theta_OU.*x2;

%R2(v)
R2_v=-v_beta.^2/2/theta_OU+v_beta.^2/2/theta_OU.*x1;

%integral1
integral1=mean(max(R2_v-R2_UYi,z0));

%gamma
gamma_=mean(1-exp(-2*theta_OU*Y_i))/2/theta_OU;

%integral2

integral2=(sigma_OU^2*mean(Y_i))/2/theta_OU+gamma_*mean(U_Y_Z)-(sigma_OU^2*mean(1-exp(-2*theta_OU*Y_i)))/4/theta_OU^2;

integral2=mean(integral2);
%integral
integral=integral1+integral2;

%o
%MSE_t=integral/intersampling_time;



