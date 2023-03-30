function value = LinearInterpolate(x,x0,x1,f0,f1)
value = (x1-x)./(x1-x0).*f0 + (x-x0)./(x1-x0).*f1;
end
