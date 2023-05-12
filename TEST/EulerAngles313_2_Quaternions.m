function q = EulerAngles313_2_Quaternions(angles)
    Omega = angles(1);
    i = angles(2);
    omega = angles(3);

    q0 = cos(omega/2)*cos(i/2)*cos(Omega/2) - sin(omega/2)*cos(i/2)*sin(Omega/2);
    q1 = cos(omega/2)*sin(i/2)*cos(Omega/2) + sin(omega/2)*sin(i/2)*sin(Omega/2);
    q2 = -sin(omega/2)*sin(i/2)*cos(Omega/2) + cos(omega/2)*sin(i/2)*sin(Omega/2);
    q3 = sin(omega/2)*cos(i/2)*cos(Omega/2) + cos(omega/2)*cos(i/2)*sin(Omega/2);
    
    q = [q0 q1 q2 q3]';
end