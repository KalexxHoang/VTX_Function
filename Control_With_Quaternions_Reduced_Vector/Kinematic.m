%% Kinematic
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    
    dq = 0.5*[sqrt(1 - q1^2 - q2^2 - q3^2) -q3 q2; ...
              q3 sqrt(1 - q1^2 - q2^2 - q3^2) -q1; ...
              -q2 q1 sqrt(1 - q1^2 - q2^2 - q3^2)]*omega;