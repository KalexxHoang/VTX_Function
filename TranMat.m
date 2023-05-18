function T = TranMat(q)
    q0 = q(1);
    q1 = q(2);
    q2 = q(3);
    q3 = q(4);

    T = [(q0 + q1 - q2 - q3) 2*(q1*q2 + q3*q0) 2*(q1*q3 - q2*q0); ...
          2*(q1*q2 - q3*q0) (q0 - q1 + q2 - q3) 2*(q2*q3 + q1*q0); ...
          2*(q1*q3 + q2*q0) 2*(q2*q3 - q1*q0) (q0 - q1 - q2 + q3)];
end