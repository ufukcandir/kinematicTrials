clear
clc

%%
syms th0 th1 th2 th3 th4 th5
DH = [0 13 4.5 11.75 6.5 0;           % a
    2.2 0 0 0 0 3;                   % d
    pi/2 0 0 0 -pi/2 0;                % alpha
    th0' th1' pi/2 th3' th4' pi/2]'   % theta

n = size(DH,2);

target_theta = [-15 -30 45 -90]*pi/180;
%[60 -45 30 -15]*pi/180;
%% -------------------------------------------- Initializations
fprintf('Initializations\n')

L_a = DH(:,1); % Arm
L_d = DH(:,2); % Offset
L_alpha = DH(:,3); 
L_theta = DH(:,4);

n = length(L_a); % Number of joints

%% -------------------------------------------- Forward Kinematic
fprintf('Forward Kinematic\n');
angle_offset = [0 90 0 0]*pi/180; % (Motor angle) - (actual x-axis)

L_pos_sol = fkine4DOF(DH, target_theta, angle_offset);

%% -------------------------------------------- Numeric forward kinematic
fprintf('Numeric forward kinematics\n')
theta_num = subs(DH(:,4), symvar(DH(:,4)), target_theta+angle_offset);
T0_i = get_T0i(theta_num, DH(:,1), DH(:,2), DH(:,3));
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
    th{i} = theta_num(i);
end

%% -------------------------------------------- Plot
fprintf('Protting\n')

figure
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
fprintf('\nX: %.2f | Y: %.2f | Z: %.2f', L_pos_sol(1), L_pos_sol(2), L_pos_sol(3))
fprintf('\n')
%%
fprintf('Done.\n')

