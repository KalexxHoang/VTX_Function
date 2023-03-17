function DCM = CRP2DCM(q)
    %% This function returns a DCM that is transformed form CRP
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    
    DCM = (1/(1 + dot(q',q)))*[(1 + q1^2 - q2^2 - q3^2) 2*(q1*q2 + q3) 2*(q1*q3 - q2);
            2*(q2*q1 - q3) (1 - q1^2 + q2^2 - q3^2) 2*(q2*q3 + q1);
            2*(q3*q1 + q2) 2*(q3*q2 - q1) (1 - q1^2 - q2^2 + q3^2)];

end
