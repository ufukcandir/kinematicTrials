clear
clc

%%
syms th0 th1 th2 th3 th4 th5
DH = [0 13 4.5 11.75 6.5 0;           % a
    2.2 0 0 0 0 3;                   % d
    pi/2 0 0 0 -pi/2 0;                % alpha
    th0' th1' pi/2 th3' th4' pi/2]'   % theta


%% -------------------------------------------- Initializations
fprintf('Initializations\n')

L_a = DH(:,1); % Arm
L_d = DH(:,2); % Offset
L_alpha = DH(:,3); 
L_theta = DH(:,4);

n = size(DH,1); % Number of joints
f = 10; % step size

%%
target_pos = [-15 5 1; -15 -5 1; -25 -5 1; -25 5 1;-15 5 1]';

% Increase resolution of target position set
track = [];
for i=1:3
    track_row = [];
    for k = 2:size(target_pos,2)
    track_row = [track_row, linspace(target_pos(i,k-1),target_pos(i,k),f)];
    end
    track = [track; track_row];
end

%% -------------------------------------------- Inverse kinematics
angle_offset = [0 90 0 0]*pi/180; % (Motor angle) - (actual x-axis)
angle_range_motor = [-100 100; 
                    -75 75; 
                    -125 95; 
                    -155 35]*pi/180;

for i = 1:size(track,2)
    L_motor_sol(:,i) = ikine4DOF_v2(DH, track(:,i)', angle_range_motor, angle_offset);
end

writematrix(round(L_motor_sol([1 2 4 5],:)'*180/pi, 3), 'angles.txt');
fprintf('Done.\n')




















