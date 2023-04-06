function omega = dsigma_2_omega(sigma,dsigma)
    sigma_tilde = [0 -sigma(3) sigma(2);sigma(3) 0 -sigma(1);-sigma(2) sigma(1) 0];
    omega = 4/(1 + dot(sigma,sigma))^2*((1 - dot(sigma,sigma))*eye(3) - 2*sigma_tilde + 2*sigma*sigma')*dsigma;
end