clear;clc;close all;

%% Step and simulation time
step = 0.001;
t = 0:step:30;

%% Parameters
I = [30 0 0;0 20 0;0 0 10]; % kgm^2
K = 1; % s^-2
P = 3*eye(3); % m

%% State
sigma_BN = cell(1,size(t,2));
omega_BN = cell(1,size(t,2));
u = cell(1,size(t,2));

%% Initial condition
sigma_BN{1} = [-0.3 -0.4 0.2]';
omega_BN{1} = [0.2 0.2 0.2]';

for i = 1:(size(t,2) - 1)
   domega = -P*omega_BN{i} - (omega_BN{i}*omega_BN{i}' + (4*K/(1 + dot(sigma_BN{i},sigma_BN{i})) - dot(omega_BN{i},omega_BN{i})/2)*eye(3))*sigma_BN{i};
   
   %% Controller
   u{i} = cross(omega_BN{i},(I*omega_BN{i})) + I*domega;
   
   %%  Update state
   omega_BN{i+1} = omega_BN{i} + step*domega;
   
   %% Update attitude
   dsigma = omega_2_dsigma(sigma_BN{i},omega_BN{i});
   sigma_BN{i+1} = sigma_BN{i} + step*dsigma;
end

u{size(t,2)} = u{size(t,2)-1};

%% Plot
    sigma_BN = cell2mat(sigma_BN);
    omega_BN = cell2mat(omega_BN);
    u = cell2mat(u);
    
    figure;
    plot(t,omega_BN(1,:),'g--');
    hold on
    plot(t,omega_BN(2,:),'b-.');
    plot(t,omega_BN(3,:),'r');
    title('omega');
    hold off
    
    figure;
    plot(t,sigma_BN(1,:),'g--');
    hold on
    plot(t,sigma_BN(2,:),'b-.');
    plot(t,sigma_BN(3,:),'r');
    title('sigma');
    hold off
    
    figure;
    plot(t,u(1,:),'g--');
    hold on
    plot(t,u(2,:),'b-.');
    plot(t,u(3,:),'r');
    title('u');
    hold off