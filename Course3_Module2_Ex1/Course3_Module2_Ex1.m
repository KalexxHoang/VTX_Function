%% Mass matrix
q1 = q(1);
q2 = q(2);
q3 = q(3);

M = [(m1 + m2 + m3)*l1^2 (m2 + m3)*l1*l2*cos(q2 - q1) m3*l1*l3*cos(q3 - q1); ...
(m2 + m3)*l1*l2*cos(q2 - q1) (m2 + m3)*l2^2 m3*l1*l3*cos(q3 - q2); ...
m3*l1*l3*cos(q3 - q1) m3*l1*l3*cos(q3 - q2) m3*l3^2];