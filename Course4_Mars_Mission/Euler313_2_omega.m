function omega = Euler313_2_omega(Omega,i,theta,dOmega,di,dtheta)
    omega = [(sin(theta)*sin(i)) cos(theta) 0; ...
             (cos(theta)*sin(i)) -sin(theta) 0; ...
             cos(i) 0 1]*[dOmega di dtheta]';    
end