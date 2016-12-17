close all;
clear;
%% init robot parameter
S1 = [-0.01,0.01,0]';
S2 = [0.01,0.01,0]';

%% init map
x_mean = zeros(3,1);%mean position of robot
P = zeros(3);% the covariance matrix of x

frequency = 100;
waypoint1 = [4,0,3*pi/4]';
waypoint2 = [0,4,5*pi/4]';
waypoint3 = [-4,0,-pi/4]';
waypoint4 = [0,-4,pi/4]';

corner1 = [10,10]';
corner2 = [-10,10]';
corner3 = [-10,-10]';
corner4 = [10,-10]';

landmark = [5 5;-5 5;-5 -5;5 -5];


%% plot figure
dx = (waypoint2 - waypoint1) / frequency; %Attention Bug! Angle changes along with position.
dx(3) = 0;
x = waypoint1;

figure('name','map');%figure 1
hold on;
axis([-12 12 -12 12]);
grid on;
line(corner1,corner2);
line(corner2,corner3);
line(corner3,corner4);
line(corner4,corner1);
plot(landmark(:,1),landmark(:,2),'bx');

figure('name','view');%figure 2
pause;

figure(1);
h_old = plot(x(1),x(2),'ro');
for i = 1:frequency
    pause(0.05);
    x = movePosition(x,dx);
    y = directMonoObservation(x,S1,landmark(2,:));disp(y);
    figure(1);
    %delete(h_old);
    h = plot(x(1),x(2),'ro');
    %h_old = h;
    figure(2);
    plot(i,y,'ro');
    hold on;
end

%figure;
%plot([1:10]',rand(10,1));

