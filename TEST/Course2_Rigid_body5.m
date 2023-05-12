clear;clc;close all;

% A body angular velocity
omega_N = [0.01;-0.01;0.01]; % rad/s

% The inertia matrix
I_B = [10 1 -1;1 5 1;-1 1 8]; 

% Angular velocity in Body frame
omega_B = Euler2DCM(-10,10,5)*omega_N;

% Angular momentum in Body frame
H_B = I_B*omega_B;
