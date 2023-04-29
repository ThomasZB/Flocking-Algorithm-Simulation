function nij = func_nij(z)
% 参数设置
EPSILON = 0.1;

nij = z/sqrt(1+EPSILON*(norm(z)^2));
end