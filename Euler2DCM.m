function C = Euler2DCM(theta1,theta2,theta3)
    % This function returns a DCM that expresses trasformation from Euler angles (3-2-1) to DCM
    theta1 = theta1*pi/180;
    theta2 = theta2*pi/180;
    theta3 = theta3*pi/180;
    
    C = Euler_x2DCM(theta3)*Euler_y2DCM(theta2)*Euler_z2DCM(theta1);
end