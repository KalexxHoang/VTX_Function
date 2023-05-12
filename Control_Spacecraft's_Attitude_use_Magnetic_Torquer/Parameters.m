clear;clc;close all;

%% Inertial Matrix
    J11 = 10;
    J22 = 5;
    J33 = 7;
    
    J = diag([J11 J22 J33]); % kg.m^2
    
%% Orbit Rate
    omega0 = 0.05; % rad/s

%% Dynamic
    f41 = (8*(J33 - J22)*omega0^2)/J11;
    f46 = (J11 - J22 + J33)*omega0/J11;
    f64 = (-J11 + J22 - J33)*omega0/J33;
    f52 = (6*(J33 - J11)*omega0^2)/J22;
    f63 = (2*(J11 - J22)*omega0^2)/J33;
    
    F = [0 0 0 0.5 0 0; ...
         0 0 0 0 0.5 0; ...
         0 0 0 0 0 0.5; ...
         f41 0 0 0 0 f46; ...
         0 f52 0 0 0 0; ...
         0 0 f63 f64 0 0];
     
%% Magnetic coils's induced moment
    m = [m1 m2 m3]';
    
%% The Earth's magnetic field
    % The field's dipole strength
    muy_f = 7.9*10^15; % Wb-m
    
    % The inclination od the spacecraft orbit
    i_m = ;
    
    % Semi-major axis
    a = ;
    b = muy_f/a^3*[cos(omega0*t)*sin(i_m) -cos(i_m) 2*sin(omega0*t)*sin(i_m)]';

%% The orbital period in system
    % The standard gravitation parameter
    muy = 3.986005*10^14; % m^3/s^2
    
    T = 2*pi*sqrt(a^3/muy);
    
%% Reduced Quaternion linear time-varying system
    % dx = Ax + B(t).m
    % x = [q' omega']';
    A = F; % 6x6
    
    b42 = (2*muy_f/(a^3*J11))*sin(i_m)*sin(omega0*t);
    b43 = (muy_f/(a^3*J11))*cos(i_m);
    b53 = (muy_f/(a^3*J22))*sin(i_m)*cos(omega0*t);
    b51 = -b42*J11/J22;
    b61 = -b43*J11/J33;
    b62 = -b53*J22/J33;
    
    B2 = [0 b42 b43; ...
          b51 0 b53; ...
          b61 b62 0];
     
    B = [zeros(3);B2];
     
%% Discrete Model
    % The sample time
    ts = ;
    % x_k+1 = A_k*x_k + B_k*m_k
    A_k = I + A*ts;
    B_k = B(k*ts)*ts;
    
    
    
    
    
    
    
    