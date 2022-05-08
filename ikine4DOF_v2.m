function L_motor_sol = ikine4DOF_v2(DH, target_pos, angle_range_motor, angle_offset)
%% -------------------------------------------- Initializations
L_a = DH(:,1); % Arm
L_d = DH(:,2); % Offset
L_alpha = DH(:,3); 
L_theta = DH(:,4);

n = length(L_a); % Number of joints

%% Optimizations
if exist('angle_offset')==0
    angle_offset = [0 0 0 0];
end
if exist('angle_range_motor')==0
    angle_range_motor = [-100 100; 15 165; -125 95]*pi/180;
end
angle_range_theta = [angle_range_motor(:,1)+angle_offset',...
                    angle_range_motor(:,2)+angle_offset'];
%% -------------------------------------------- Symbolic forward kinematic
fprintf('Symbolic forward kinematics\n')

[T0_i, Tj_i] = get_T0i(L_theta, L_a, L_d, L_alpha);
for i=1:n
    joint_pos_sym{i} = T0_i{i}(1:3,4); % Joint positions
end

%% -------------------------------------------- Inverse kinematics
fprintf('Applying inverse kinematics\n')

% Position matching
eq = ( joint_pos_sym{n-1} == (target_pos + [0 0 L_d(end)])' );

% Set direction
theta_sym = symvar(L_theta);
th_4 = findTh4(theta_sym);
eq = subs(eq, theta_sym(4), th_4);

% Solving for angles
sol_angle = vpasolve(eq, symvar(eq), angle_range_theta(1:3,:));
theta_num = round(struct2array(sol_angle)',12);

% Conditions
err = 0;
if any(size(theta_num)'==0)
    theta_num = angle_offset(1:3)';
    err = 1;
end
Th_4 = findTh4(theta_num);

th4_cond = (Th_4 < angle_range_theta(end,1)) || (Th_4 > angle_range_theta(end,2));

if th4_cond
    theta_num = angle_offset(1:3)';
    err = 1;
end

if err
    f_msg = 'Unable to find proper solution';
    f_box = errordlg(f_msg,'Error');
    error('Solution results are out of range.');
end

theta_num = [theta_num; Th_4];

% Assign angles
L_theta_sol = eval(subs(L_theta, symvar(L_theta), theta_num'));

% Apply offset to find motor angle
L_motor_sol = L_theta_sol;
L_motor_sol([1 2 4 5]) = L_theta_sol([1 2 4 5])-(angle_offset)';
end

