clear;clc;close all;

%% Step and simulation time
    step = 0.001;
    t = 0:step:250;

%% Controller's parameters
    K = 1; % kgm^2/s^2
    P = 3*eye(3); % kgm^2/s
    KI = 0.01; % s^-1
    I = 10*eye(3); % kgm^2
    
%% State vector
    sigma = cell(1,size(t,2));
    omega = cell(1,size(t,2));
    u = cell(1,size(t,2));
    
%% Initial condition
    sigma{1} = [-0.3 -0.4 0.2]';
    omega{1} = [0.2 0.2 0.2]';
    
    deltaL = [0.05 0.1 -0.1]';
    int_sigma = 0;

for i = 1:(size(t,2) - 1)
   %% Calculate integral of sigma 
   int_sigma = int_sigma + sigma{i}*step;
    
   %% Control signal
   u{i} = -K*sigma{i} - (P + P*KI*I)*omega{i} - K*P*KI*int_sigma + (P + P*KI*I)*omega{1} + cross(omega{i},(I*omega{i}));
   domega = inv(I)*(cross(omega{i},(I*omega{i})) + u{i} + deltaL);
   
   %% Update state
   omega{i+1} = omega{i} + step*domega;
   
   %% Update attitude
   sigma_tilde = [0 -sigma{i}(3) sigma{i}(2);sigma{i}(3) 0 -sigma{i}(1);-sigma{i}(2) sigma{i}(1) 0];
   dsigma = 1/4*((1 - dot(sigma{i},sigma{i}))*eye(3) + 2*sigma_tilde + 2*sigma{i}*sigma{i}')*omega{i};
   sigma{i+1} = sigma{i} + step*dsigma;
end
    u{250001} = u{25000};

%% Plot
    sigma = cell2mat(sigma);
    omega = cell2mat(omega);
    u = cell2mat(u);
    
    figure;
    plot(t,omega(1,:));
    hold on
    plot(t,omega(2,:));
    plot(t,omega(3,:));
    title('omega');
    hold off
    
    figure;
    plot(t,sigma(1,:));
    hold on
    plot(t,sigma(2,:));
    plot(t,sigma(3,:));
    title('sigma');
    hold off
    
    figure;
    plot(t,u(1,:));
    hold on
    plot(t,u(2,:));
    plot(t,u(3,:));
    title('u');
    hold off
    