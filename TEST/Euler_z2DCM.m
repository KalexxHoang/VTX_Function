function Cz = Euler_z2DCM(theta)
    % This function returns a DCM that expresses a rotation about Z
    Cz = [cos(theta) sin(theta) 0;-sin(theta) cos(theta) 0;0 0 1];    
end