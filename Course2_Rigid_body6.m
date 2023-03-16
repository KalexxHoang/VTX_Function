clear;clc;close all;

% Mass of Spacecraft
M = 12.5; % kg

% Spacecraft inertia tensor about the centre of mass
Ic_B = [10 1 -1;1 5 1;-1 1 8];

RcP_N = [-0.5;0.5;0.25]; % m

RcP_B = Euler2DCM(-10,10,5)*RcP_N;

% Cross operator
Rc_nga_B = [0 -RcP_B(3) RcP_B(2);RcP_B(3) 0 -RcP_B(1);-RcP_B(2) RcP_B(1) 0];

% Spacecraft inertia tensor about P
Ip_B = Ic_B + M*Rc_nga_B*Rc_nga_B';