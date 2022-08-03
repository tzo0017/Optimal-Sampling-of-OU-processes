function y =  HyperGeometric (x,HyperGeo)
dt1 = 0.01;
expand = 100;
x1 = min(x,expand)/dt1;
lambda = x1-floor(x1); 
y = HyperGeo(floor(x1)+1).*(1-lambda) + HyperGeo(floor(x1)+2).*lambda;