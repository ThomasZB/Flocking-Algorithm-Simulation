function aij = func_aij(x_j, x_i, r)

sigma_norm = func_sigma_norm(x_j-x_i);
z = sigma_norm/func_sigma_norm(r);
aij = func_rho_h(z);
end

