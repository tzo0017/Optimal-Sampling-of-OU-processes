function z = g1_OU(y,sigma,theta)
if theta == 0
    z = sigma^2*y;
else
    z = sigma^2/2/theta*(1-exp(-2*theta*y));
end

