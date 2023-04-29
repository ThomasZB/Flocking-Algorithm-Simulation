function aij = func_bij(delta, d)

sigma_norm = func_sigma_norm(delta);
z = sigma_norm/func_sigma_norm(d);
aij = func_rho_h(z);
end

