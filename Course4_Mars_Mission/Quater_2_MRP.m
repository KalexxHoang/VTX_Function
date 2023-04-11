function sigma = Quater_2_MRP(B)
    sigma1 = B(2)/(1 + B(1));
    sigma2 = B(3)/(1 + B(1));
    sigma3 = B(4)/(1 + B(1));
    
    sigma = [sigma1 sigma2 sigma3]';

    if norm(sigma) >= 1
        sigma1 = -B(2)/(1 - B(1));
        sigma2 = -B(3)/(1 - B(1));
        sigma3 = -B(4)/(1 - B(1));
    
        sigma = [sigma1 sigma2 sigma3]';
    end   
end