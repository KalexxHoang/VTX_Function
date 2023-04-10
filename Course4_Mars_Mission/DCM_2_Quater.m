function q4 = DCM_2_Quater(C)
    trace = C(1,1) + C(2,2) + C(3,3);
    beta0 = sqrt(0.25*(1 + trace));
    beta1 = sqrt(0.25*(1 + 2*C(1,1) - trace));
    beta2 = sqrt(0.25*(1 + 2*C(2,2) - trace));
    beta3 = sqrt(0.25*(1 + 2*C(3,3) - trace));
    
    m = max([beta0 beta1 beta2 beta3]);
    
    if beta0 == m
        B0 = beta0;
        B1 = (C(2,3)-C(3,2))/(4*B0);
        B2 = (C(3,1)-C(1,3))/(4*B0);
        B3 = (C(1,2)-C(2,1))/(4*B0);
    end
    if beta1 == m
        B1 = beta1;
        B0 = (C(2,3)-C(3,2))/(4*B1);
        B2 = (C(1,2)+C(2,1))/(4*B1);
        B3 = (C(3,1)+C(1,3))/(4*B1);
    end
    if beta2 == m
        B2 = beta2;
        B0 = (C(3,1)-C(1,3))/(4*B2);
        B1 = (C(1,2)+C(2,1))/(4*B2);
        B3 = (C(2,3)+C(3,2))/(4*B2);
    end
    if beta3 == m
        B3 = beta3;
        B0 = (C(1,2)-C(2,1))/(4*B3);
        B1 = (C(3,1)+C(1,3))/(4*B3);
        B2 = (C(2,3)+C(3,2))/(4*B3);
    end
    
    q4 = [B0 B1 B2 B3]';
end
