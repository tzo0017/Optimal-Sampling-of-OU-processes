function q= q1_OU(y,z,y_,sigma,theta)
% q = 1/2*(2*y+z+y_).*(z+y_);
if theta == 0
    q = (sigma^2*((y+z+y_).^2-y.^2))/2;
else
    q = (sigma^2*(exp(-2*theta*(y+z+y_)) + 2*theta*(y+z+y_)))/(4*theta^2)-(sigma^2*(exp(-2*theta*y) + 2*theta*y))/(4*theta^2);
end
