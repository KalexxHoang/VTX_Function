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
    KI = 0.005*eye(3);
    L = 0;
    deltaL = [0.5 -0.3 0.2]'; %Nm

    %% State
    sigma_BN = cell(1,size(t,2));
    omega_BN = cell(1,size(t,2));

    %% Initial condition
    sigma_BN{1} = [0.1 0.2 -0.1]';
    omega_BN{1} = [pi/6 pi/18 -pi/9]';

    int_sigma_BR = [0 0 0]';

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
   
   %% Calculate integral of sigma_BR
   int_sigma_BR = int_sigma_BR + sigma_BR*step;
   
   %% Calculate delta_omega
   if i == 1
       delta_omega0 = omega_BN{i} - omega_RN;
   end
   delta_omega = omega_BN{i} - omega_RN;
   
   %% Calculate domega_RN
   ddsigma_RN = [-0.2*f^2*sin(f*t(i)) -0.3*f^2*cos(f*t(i)) 0.3*f^2*sin(f*t(i))]';
   %domega_RN = sigma_2_domega(sigma_RN,dsigma_RN,ddsigma_RN);
   %domega_RN = [0 0 0]';
   domega_RN = inv(I)*(cross(omega_RN,(I*omega_RN)) + deltaL);
   
   %% Controller
   u = -K*sigma_BR - (P + P*KI*I)*delta_omega - K*P*KI*int_sigma_BR + (P + P*KI*I)*delta_omega0 + I*(domega_RN - cross(omega_BN{i},omega_RN)) + cross(omega_BN{i},(I*omega_BN{i}));
   
   domega_BN = inv(I)*(cross(omega_BN{i},(I*omega_BN{i})) + u + deltaL);
   
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