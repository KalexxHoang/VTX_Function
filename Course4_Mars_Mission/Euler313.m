function DCM = Euler313(Omega,i,theta)
    DCM = Euler_z2DCM(theta)*Euler_x2DCM(i)*Euler_z2DCM(Omega); 
end