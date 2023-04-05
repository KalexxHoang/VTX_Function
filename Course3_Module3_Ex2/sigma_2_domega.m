function domega = sigma_2_domega(sigma,dsigma,ddsigma)
    sigma_tilde = [0 -sigma(3) sigma(2);sigma(3) 0 -sigma(1);-sigma(2) sigma(1) 0];
    dsigma_tilde = [0 -dsigma(3) dsigma(2);dsigma(3) 0 -dsigma(1);-dsigma(2) dsigma(1) 0];
    
    domega = 4/(1 + dot(sigma,sigma))^2*((1 - dot(sigma,sigma))*eye(3) - 2*sigma_tilde + 2*sigma*sigma')*ddsigma + 4/(1 + dot(sigma,sigma))^2*((1 - dot(sigma,sigma))*eye(3) - 2*dsigma_tilde + 4*sigma*dsigma')*dsigma;;
end