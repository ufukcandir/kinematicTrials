clear;clc

%% Inverse kinematics n-axis

syms theta1 theta2 theta3 theta4 theta5 theta6 t
prt = 0; % Print angles on command window
n = 6;
% Parameters
XYZ_target = [3 3 5];
theta = {theta1 theta2 theta3 theta4 theta5 theta6};

alpha = [pi/2 0 0,... 
    pi/3 pi/2 pi/2 0];
d = [3.5 0 0,... 
    0 0 0 0];

theta = [theta{1} theta{2} theta{3},... 
    0 theta{5} theta{6}];
a = [0 3 2.5 0,...
    0 1.5 1 0];

%%
T0_i = get_T0i(a,alpha,d,theta,n);

%%

XYZ_coors = simplify(T0_i{5}(1:3,4));
angles = solve(XYZ_coors == XYZ_target');

theta_sol = theta;
theta_sol(1) = real(eval(angles.theta1(1)));
theta_sol(2) = real(eval(angles.theta2(1)));
theta_sol(3) = real(eval(angles.theta3(1)));
theta_sol(4:6) = pi/6;

T0_i_sol = get_T0i(a,alpha,d,theta_sol,n);

%%

for i = 1:n
    x0_i{i} = (T0_i_sol{i}(1,4));
    y0_i{i} = (T0_i_sol{i}(2,4));
    z0_i{i} = (T0_i_sol{i}(3,4));
end

%%

t = linspace(0,5,30);

for i = 1:n
    X0_i{i} = (x0_i{i}).*ones(1,length(t));
    Y0_i{i} = (y0_i{i}).*ones(1,length(t));
    Z0_i{i} = (z0_i{i}).*ones(1,length(t));
end

for i = 1:n
    th{i} = eval(theta_sol(i)).*ones(1,length(t));
end


%%
hold off
trailColor = [t./max(t); 1-t./max(t); ones(1,length(t))];
for k = 1:length(t)
    if k~=1
        plot3(X0_i{n}(k-1:k),Y0_i{n}(k-1:k),Z0_i{n}(k-1:k),'Color',trailColor(:,k))
        hold on
    end
    
    arm(1) = plot3([0 X0_i{1}(k)], [0 Y0_i{1}(k)], [0 Z0_i{1}(k)],'r');
    for i = 2:n
        arm(i) = plot3([X0_i{i-1}(k) X0_i{i}(k)], [Y0_i{i-1}(k) Y0_i{i}(k)], [Z0_i{i-1}(k) Z0_i{i}(k)], 'Color', [mod(i,2) 0 mod(i+1,2)]);
    end
    xlim([-6 6])
    ylim([-6 6])
    zlim([-3 6])
    grid on
    pause(0.05)
    if k~=length(t)
        delete(arm)
    end
    if prt
        for i = 1:n
            fprintf('Theta%d: %.2f \t', i, th{i}(k)*180/pi)
        end
        fprintf('\n')
    end
end

%%










