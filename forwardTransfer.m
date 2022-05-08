function D = forwardTransfer(a,alpha,d,theta)

% Rotation (z,theta)
A = [cos(theta) -sin(theta)   0    0;
     sin(theta)  cos(theta)   0    0;
     0           0            1    0;
     0           0            0    1];
A = vpa(A,3);

% Translation (a,0,d)
B = [1  0   0   a;
     0  1   0   0;
     0  0   1   d;
     0  0   0   1];
B = vpa(B,3);

% Rotation (x,alpha)
C = [1  0           0           0;
     0  cos(alpha) -sin(alpha)  0;
     0  sin(alpha)  cos(alpha)  0;
     0  0           0           1];
C = vpa(C,3);

D = A*B*C;
 
end