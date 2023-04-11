clear;clc;close all;

%% Altitude
    h = 400; % km
    % Radius of Mars
    R = 3396.19; % km
    % Radius of orbit
    r_LMO = R + h; % km
    % Mars gravity constant
    muy = 42828.3; % km^3/s^2
    % Constant orbit rate
    dtheta_LMO = sqrt(muy/r_LMO^3); % rad/s
    % Rotation period of Mars: 1h37'
    T = (24*60 + 37)*60; % s
    % Orbit radius of GMO (Geosynchronous Mars Orbit)
    r_GMO = 20424.2; %km
    % GMO orbit rate
    dtheta_GMO = sqrt(muy/r_GMO^3); % rad/s

%% Initial orbit frame orientation angles
    Omega0_LMO = pi/9; % rad
    i0_LMO = pi/6; % rad
    theta0_LMO = pi/3; % rad
    
    Omega0_GMO = 0; % rad
    i0_GMO = 0; % rad
    theta0_GMO = 250*pi/180; % rad
    
%% Initial attitude 
    sigma0_BN = [0.3 -0.4 0.5]';
    % Initial body angular velocity 
    omega0_B_BN = [1 1.75 -2.2]'*pi/180; % rad/s
    % The rigid LMO (Low Mars Orbit) spacecraft inertial tensor
    I = [10 0 0;0 5 0;0 0 7.5]; %kgm^2
    
%% Controller's parameters
    K = 5;
    P = 10*eye(3);