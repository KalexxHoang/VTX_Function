clear;clc;close all;

%% Step and simulation time
    step = 0.001;
    t = 0:step:400;

%% Orbit parameters
    % Altitude
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

%% 3-1-3 Euler angle set 
    % Right ascension: Omega
    % Inclination angle: i
    % True latitude angle: theta
    
%% Orbit State
    % Initial orbit frame orientation angles
    Omega0_LMO = pi/9; % rad
    i0_LMO = pi/6; % rad
    theta0_LMO = pi/3; % rad
    
    Omega0_GMO = 0; % rad
    i0_GMO = 0; % rad
    theta0_GMO = 250*pi/180; % rad

%% Atttitude State
    % Initial attitude 
    sigma0_BN = [0.3 -0.4 0.5]';
    % Initial body angular velocity 
    omega0_B_BN = [1 1.75 -2.2]'*pi/180; % rad/s
    % The rigid LMO (Low Mars Orbit) spacecraft inertial tensor
    I = [10 0 0;0 5 0;0 0 7.5]; %kgm^2

    
%% State LMO
    t1 = 450; % s
    r_LMO_H = r_LMO*[1 0 0]';
    r_LMO_N = Euler313(Omega0_LMO,i0_LMO,theta0_LMO + dtheta_LMO*t1)'*r_LMO_H;
    
    % dr_N = r*dtheta*i_theta
    i_theta_LMO_H = [0 1 0]';
    dr_LMO_N = r_LMO*dtheta_LMO*Euler313(Omega0_LMO,i0_LMO,theta0_LMO + dtheta_LMO*t1)'*i_theta_LMO_H;
    
%% State GMO
    t2 = 1150; % s
    r_GMO_H = r_GMO*[1 0 0]';
    r_GMO_N1 = Euler313(Omega0_GMO,i0_GMO,theta0_GMO + dtheta_GMO*t2)'*r_GMO_H; 
    
    % dr_N = r*dtheta*i_theta
    i_theta_GMO_H = [0 1 0]';
    dr_GMO_N = r_GMO*dtheta_GMO*Euler313(Omega0_GMO,i0_GMO,theta0_GMO + dtheta_GMO*t2)'*i_theta_GMO_H;
    
%% 1 Sun Pointing
    % Reference Frame Rs
    % r3 -> n2
    % r1 -> -n1
    % r2 -> n3
    % Transform reference frame to MRP
    RN_Sun = [-1 0 0;0 0 1;0 1 0];
    q_RN_Sun = DCM_2_Quater(RN_Sun);
    sigma_RN_Sun = Quater_2_MRP(q_RN_Sun);
    
    % State vector
    sigma_BN_Sun = cell(1,size(t,2));
    omega_BN_Sun = cell(1,size(t,2));
    
    % Initial state
    sigma_BN_Sun{1} = sigma0_BN;
    omega_BN_Sun{1} = omega0_B_BN;
    
    % Controller
    % Controller's parameters
    K = 5;
    P = 10*eye(3);
    u_Sun = cell(1,size(t,2));
    
for i = 1:(size(t,2) - 1)
    % Differential of reference frame
    dsigma_RN_Sun = [0 0 0]';
    
    % Error attitude
    sigma_BR_Sun = sub_sigma(sigma_BN_Sun{i},sigma_RN_Sun);
   
    omega_RN_Sun = dsigma_2_omega(sigma_RN_Sun,dsigma_RN_Sun);
    omega_BR_Sun = omega_BN_Sun{i} - omega_RN_Sun;

	domega_RN_Sun = inv(I)*(cross(omega_RN_Sun,(I*omega_RN_Sun)));
   
	u_Sun{i} = -K*sigma_BR_Sun - P*omega_BR_Sun;
   
	domega_BN_Sun = inv(I)*(cross(omega_BN_Sun{i},(I*omega_BN_Sun{i})) + u_Sun{i});
   
	%% Update state
	omega_BN_Sun{i+1} = omega_BN_Sun{i} + step*domega_BN_Sun;
   
	%% Update attitude
	dsigma_BN = omega_2_dsigma(sigma_BN_Sun{i},omega_BN_Sun{i});
	sigma_BN_Sun{i+1} = sigma_BN_Sun{i} + step*dsigma_BN;
end
u_Sun{size(t,2)} = u_Sun{size(t,2)-1};

%% 2 Nadir Pointing
    % Nadir Pointing Reference Frame
    % r1 -> -i_r
    % r2 -> i_theta
    % r3 -> i_h
    % DCM transform Hill Frame to Reference Frame
    RH = [-1 0 0;0 1 0;0 0 -1];
    
    % State vector
    sigma_BN_Nadir = cell(1,size(t,2));
    omega_BN_Nadir = cell(1,size(t,2));
    
    % Initial state
    sigma_BN_Nadir{1} = sigma0_BN;
    omega_BN_Nadir{1} = omega0_B_BN;
    
    % Controller
    u_nadir = cell(1,size(t,2));
    sigma_RN_nadir = cell(1,size(t,2));
    
for i = 1:(size(t,2) - 1)
    % DCM transform Inertial Frame to Hill Frame
    HN = Euler313(Omega0_LMO,i0_LMO,theta0_LMO + dtheta_LMO*t(i));
    
    % DCM transform Inertial Frame to Body Fixed Frame
    RN_Nadir = RH*HN;
    q_RN_Nadir = DCM_2_Quater(RN_Nadir);
    sigma_RN_Nadir{i} = Quater_2_MRP(q_RN_Nadir);
    
    % Differential of reference frame
    % dsigma_RN_Nadir = [0 0 0]';
    
    % Error attitude
    sigma_BR_Nadir = sub_sigma(sigma_BN_Nadir{i},sigma_RN_Nadir{i});
    
    dOmega_LMO = 0;
    di_LMO = 0;
    omega_RN_Nadir = Euler313_2_omega(Omega0_LMO,i0_LMO,theta0_LMO + dtheta_LMO*t(i),dOmega_LMO,di_LMO,dtheta_LMO);
    omega_BR_Nadir = omega_BN_Nadir{i} - omega_RN_Nadir;

	domega_RN_Nadir = inv(I)*(cross(omega_RN_Nadir,(I*omega_RN_Nadir)));
   
	u_Nadir{i} = -K*sigma_BR_Nadir - P*omega_BR_Nadir + I*(domega_RN_Nadir - cross(omega_BN_Nadir{i},omega_RN_Nadir)) + cross(omega_BN_Nadir{i},(I*omega_BN_Nadir{i}));
   
	domega_BN_Nadir = inv(I)*(cross(omega_BN_Nadir{i},(I*omega_BN_Nadir{i})) + u_Nadir{i});
   
	%% Update state
	omega_BN_Nadir{i+1} = omega_BN_Nadir{i} + step*domega_BN_Nadir;
   
	%% Update attitude
	dsigma_BN = omega_2_dsigma(sigma_BN_Nadir{i},omega_BN_Nadir{i});
	sigma_BN_Nadir{i+1} = sigma_BN_Nadir{i} + step*dsigma_BN;
end
u_Nadir{size(t,2)} = u_Nadir{size(t,2)-1};
sigma_RN_Nadir{size(t,2)} = sigma_RN_Nadir{size(t,2)-1};
  
%% Plot Sun Mission
    sigma_BN_Sun = cell2mat(sigma_BN_Sun);
    omega_BN_Sun = cell2mat(omega_BN_Sun);
    u_Sun = cell2mat(u_Sun);
    
    figure;
    plot(t,omega_BN_Sun(1,:),'k--');
    hold on
    plot(t,omega_BN_Sun(2,:),'b-.');
    plot(t,omega_BN_Sun(3,:),'r');
    grid on
    title('omega sun');
    hold off
    
    figure;
    plot(t,sigma_BN_Sun(1,:),'k--');
    hold on
    plot(t,sigma_BN_Sun(2,:),'b-.');
    plot(t,sigma_BN_Sun(3,:),'r');
    grid on
    title('sigma sun');
    hold off
    
    figure;
    plot(t,u_Sun(1,:),'k--');
    hold on
    plot(t,u_Sun(2,:),'b-.');
    plot(t,u_Sun(3,:),'r');
    grid on
    title('u sun');
    hold off
    

%% Plot Nadir Mission
    sigma_RN_Nadir = cell2mat(sigma_RN_Nadir);
    sigma_BN_Nadir = cell2mat(sigma_BN_Nadir);
    omega_BN_Nadir = cell2mat(omega_BN_Nadir);
    u_Nadir = cell2mat(u_Nadir);
    
    figure;
    plot(t,omega_BN_Nadir(1,:),'k--');
    hold on
    plot(t,omega_BN_Nadir(2,:),'b-.');
    plot(t,omega_BN_Nadir(3,:),'r');
    grid on
    title('omega Nadir');
    hold off
    
    figure;
    plot(t,sigma_RN_Nadir(1,:),'k--');
    hold on
    plot(t,sigma_RN_Nadir(2,:),'b-.');
    plot(t,sigma_RN_Nadir(3,:),'r');
    grid on
    title('sigma RN Nadir');
    hold off
    
    figure;
    plot(t,sigma_BN_Nadir(1,:),'k--');
    hold on
    plot(t,sigma_BN_Nadir(2,:),'b-.');
    plot(t,sigma_BN_Nadir(3,:),'r');
    grid on
    title('sigma Nadir');
    hold off
    
    figure;
    plot(t,u_Nadir(1,:),'k--');
    hold on
    plot(t,u_Nadir(2,:),'b-.');
    plot(t,u_Nadir(3,:),'r');
    grid on
    title('u Nadir');
    hold off
    