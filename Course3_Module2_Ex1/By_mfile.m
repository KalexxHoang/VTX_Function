clear;clc;close all;
%% Step and simulation time
step = 0.001;
t = 0:step:20;

l1 = 1;
l2 = 1;
l3 = 1;
m1 = 1;
m2 = 1;
m3 = 1;
P1 = 1;
P2 = -0.72;

%% State vector
q = cell(1,size(t,2));
dq = cell(1,size(t,2));

%% Initial condition
q{1} = [-pi/2 pi/6 0]';
dq{1} = [0 0 pi/18]';

for i = 1:size(t,2)
   q1 = q{i}(1);
   q2 = q{i}(2);
   q3 = q{i}(3);
   
   %% Mass matrix
    M = [(m1 + m2 + m3)*l1^2 (m2 + m3)*l1*l2*cos(q2 - q1) m3*l1*l3*cos(q3 - q1); ...
    (m2 + m3)*l1*l2*cos(q2 - q1) (m2 + m3)*l2^2 m3*l1*l3*cos(q3 - q2); ...
    m3*l1*l3*cos(q3 - q1) m3*l1*l3*cos(q3 - q2) m3*l3^2];

    %% dq'*M_q(q)*dq
    dM_q1 = [0 (m2 + m3)*l1*l2*sin(q2 - q1) m3*l1*l3*sin(q3 - q1); ...
    (m2 + m3)*l1*l2*sin(q2 - q1) 0 0; ...
    m3*l1*l3*sin(q3 - q1) 0 0];

    dM_q2 = [0 -(m2 + m3)*l1*l2*sin(q2 - q1) 0; ...
    -(m2 + m3)*l1*l2*sin(q2 - q1) 0 m3*l1*l3*sin(q3 - q2); ...
    0 m3*l1*l3*sin(q3 - q2) 0];

    dM_q3 = [0 0 -m3*l1*l3*sin(q3 - q1); ...
    0 0 -m3*l1*l3*sin(q3 - q2); ...
    -m3*l1*l3*sin(q3 - q1) -m3*l1*l3*sin(q3 - q2) 0];

    Matrix = [dq{i}'*dM_q1*dq{i};dq{i}'*dM_q2*dq{i};dq{i}'*dM_q3*dq{i}];

    %% dM
    dM11 = 0;
    dM12 = [(m2 + m3)*l1*l2*sin(q2 - q1) -(m2 + m3)*l1*l2*sin(q2 - q1) 0]*dq{i};
    dM13 = [m3*l1*l3*sin(q3 - q1) 0 -m3*l1*l3*sin(q3 - q1)]*dq{i};

    dM21 = [(m2 + m3)*l1*l2*sin(q2 - q1) -(m2 + m3)*l1*l2*sin(q2 - q1) 0]*dq{i};
    dM22 = 0;
    dM23 = [0 m3*l1*l3*sin(q3 - q2) -m3*l1*l3*sin(q3 - q2)]*dq{i};

    dM31 = [m3*l1*l3*sin(q3 - q1) 0 -m3*l1*l3*sin(q3 - q1)]*dq{i};
    dM32 = [0 m3*l1*l3*sin(q3 - q2) -m3*l1*l3*sin(q3 - q2)]*dq{i};
    dM33 = 0;

    dM = [dM11 dM12 dM13;dM21 dM22 dM23;dM31 dM32 dM33];
    
    %% Force vector
    Q = -P1*dq{i};
    %Q = -P2*M*dq{i};

    ddq = inv(M)*(-dM*dq{i} + 1/2*Matrix + Q);
    
    %% Update state
    dq{i+1} = dq{i} + ddq*step;
    q{i+1} = q{i} + dq{i}*step;
end

%% Plot 
    q = cell2mat(q);
    dq = cell2mat(dq);

    figure;
    plot(t,q(1,1:20001));
    hold on
    plot(t,q(2,1:20001));
    plot(t,q(3,1:20001));
    legend('q1','q2','q3');
    hold off
    
    figure
    plot(t,dq(1,1:20001));
    hold on
    plot(t,dq(2,1:20001));
    plot(t,dq(3,1:20001));
    legend('dq1','dq2','dq3');
    hold off
