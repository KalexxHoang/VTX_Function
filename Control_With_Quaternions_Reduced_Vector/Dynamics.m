%% Quaternions
q = [q1 q2 q3]';
quater = [q0 q']';

h = [0 h2 0]';

%% omega_lvlh_B
    omega_lvlh_B = [-2*q3 -1 2*q1]'*omega0;
    
%% K1 = J*omega_lvlh_B
    K1 = [-2*J11*q3*omega0 -J22*omega0 2*J33*q1*omega0]';
    
%% K2 = cross(omega_lvlh_B,(J*omega_lvlh_B))
    K2 = omega0^2*[2*(J22 - J33)*q1 0 2*(J22 - J11)*q3]';
   
%% K3 = cross(omega_lvlh_B,h)
    K3 = omega0*[2*h2*q1 0 2*h2*q3]';
    
%% Derivative of f with respect to omega, omega ≈ 0, q1=q2=q3 ≈ 0 
    %df_domega = -J*crossMatrix(omega_lvlh_B) + crossMatrix(K1) - crossMatrix(omega_lvlh_B)*J + crossMatrix(h);
    df_domega = [0 0 ((J11 - J22 + J33)*omega0 + h2); ...
                 0 0 0; ...
                 (-(J11 - J22 + J33)*omega0 - h2) 0 0];
    
%% Derivative of f with respect to q, omega ≈ 0, q1=q2=q3 ≈ 0 
    df_dq = [(2*omega0^2*(J33 - J22) + 2*h0*omega0) 0 0; ...
              0 0 0; ...
              0 0 (2*omega0^2*(J11 - J22) + 2*h0*omega0)];
          
%% Derivative of g with respect to omega, omega ≈ 0, q1=q2=q3 ≈ 0 
    dg_domega = 0.54*eye(3);
    
%% Derivative of g with respect to omega, omega ≈ 0, q1=q2=q3 ≈ 0 
    dg_dq = 0.5*zeros(3);
    
%% The gravity gradient torque
    %tgg = [6*omega0^2*(J33 - J22)*q1 6*omega0^2*(J33 - J11)*q2 0]';
    tgg = [6*omega0^2*(J33 - J22) 0 0;0 6*omega0^2*(J33 - J11) 0;0 0 0]*q;
    
%% Dynamics 
    %J*domega = df_domega*omega + df_dq*q + tgg + u;
    
    f41 = 2*(J33 - J22)*omega0^2 + 2*h2*omega0;
    f46 = (J11 - J22 + J33)*omega0 + h2;
    f64 = -f46;
    f52 = 6*(J33 - J11)*omega0^2;
    f63 = 2*(J11 - J22)*omega0^2 + 2*h2*omega0;
    
    A = [0 0 0 0.5 0 0; ...
         0 0 0 0 0.5 0; ...
         0 0 0 0 0 0.5; ...
         f41 0 0 0 0 f46; ...
         0 f52 0 0 0 0; ...
         0 0 f63 f64 0 0];
     
    N = [eye(3) zeros(3);zeros(3) J];
     
    %N*[dq' domega']' = A*[q' omega']' + [0 0 0 u']';
    
    
    
    