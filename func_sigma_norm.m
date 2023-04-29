function sigma_norm = func_sigma_norm(z)
% 参数设置
EPSILON = 0.1;

sigma_norm = (sqrt(1+EPSILON*(norm(z)^2))-1)/EPSILON;

end

