function B = DCM_2_Quater(C)
    trace = C(1,1) + C(2,2) + C(3,3);
    beta0 = (0.25*(1 + trace));
    beta1 = (0.25*(1 + 2*C(1,1) - trace));
    beta2 = (0.25*(1 + 2*C(2,2) - trace));
    beta3 = (0.25*(1 + 2*C(3,3) - trace));
    
    m = max([beta0 beta1 beta2 beta3]);

    B0 = 0; B1 = 0; B2 = 0; B3 = 0;
    
    if beta0 == m
        B0 = sqrt(beta0);
        B1 = (C(2,3)-C(3,2))/(4*B0);
        B2 = (C(3,1)-C(1,3))/(4*B0);
        B3 = (C(1,2)-C(2,1))/(4*B0);
    elseif beta1 == m
        B1 = sqrt(beta1);
        B0 = (C(2,3)-C(3,2))/(4*B1);
        B2 = (C(1,2)+C(2,1))/(4*B1);
        B3 = (C(3,1)+C(1,3))/(4*B1);
    elseif beta2 == m
        B2 = sqrt(beta2);
        B0 = (C(3,1)-C(1,3))/(4*B2);
        B1 = (C(1,2)+C(2,1))/(4*B2);
        B3 = (C(2,3)+C(3,2))/(4*B2);
    elseif beta3 == m
        B3 = sqrt(beta3);
        B0 = (C(1,2)-C(2,1))/(4*B3);
        B1 = (C(3,1)+C(1,3))/(4*B3);
        B2 = (C(2,3)+C(3,2))/(4*B3);
    end
    
    B = [B0 B1 B2 B3]';
end
