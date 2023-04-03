q1 = q(1);
q2 = q(2);
q3 = q(3);

dq1 = dq(1);
dq2 = dq(2);
dq3 = dq(3);

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

Matrix = [dq'*dM_q1*dq;dq'*dM_q2*dq;dq'*dM_q3*dq];

%% dM
dM11 = 0;
dM12 = [(m2 + m3)*l1*l2*sin(q2 - q1) -(m2 + m3)*l1*l2*sin(q2 - q1) 0]*dq;
dM13 = [m3*l1*l3*sin(q3 - q1) 0 -m3*l1*l3*sin(q3 - q1)];

dM21 = [(m2 + m3)*l1*l2*sin(q2 - q1) -(m2 + m3)*l1*l2*sin(q2 - q1) 0]*dq;
dM22 = 0;
dM23 = [0 m3*l1*l3*sin(q3 - q2) -m3*l1*l3*sin(q3 - q2)]*dq;

dM31 = [m3*l1*l3*sin(q3 - q1) 0 -m3*l1*l3*sin(q3 - q1)]*dq;
dM32 = [0 m3*l1*l3*sin(q3 - q2) -m3*l1*l3*sin(q3 - q2)]*dq;
dM33 = 0;

dM = [dM11 dM12 dM13;dM21 dM22 dM23;dM31 dM32 dM33];
