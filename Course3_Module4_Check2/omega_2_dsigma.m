function dsigma = omega_2_dsigma(sigma,omega)
   sigma_tilde = [0 -sigma(3) sigma(2);sigma(3) 0 -sigma(1);-sigma(2) sigma(1) 0];
   dsigma = 1/4*((1 - dot(sigma,sigma))*eye(3) + 2*sigma_tilde + 2*sigma*sigma')*omega;
end