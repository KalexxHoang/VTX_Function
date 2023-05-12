function dstate_dt = Satellite(t,state)
    % state_initial = [x0 y0 z0 dx0 dy0 dz0 quater0' omega1_0 omega2_0 omega3_0]'
    global BxI ByI BzI invI I m
    
    x = state(1);
    y = state(2);
    z = state(3);
    
    % dx = state(4);
    % dy = state(5);
    % dz = state(6);
    
    %% Translational Kinematics
    vel = state(4:6);
    
    %% Rotational Kinematics
    quater = state(7:10);
    omega1 = state(11);
    omega2 = state(12);
    omega3 = state(13);
    omega = state(11:13);
    
    QuaterMatrix = [0 -omega1 -omega2 -omega3; ...
                   omega1 0 omega3 -omega2; ...
                   omega2 -omega3 0 omega1; ...
                   omega3 omega2 -omega1 0];
               
    dquater = 0.5*QuaterMatrix*quater;
    
    %% Gravity Model
    planet
    r = state(1:3); % r = [x y z]'
    rho = norm(r);
    rhat = r/rho;
    Fgrav = -(G*M*m/rho^2)&rhat;
    
    %% Call the Magnetic Field Model
    % Convert Cartesian x,y,z into Lat, Lon, Alt
    phiE = 0;
    thetaE = acos(z/rho);
    psiE = atan2(y,x);
    latitude = 90 - thetaE*180/pi;
    longtitude = psiE*180/pi;
    rhoKm = (rho)/1000;
    [BN,BE,BD] = igrf('01-Jan-2020',latitude,longtitude,rhoKm,'geocentric');
    
    % Convert NED (North East Down to X,Y,Z in ECI Frame)
    % First we need to create a rotation matrix from the NED
    % to Inertial Frame
    BNED = [BN;BE;BD];
    BI = TIB(phiE,(thetaE + pi),psiE)*BNED;
    % BI = eye(3)*BNED;
    
    BxI = BI(1);
    ByI = BI(2);
    BzI = BI(3);
    
    %% Translational Dynamics
    F = Fgrav;
    accel = F/m;
    
    %% Magnetic Torquers Model
    LMN_Magtorquers = [0 0 0]';
    
    %% Rotational Dynamics
    H = I*omega;
    
    domega = invI*(LMN_Magtorquers - cross(omega,H));
    % domega = inv(I_S)*(M_P + M_M + M_R - S(omega_B/I)*H_S - dI_S*omega_B/I)
    % M_P: The moment from Propulsion
    % M_M: The moment from Magnetics Torquer
    % M_R: The moment from Reaction Wheel
    
    %% Return derivatives vector
    dstate_dt = [vel;accel;dquater;domega];
