clear;clc

%% Hafta 2 ders notları
% Yönelim
A = [1 1 1];
B = [1 1 1];

%           X_B | Y_B | Z_B
angles_AB = [0 pi/2 pi/2;       % X_A
            pi/2 pi/3 pi/6;     % Y_A
            pi/2 5*pi/6 pi/3];  % Z_A

angles_BA = angles_AB';

%% Finding AB_R

AB_R = (A'*B).*cos(angles_AB)


%% Finding BA_R

BA_R = (B'*A).*cos(angles_BA)

%% Finding A_P from B_P

B_P = [3 4 5]';
A_P = AB_R*B_P

%% ================================================================
% Konum

B_P = [3 4 5];
A_P_BORG = [10 10 10];
A_P = B_P + A_P_BORG;

%% ================================================================
% Final Equation

A = [1 1 1];
B = [1 1 1];

B_P = [3 4 5]';
A_P_BORG = [10 10 10]';

%           X_B | Y_B | Z_B
angles_AB = [0 pi/2 pi/2;       % X_A
            pi/2 pi/3 pi/6;     % Y_A
            pi/2 5*pi/6 pi/3];  % Z_A

AB_R = (A'*B).*cos(angles_AB);

A_P = AB_R*B_P + A_P_BORG;

%% ================================================================
% Transformation Matrix

A = [1 1 1];
B = [1 1 1];

B_P = [3 4 5]';
A_P_BORG = [10 10 10]';

%           X_B | Y_B | Z_B
angles_AB = [0 pi/2 pi/2;       % X_A
            pi/2 pi/3 pi/6;     % Y_A
            pi/2 5*pi/6 pi/3];  % Z_A

AB_R = (A'*B).*cos(angles_AB);

AB_T = [AB_R A_P_BORG; zeros(1,3) 1];

A_P = AB_T*[B_P; 1];
A_P = A_P(1:3)

%% ================================================================
% 2B Dönme işlemi

P_lenght = 10;
alpha = 30*pi/180;
P_xy = [cos(alpha); sin(alpha)]

theta = 30*pi/180;
R = [cos(theta) -sin(theta);
    sin(theta) cos(theta)];

P_11 = R*(P_xy*P_lenght)

%% ================================================================
% 3B Dönme işlemi

alpha = 60*pi/180;

% Z ekseninde dönme
R_Z = [cos(alpha) -sin(alpha) 0 0;
    sin(alpha) cos(alpha) 0 0;
    0 0 1 0;
    0 0 0 1];

% Y ekseninde dönme
R_Y = [cos(alpha) 0 sin(alpha) 0;
    0 1 0 0;
    -sin(alpha) 0 cos(alpha) 0;
    0 0 0 1];

% X ekseninde dönme
R_X = [1 0 0 0;
    0 cos(alpha) -sin(alpha) 0;
    0 sin(alpha) cos(alpha) 0;
    0 0 0 1];





