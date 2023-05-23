function q_RB = hieuQuater(q_RI,q_BI)
    %% [RI]=[RB].[BI]
    B0 = q_BI(1);
    B1 = q_BI(2);
    B2 = q_BI(3);
    B3 = q_BI(4);
    
    Matrix = [B0 -B1 -B2 -B3; ...
              B1 B0 -B3 B2; ...
              B2 B3 B0 -B1; ...
              B3 -B2 B1 B0];
    q_RB = inv(Matrix)*q_RI;

end