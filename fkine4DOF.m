function L_pos_sol = fkine4DOF(DH, theta, angle_offset)
%% -------------------------------------------- Initializations
L_a = DH(:,1); % Arm
L_d = DH(:,2); % Offset
L_alpha = DH(:,3); 
L_theta = DH(:,4);

n = length(L_a); % Number of joints

%% Optimizations
if exist('theta')
    L_theta = subs(L_theta, symvar(L_theta), theta);
end
if exist('angle_offset')==0
    angle_offset = [0 0 0 0];
end
%% -------------------------------------------- Numeric forward kinematic
fprintf('Numeric forward kinematics\n')

L_theta([1 2 4 5]) = L_theta([1 2 4 5])+(angle_offset)';

[T0_i, Tj_i] = get_T0i(L_theta, L_a, L_d, L_alpha);
for i=1:n
    joint_pos{i} = T0_i{i}(1:3,4); % Joint positions
end
L_pos_sol = round(joint_pos{end},6);

end