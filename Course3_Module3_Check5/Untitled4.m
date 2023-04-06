clear;clc;close all;

%% Step and simulation time
step = 0.001;
t = 0:step:100;

%% Controller's Parameters
I1 = 100;
I2 = 75;
I3 = 80;
I = [I1 0 0;0 I2 0;0 0 I3];

K = 5;
P = diag([22.3607 19.3649 20]);

%% State vectors
sigma = cell(1,size(t,2));
omega = cell(1,size(t,2));

%% Initial condition
sigma{1} = [0.1 0.2 -0.1]';
omega{1} = [pi/6 pi/18 -pi/9]';

for i = 1:(size(t,2) - 1)
   dsigma = 0.25*eye(3)*omega{i};
   domega = -K*inv(I)*sigma{i} - inv(I)*P*omega{i};
   
   %% Update state
   sigma{i+1} = sigma{i} + step*dsigma;
   omega{i+1} = omega{i} + step*domega;
end

%% Time decay constant
T = zeros(1,3);
for i = 1:3
   T(i) = 2*I(i,i)/P(i,i); 
end

%% Plot
    sigma = cell2mat(sigma);
    omega = cell2mat(omega);
    
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