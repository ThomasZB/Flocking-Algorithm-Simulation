function phi = func_phi(z)
% 参数设置
A = 5;
B = 5;
C = abs(A-B)/sqrt(4*A*B);
phi = ((A+B)*func_sigma_1(z + C)+(A-B))/2;

end