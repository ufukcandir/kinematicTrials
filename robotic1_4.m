clear;clc
close all
%% Forward kinematics

l1 = 1.8;
l2 = 1.0;
l3 = 0.5;
syms th1 th2 t

% Parameters
a1 = l1;
alpha1 = pi/2;
d1 = 0;
theta1 = 2*pi*t;

a2 = l2;
alpha2 = 0;
d2 = 0.0;
theta2 = 4 * pi*t;

a3 = l3;
alpha3 = 0;
d3 = 0;
theta3 = 80 * pi*t;

T0_1 = forwardTransfer(a1, alpha1, d1, theta1);
T1_2 = forwardTransfer(a2, alpha2, d2, theta2);
T2_3 = forwardTransfer(a3, alpha3, d3, theta3);
T0_2 = T0_1*T1_2;
T0_3 = T0_1*T1_2*T2_3;

x0_1 = T0_1(1,4);
y0_1 = T0_1(2,4);
z0_1 = T0_1(3,4);

x0_2 = simplify(T0_2(1,4));
y0_2 = simplify(T0_2(2,4));
z0_2 = simplify(T0_2(3,4));

x0_3 = simplify(T0_3(1,4));
y0_3 = simplify(T0_3(2,4));
z0_3 = simplify(T0_3(3,4));

%%

t = linspace(0,1,2000);

X0_1 = eval(x0_1).*ones(1,length(t));
Y0_1 = eval(y0_1).*ones(1,length(t));
Z0_1 = eval(z0_1).*ones(1,length(t));

X0_2 = eval(x0_2).*ones(1,length(t));
Y0_2 = eval(y0_2).*ones(1,length(t));
Z0_2 = eval(z0_2).*ones(1,length(t));

X0_3 = eval(x0_3).*ones(1,length(t));
Y0_3 = eval(y0_3).*ones(1,length(t));
Z0_3 = eval(z0_3).*ones(1,length(t));

for i = 1:length(t)
    
    plot3(X0_2(1:i),Y0_2(1:i),Z0_2(1:i),'r')
    hold on
    plot3(X0_3(1:i),Y0_3(1:i),Z0_3(1:i),'g')
    
    plot3([0 X0_1(i)], [0 Y0_1(i)], [0 Z0_1(i)]);
    plot3([X0_1(i) X0_2(i)], [Y0_1(i) Y0_2(i)], [Z0_1(i) Z0_2(i)]);
    plot3([X0_2(i) X0_3(i)], [Y0_2(i) Y0_3(i)], [Z0_2(i) Z0_3(i)]);
    hold off
    xlim([-4 4])
    ylim([-4 4])
    zlim([-4 4])
    grid on
    pause(0.001)
    
end

%%
t = 0;
dt = 0.001;

for i = 1:1000
    
    X0_1 = eval(x0_1);
    Y0_1 = eval(y0_1);
    Z0_1 = eval(z0_1);
    
    X0_2 = eval(x0_2);
    Y0_2 = eval(y0_2);
    Z0_2 = eval(z0_2);
    
    X0_3 = eval(x0_3);
    Y0_3 = eval(y0_3);
    Z0_3 = eval(z0_3);


    plot3([0 X0_1], [0 Y0_1], [0 Z0_1]);
    hold on
    plot3([X0_1 X0_2], [Y0_1 Y0_2], [Z0_1 Z0_2]);
    plot3([X0_2 X0_3], [Y0_2 Y0_3], [Z0_2 Z0_3]);
    hold off
    xlim([-4 4])
    ylim([-4 4])
    zlim([-4 4])
    grid on
    pause(0.001)
    t = t + dt;
end

%%

plot3(X0_3,Y0_3,Z0_3)
grid on
xlim([-4 4])
ylim([-4 4])
zlim([-4 4])








