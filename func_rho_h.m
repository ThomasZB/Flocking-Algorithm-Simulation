function rho_h = func_rho_h(z)
% 参数设置
H = 0.2;

if z<H && z>=0
    rho_h = 1;
elseif z>=H && z<=1
    rho_h = (1+cos(pi*(z-H)/(1-H)))/2;
else
    rho_h = 0;
end

end