function sigma = DCM_2_MRP(DCM)
    trace = DCM(1,1) + DCM(2,2) + DCM(3,3);
    xi = sqrt(trace + 1);
    
    sigma = 1/(xi*(xi + 2))*[(DCM(2,3)-DCM(3,2)) (DCM(3,1)-DCM(1,3)) (DCM(1,2)-DCM(2,1))]';
end