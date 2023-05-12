%% Initialize
    clear;clc;close all
    
%% Globals
    global BxI ByI BzI m I invI
    
%% Simulation of a Low Earth Satellite
    % Display the string: Simulation Started
    disp('Simulation Started');
    
%% Setup the IGRF Model
    disp(['You must download the IGRF model from MathWorks in order to'...
        'use this software']);
    addpath 'igrf/'
    
%% Get Planet Parameters
    planet
    
%% Get Mass and Inertia Properties
    inertia

%% Initial Condition Position and Velocity
    altitude = 600*1000; % m
    x0 = R + altitude;
    y0 = 0;
    z0 = 0;
    dx0 = 0;
    inclination = 56*pi/180;
    semi_major = norm([x0;y0;z0]); % Ban truc lon elip
    vcircular = sqrt(mu/semi_major); % mu = G*M_e
    dy0 = vcircular*cos(inclination);
    dz0 = vcircular*sin(inclination);

%% Initial Conditions for Attitude and Angular Velocity
    % Attitude
    phi0 = 0;
    theta0 = 0;
    psi0 = 0;
    
    ptp0 = [phi0 theta0 psi0]';
    
    quater0 = EulerAngles_2_Quaternions(ptp0);
    
    % Angular Velocity
    omega1_0 = 0;
    omega2_0 = 0;
    omega3_0 = 0;
    
    % State Initial
    state_initial = [x0 y0 z0 dx0 dy0 dz0 quater0' omega1_0 omega2_0 omega3_0]';

%%
    period = 2*pi/sqrt(mu)*semi_major^(3/2);
    number_of_orbits = 1;
    tspan = [0 period*number_of_orbits];
    
%% This is where we integrate the equations of motion
    [t,stateout] = ode45(@Satellite,tspan,state_initial);
    
%% Loop through Stateout to extract Magnetic Field
    BxIout = 0*stateout(:,1);
    ByIout = BxIout;
    BzIout = BxIout;
for i = 1:length(t)
    dstate_dt = Satellite(t(i),stateout(i,:)');
    BxIout(i) = BxI;
    ByIout(i) = ByI;
    BzIout(i) = BzI;
end
    
%% Convert state to kilometer
    stateout(:,1:6) = stateout(:,1:6)/1000;
    
%% Extract the State vector
    xout = stateout(:,1);
    yout = stateout(:,2);
    zout = stateout(:,3);
    
    quaterout = stateout(:,7:10);
    EAout = Quaternions_2_EulerAngles(quaterout);
    omega = stateout(:,11:13);
    
%% Plot
    figure
    plot(t,xout);
    hold on
    plot(t,yout);
    plot(t,zout);
    grid on
    hold off
    
    figure
    plot(t,quaterout(:,1));
    hold on
    plot(t,quaterout(:,2));
    plot(t,quaterout(:,3));
    plot(t,quaterout(:,4));