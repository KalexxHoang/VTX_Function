function EA = DCm_2_EA313(C)
    Omega = atan(C(3,1)/(-C(3,2)));
    i = acos(C(3,3));
    omega = atan(C(1,3)/C(2,3));
    EA = [Omega i omega]';
end