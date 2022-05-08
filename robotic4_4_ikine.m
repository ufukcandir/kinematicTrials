clear
clc

%%
syms th0 th1 th2 th3 th4 th5
DH = [0 13 4.5 11.75 6.5 0;           % a
    2.2 0 0 0 0 3;                   % d
    pi/2 0 0 0 -pi/2 0;                % alpha
    th0' th1' pi/2 th3' th4' pi/2]'   % theta

target_pos = [-4 -5 25];
%% -------------------------------------------- Initializations
fprintf('Initializations\n')

L_a = DH(:,1); % Arm
L_d = DH(:,2); % Offset
L_alpha = DH(:,3); 
L_theta = DH(:,4);

n = size(DH,1); % Number of joints

%% -------------------------------------------- Inverse kinematics
angle_offset = [0 90 0 0]*pi/180; % (Motor angle) - (actual x-axis)
angle_range_motor = [-100 100; -75 75; -125 95; -155 35]*pi/180;

L_motor_sol = ikine4DOF_v2(DH, target_pos, angle_range_motor, angle_offset);

%% -------------------------------------------- Numeric forward kinematic
fprintf('Numeric forward kinematics\n')

L_theta_sol = L_motor_sol;
L_theta_sol([1 2 4 5]) = L_motor_sol([1 2 4 5])+(angle_offset)';

T0_i = get_T0i(L_theta_sol, DH(:,1), DH(:,2), DH(:,3));
for i=1:n
    joint_pos_num{i} = T0_i{i}(1:3,4); % Joint positions
end

%% -------------------------------------------- Time definition
fprintf('Time definition\n')

for i = 1:n
    X0_i{i} = joint_pos_num{i}(1);
    Y0_i{i} = joint_pos_num{i}(2);
    Z0_i{i} = joint_pos_num{i}(3);
end

for i = 1:n
    th{i} = L_theta_sol(i);
end

%% -------------------------------------------- Plot
fprintf('Protting\n')

figure(4)
arm(1) = plot3([0 X0_i{1}], [0 Y0_i{1}], [0 Z0_i{1}],'r',...
    'LineWidth', 1+n/4);
hold on
for i = 2:n
    arm(i) = plot3([X0_i{i-1} X0_i{i}],...
        [Y0_i{i-1} Y0_i{i}],...
        [Z0_i{i-1} Z0_i{i}],...
        'Color', [mod(i,2) 0 mod(i+1,2)],...
        'LineWidth', 1+(n-i)/4);
end
xlim([-25 25])
ylim([-25 25])
zlim([-15 30])
grid on

for i = 1:n
    fprintf('Theta%d: %.2f \t', i, th{i}*180/pi)
end
fprintf('\n')

%%
fprintf('Done.\n')







