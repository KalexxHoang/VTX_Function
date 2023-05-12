function DCM = CRP2DCM(q)
    %% This function returns a DCM that is transformed form CRP
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q_cross = [0 -q3 q2;q3 0 -q1;-q2 q1 0];
    
    DCM = (1/(1 + q'*q))*[(1 + q1^2 - q2^2 - q3^2) 2*(q1*q2 + q3) 2*(q1*q3 - q2);2*(q2*q1 - q3) (1 - q1^2 + q2^2 - q3^2) 2*(q2*q3 + q1);2*(q3*q1 + q2) 2*(q3*q2 - q1) (1 - q1^2 - q2^2 + q3^2)];
    %DCM = (1/(1 + q'*q))*((1 - q'*q)*eye(3) + 2*q*q' - 2*q_cross);
end
