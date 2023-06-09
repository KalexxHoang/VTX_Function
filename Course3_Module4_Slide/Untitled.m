clear;clc;close all;

%% Step and simulation time
step = 0.001;
t = 0:step:300;

%% Parameters
I = [140 0 0;0 100 0;0 0 80]; % kgm^2
P = diag([18.67 2.67 10.67]); % kgm^2/s
K = 7.11; % kgm^2/s^2
u_max = 1; % Nm

%% State vector
sigma = cell(1,size(t,2));
omega = cell(1,size(t,2));
u = cell(1,size(t,2));

%% Initial condition
sigma{1} = [0.6 -0.4 0.2]';
omega{1} = [0.7 0.2 -0.15]'; % rad/s

for i = 1:(size(t,2) - 1)
   %% Controller
   u{i} = -K*sigma{i} - P*omega{i}; 
   for j = 1:3
      if abs(u{i}(j)) > u_max
          u{i}(j) = sign(u{i}(j))*u_max;
      end
   end
   domega = inv(I)*(cross(omega{i},(I*omega{i})) + u{i});
   
   %% Update state
   omega{i+1} = omega{i} + step*domega;
   
   %% Update attitude
   dsigma = omega_2_dsigma(sigma{i},omega{i});
   sigma{i+1} = sigma{i} + step*dsigma;
end
u{size(t,2)} = u{size(t,2)-1};

%% Plot
    sigma = cell2mat(sigma);
    omega = cell2mat(omega);
    u = cell2mat(u);
    
    figure;
    plot(t,omega(1,:),'k--');
    hold on
    plot(t,omega(2,:),'b-.');
    plot(t,omega(3,:),'r');
    grid on
    title('omega');
    hold off
    
    figure;
    plot(t,sigma(1,:),'k--');
    hold on
    plot(t,sigma(2,:),'b-.');
    plot(t,sigma(3,:),'r');
    grid on
    title('sigma');
    hold off
    
    figure;
    plot(t,u(1,:),'k--');
    hold on
    plot(t,u(2,:),'b-.');
    plot(t,u(3,:),'r');
    ylim([-1.2 1.2]);
    grid on
    title('u');
    hold off