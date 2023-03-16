function Cx = Euler_x2DCM(theta)
    % This function returns a DCM that expresses a rotation about X
    Cx = [1 0 0;0 cos(theta) sin(theta);0 -sin(theta) cos(theta)];
end