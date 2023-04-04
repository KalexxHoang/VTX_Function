clear;clc;close all;

%% Step and simulation time
step = 0.001;
t = 0:step:100;

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
sigma = cell(1,size(t,2));
omega = cell(1,size(t,2));

%% Initial condition
sigma{1} = [0.1 0.2 -0.1]';
omega{1} = [pi/6 pi/18 -pi/9]';

for i = 1:size(t,2)
   %% Control signal
   u = -K*sigma{i} - P*omega{i} + cross(omega{i},(I*omega{i}));
   domega = inv(I)*(cross(omega{i},(I*omega{i})) + u);
   
   %% Update state
   omega{i+1} = omega{i} + step*domega;
   
   %% Update attitude
   sigma_tilde = [0 -sigma{i}(3) sigma{i}(2);sigma{i}(3) 0 -sigma{i}(1);-sigma{i}(2) sigma{i}(1) 0];
   dsigma = 1/4*((1 - dot(sigma{i},sigma{i}))*eye(3) + 2*sigma_tilde + 2*sigma{i}*sigma{i}')*omega{i};
   sigma{i+1} = sigma{i} + step*dsigma;
end

%% Plot
    sigma = cell2mat(sigma);
    omega = cell2mat(omega);
    
    figure;
    plot(t,omega(1,1:100001));
    hold on
    plot(t,omega(2,1:100001));
    plot(t,omega(3,1:100001));
    title('omega');
    hold off
    
    figure;
    plot(t,sigma(1,1:100001));
    hold on
    plot(t,sigma(2,1:100001));
    plot(t,sigma(3,1:100001));
    title('sigma');
    hold off