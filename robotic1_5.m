clear;clc

%% Forward kinematics n-axis

syms t
n = 6;
prt = 1; % Print angles on command window
% Parameters
a = [0 1 0.5 0 0.5 0.25];
alpha = [pi/2 0 0 pi/2 pi/2 0];
d = [1.5 0 0 0 0 0 0.25];
theta = [t cos(t*pi)/6 cos(t*pi)/2 5/4 5*t cos(t*pi)/3]*pi*0.4.*randn(1,6);

%%
T0_i = cell(1,n);
T0_j = cell(1,n);
Tj_i = cell(1,n);
T0_j{1} = eye(4);
for i = 1:n
    Tj_i{i} = forwardTransfer(a(i), alpha(i), d(i), theta(i));
    T0_i{i} = T0_j{i}*Tj_i{i};
    T0_j{i+1} = T0_i{i};
end
clear T0_j
%%

for i = 1:n
    x0_i{i} = simplify(T0_i{i}(1,4));
    y0_i{i} = simplify(T0_i{i}(2,4));
    z0_i{i} = simplify(T0_i{i}(3,4));
end

%%

t = linspace(0,5,300);

for i = 1:n
    X0_i{i} = eval(x0_i{i}).*ones(1,length(t));
    Y0_i{i} = eval(y0_i{i}).*ones(1,length(t));
    Z0_i{i} = eval(z0_i{i}).*ones(1,length(t));
end

for i = 1:n
    th{i} = eval(theta(i)).*ones(1,length(t));
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