clear;clc

%% Hafta 3 ders notları
% Example 2.8


alpha = -pi/6;
R_X = [1 0 0;
    0 cos(alpha) -sin(alpha);
    0 sin(alpha) cos(alpha)];

alpha = pi/2;
R_Y = [cos(alpha) 0 sin(alpha);
    0 1 0;
    -sin(alpha) 0 cos(alpha)];

AB_R = R_Y*R_X

%% Example 2.9

alpha = pi/6;
R_Z = [cos(alpha) -sin(alpha) 0;
    sin(alpha) cos(alpha) 0;
    0 0 1];

alpha = pi/2;
R_Y = [cos(alpha) 0 sin(alpha);
    0 1 0;
    -sin(alpha) 0 cos(alpha)];

AB_R = R_Z*R_Y

%% ================================================================
% Transformation Matrix Properties

A = [1 1 1];
B = [1 1 1];

B_P = [3 4 5]';
A_P_BORG = [10 10 10]';

%           X_B | Y_B | Z_B
angles_AB = [90 120 30;     % X_A
            90 30 60;       % Y_A
            180 90 90];     % Z_A
angles_AB = angles_AB*pi/180;
AB_R = (A'*B).*cos(angles_AB);

AB_T = [AB_R A_P_BORG; zeros(1,3) 1];

% AB_T^-1 = BA_T

BA_T = AB_T^-1
% or
BA_T = [AB_R' -AB_R'*A_P_BORG; zeros(1,3) 1]

%% ================================================================
% Ardışık Dönüşüm Matrisleri (Hafta 3 sayfa 11)

% B_P = BC_T * C_P
% AC_T = AB_T * BC_T

% AC_T = [AB_R*BC_R AB_R*B_P_CORG+A_P_BORG; 0 0 0 1]

















