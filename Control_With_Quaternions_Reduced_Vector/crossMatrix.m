function S = crossMatrix(q)
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    
    S = [0 -q3 q2; ...
         q3 0 -q1; ...
         -q2 q1 0];
end