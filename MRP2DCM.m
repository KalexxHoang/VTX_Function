function DCM = MRP2DCM(sigma)
    %% This function returns a DCM that is transformed from MRP
    s1 = sigma(1);
    s2 = sigma(2);
    s3 = sigma(3);
    
    sigma_cross = [0 -s3 s2;s3 0 -s1;-s2 s1 0];
    
    DCM = eye(3) + (8*sigma_cross*sigma_cross - 4*(1 - dot(sigma,sigma))*sigma_cross)/(1 + dot(sigma,sigma))^2;

end