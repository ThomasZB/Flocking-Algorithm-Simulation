function phi_alpha = func_phi_alpha(z, r, d)
phi_alpha = func_rho_h(z/func_sigma_norm(r)) * func_phi(z-func_sigma_norm(d));
end