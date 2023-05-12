function BN = addQuaternions(BR,RN)
    %% [BN] = [BR]*[RN]
    q0 = BR(1);
    q1 = BR(2);
    q2 = BR(3);
    q3 = BR(4);
    
    Matrix = [q0 -q1 -q2 -q3; ...
              q1 q0 q3 -q2; ...
              q2 -q3 q0 q1; ...
              q3 q2 -q1 q0];
    BN = Matrix*RN;
end