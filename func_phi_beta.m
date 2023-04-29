function phi_alpha = func_phi_beta(z, d)
phi_alpha = func_rho_h(z/func_sigma_norm(d)) * (func_sigma_1(z-func_sigma_norm(d)) - 1);
end