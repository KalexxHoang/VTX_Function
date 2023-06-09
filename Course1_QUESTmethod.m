function determinant = QUESTmethod(K,s)
%% Function returns determinant of matrix (K-s*I_4x4)
    d1 = (K(1,1)-s)*(((K(2,2)-s)*(K(3,3)-s)*(K(4,4)-s) + K(2,3)*K(3,4)*K(4,2) + K(2,4)*K(3,2)*K(4,3)) - (K(4,2)*(K(3,3)-s)*K(2,4) + K(4,3)*K(3,4)*(K(2,2)-s) + (K(4,4)-s)*K(3,2)*K(2,3)));
    
    d2 = -K(1,2)*((K(2,1)*(K(3,3)-s)*(K(4,4)-s) + K(2,3)*K(3,4)*K(4,1) + K(2,4)*K(3,1)*K(4,3)) - (K(4,1)*(K(3,3)-s)*K(2,4) + K(4,3)*K(3,4)*K(2,1) + (K(4,4)-s)*K(3,1)*K(2,3)));
    
    d3 = K(1,3)*((K(2,1)*K(3,2)*(K(4,4)-s) + (K(2,2)-s)*K(3,4)*K(4,1) + K(2,4)*K(3,1)*K(4,2)) - (K(4,1)*K(3,2)*K(2,4) + K(4,2)*K(3,4)*K(2,1) + (K(4,4)-s)*K(3,1)*(K(2,2)-s)));
    
    d4 = -K(1,4)*((K(2,1)*K(3,2)*K(4,3) + (K(2,2)-s)*(K(3,3)-s)*K(4,1) + K(2,3)*K(3,1)*K(4,2)) - (K(4,1)*K(3,2)*K(2,3) + K(4,2)*(K(3,3)-s)*K(2,1) + K(4,3)*K(3,1)*(K(2,2)-s)));
    
    determinant = d1 + d2 + d3 + d4;

end