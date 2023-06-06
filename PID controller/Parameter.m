clear;clc;close all

%% Inertial Matrix
    I = diag([5 8 7]);
    
%% PD Parameter   
    A_PD = [zeros(3) 0.5*eye(3);zeros(3,6)];
    B_PD = [zeros(3);-inv(I)];
    
    Q_PD = 10*eye(6);
    R_PD = eye(3);
    
    [K_PD,S,E] = lqrd(A_PD,B_PD,Q_PD,R_PD,0.5);