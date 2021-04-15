clear;clc

%% Hafta 2 
% Example 2.2 

A = [1 1 1];
B = [1 1 1];

%           X_B | Y_B | Z_B
angles_AB = [0 pi/2 pi/2;       % X_A
            pi/2 pi/3 5*pi/6;   % Y_A
            pi/2 pi/6 pi/3];    % Z_A

AB_R = (A'*B).*cos(angles_AB)

B_P = [0 0 2]';
A_P = AB_R*B_P

%% Example 2.3

A = [1 1 1];
B = [1 1 1];

%           X_B | Y_B | Z_B
angles_AB = [90 120 30;     % X_A
            90 30 60;       % Y_A
            180 90 90];     % Z_A
angles_AB = angles_AB*pi/180;

AB_R = (A'*B).*cos(angles_AB)

%% Example 2.4

A = [1 1 1];
B = [1 1 1];
C = [1 1 1];

%           X_C | Y_C | Z_C
angles_AC = [30 60 90;     % X_A
            60 150 90;       % Y_A
            90 90 180];     % Z_A
angles_AC = angles_AC*pi/180;
AC_R = (A'*C).*cos(angles_AC)


angles_BC = [150 120 90;
            90 90 0;
            120 30 90];
angles_BC = angles_BC*pi/180;
BC_R = (B'*C).*cos(angles_BC)

CA_R = AC_R'

%% Example 2.5

A = [1 1 1];
B = [1 1 1];

angles_AB = [30 90 60;
            90 0 90;
            120 90 30];
angles_AB = angles_AB*pi/180;
AB_R = (A'*B).*cos(angles_AB);

A_P_BORG = [5 0 10]';
B_P = [7 0 3]';

AB_T = [AB_R A_P_BORG; zeros(1,3) 1];

A_P = AB_T*[B_P; 1];
A_P = A_P(1:3)


%% Example 2.6






