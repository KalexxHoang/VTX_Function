function EA = Quaternions_2_EulerAngles(quater)
    % Input is a N_4x1 vector with Quaternions
    % Output is a N_3x1 vector of 3-2-1 Euler Angles
    
    q0 = quater(1);
    q1 = quater(2);
    q2 = quater(3);
    q3 = quater(4);
    
    EA1 = atan2(2*(q0*q1 + q2*q3),1 - 2*(q1^2 + q2^2)); % phi
    EA2 = asin(2*(q0*q2 - q1*q3)); % theta
    EA3 = atan2(2*(q0*q3 + q2*q1),1 - 2*(q3^2 + q2^2));
    
    EA = [EA1 EA2 EA3]';
EA = real(EA);