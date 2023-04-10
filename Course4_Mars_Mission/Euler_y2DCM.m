function Cy = Euler_y2DCM(theta)
    % This function returns a DCM that expresses a rotation about Y
    Cy = [cos(theta) 0 -sin(theta);0 1 0;sin(theta) 0 cos(theta)];
end
