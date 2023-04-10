close all;

%% Plot Sun Mission
    figure;
    plot(t,omega_BN_Sun(1,:),'k--');
    hold on
    plot(t,omega_BN_Sun(2,:),'b-.');
    plot(t,omega_BN_Sun(3,:),'r');
    grid on
    title('omega BN sun');
    hold off
    
    figure;
    plot(t,omega_BR_Sun(1,:),'k--');
    hold on
    plot(t,omega_BR_Sun(2,:),'b-.');
    plot(t,omega_BR_Sun(3,:),'r');
    grid on
    title('omega BR sun');
    hold off
    
    figure;
    plot(t,sigma_BN_Sun(1,:),'k--');
    hold on
    plot(t,sigma_BN_Sun(2,:),'b-.');
    plot(t,sigma_BN_Sun(3,:),'r');
    grid on
    title('sigma BN sun');
    hold off
    
    figure;
    plot(t,sigma_BR_Sun(1,:),'k--');
    hold on
    plot(t,sigma_BR_Sun(2,:),'b-.');
    plot(t,sigma_BR_Sun(3,:),'r');
    grid on
    title('sigma BR sun');
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
	figure;
    plot(t,omega_BN_Nadir(1,:),'k--');
    hold on
    plot(t,omega_BN_Nadir(2,:),'b-.');
    plot(t,omega_BN_Nadir(3,:),'r');
    grid on
    title('omega BN Nadir');
    hold off
    
    figure;
    plot(t,omega_BR_Nadir(1,:),'k--');
    hold on
    plot(t,omega_BR_Nadir(2,:),'b-.');
    plot(t,omega_BR_Nadir(3,:),'r');
    grid on
    title('omega BR Nadir');
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
    title('sigma BN Nadir');
    hold off
    
    figure;
    plot(t,sigma_BR_Nadir(1,:),'k--');
    hold on
    plot(t,sigma_BR_Nadir(2,:),'b-.');
    plot(t,sigma_BR_Nadir(3,:),'r');
    grid on
    title('sigma BR Nadir');
    hold off
    
    figure;
    plot(t,u_Nadir(1,:),'k--');
    hold on
    plot(t,u_Nadir(2,:),'b-.');
    plot(t,u_Nadir(3,:),'r');
    grid on
    title('u Nadir');
    hold off

%% Plot GMO Pointing Mission
    figure;
    plot(t,omega_BN_CM(1,:),'k--');
    hold on
    plot(t,omega_BN_CM(2,:),'b-.');
    plot(t,omega_BN_CM(3,:),'r');
    grid on
    title('omega BN CM');
    hold off
    
    figure;
    plot(t,omega_BR_CM(1,:),'k--');
    hold on
    plot(t,omega_BR_CM(2,:),'b-.');
    plot(t,omega_BR_CM(3,:),'r');
    grid on
    title('omega BR CM');
    hold off
    
    figure;
    plot(t,sigma_RN_CM(1,:),'k--');
    hold on
    plot(t,sigma_RN_CM(2,:),'b-.');
    plot(t,sigma_RN_CM(3,:),'r');
    grid on
    title('sigma RN CM');
    hold off
    
    figure;
    plot(t,sigma_BN_CM(1,:),'k--');
    hold on
    plot(t,sigma_BN_CM(2,:),'b-.');
    plot(t,sigma_BN_CM(3,:),'r');
    grid on
    title('sigma BN CM');
    hold off
    
    figure;
    plot(t,sigma_BR_CM(1,:),'k--');
    hold on
    plot(t,sigma_BR_CM(2,:),'b-.');
    plot(t,sigma_BR_CM(3,:),'r');
    grid on
    title('sigma BR CM');
    hold off
    
    figure;
    plot(t,u_CM(1,:),'k--');
    hold on
    plot(t,u_CM(2,:),'b-.');
    plot(t,u_CM(3,:),'r');
    grid on
    title('u CM');
    hold off
