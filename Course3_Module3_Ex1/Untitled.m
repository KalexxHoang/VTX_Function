clear;clc;close all;

%% Step and simulation time
step = 0.001;
t = 0:step:1000;

%% Inertial matrix
I1 = 100; % kgm^2
I2 = 75; % kgm^2
I3 = 80; % kgm^2
I = [I1 0 0;0 I2 0;0 0 I3];

%% Controller's parameters
K = 5;
P = 10*eye(3);
L = 0;

%% State
sigma_BN = cell(1,size(t,2));
omega_BN = cell(1,size(t,2));

%% Initial condition
sigma_BN{1} = [0.1 0.2 -0.1]';
omega_BN{1} = [pi/6 pi/18 -pi/9]';

for i = 1:(size(t,2) - 1)
   %% Control signal with reference frame equal to inertial frame
   %u = -K*sigma{i} - P*omega{i} + cross(omega{i},(I*omega{i}));
   
   %% Control signal with sigma_RN
   f = 0.05;
   sigma_RN = [0.2*sin(f*t(i)) 0.3*cos(f*t(i)) -0.3*sin(f*t(i))]';
   dsigma_RN = [0.2*f*cos(f*t(i)) -0.3*f*sin(f*t(i)) -0.3*f*cos(f*t(i))]';
   sigma_BR = sub_sigma(sigma_BN{i},sigma_RN);
   
   omega_RN = dsigma_2_omega(sigma_RN,dsigma_RN);
   omega_BR = omega_BN{i} - omega_RN;
   
   domega_RN = [0 0 0]';
   u = -K*sigma_BR - P*omega_BR + I*(domega_RN - cross(omega_BN{i},omega_RN)) + cross(omega_BN{i},(I*omega_BN{i}));
   
   domega_BN = inv(I)*(cross(omega_BN{i},(I*omega_BN{i})) + u);
   
   %% Update state
   omega_BN{i+1} = omega_BN{i} + step*domega_BN;
   
   %% Update attitude
   dsigma_BN = omega_2_dsigma(sigma_BN{i},omega_BN{i});
   sigma_BN{i+1} = sigma_BN{i} + step*dsigma_BN;
end

%% Plot
    sigma_BN = cell2mat(sigma_BN);
    omega_BN = cell2mat(omega_BN);
    
    figure;
    plot(t,omega_BN(1,:));
    hold on
    plot(t,omega_BN(2,:));
    plot(t,omega_BN(3,:));
    title('omega');
    hold off
    
    figure;
    plot(t,sigma_BN(1,:));
    hold on
    plot(t,sigma_BN(2,:));
    plot(t,sigma_BN(3,:));
    title('sigma');
    hold off