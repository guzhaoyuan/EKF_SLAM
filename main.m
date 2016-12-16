clc;
clear;
close all;
%% init robot parameter
S1 = [-1,1,0]';%sensor position compared to robot center
S2 = [1,1,0]';
S = [S1,S2];
%% init map
%x = zeros(3,1); %state vector, denotes the map, [R' M']'
x_mean = zeros(3,1);%mean position of robot
P = zeros(3);% the covariance matrix of x

frequency = 20;
waypoint1 = [4,0,3*pi/4]';
waypoint2 = [0,4,5*pi/4]';
waypoint3 = [-4,0,-pi/4]';
waypoint4 = [0,-4,pi/4]';

corner1 = [10,10]';
corner2 = [-10,10]';
corner3 = [-10,-10]';
corner4 = [10,-10]';

%LandMark:[ x1 y1,
%           - -,
%           - -,
%           - -]
landmark = [5 5;-5 5;-5 -5;5 -5];
wallPoints = 10;
wallmark = [linspace(corner1(1),corner2(1),wallPoints)',linspace(corner1(2),corner2(2),wallPoints)';
    linspace(corner2(1),corner3(1),wallPoints)',linspace(corner2(2),corner3(2),wallPoints)';
    linspace(corner3(1),corner4(1),wallPoints)',linspace(corner3(2),corner4(2),wallPoints)';
    linspace(corner4(1),corner1(1),wallPoints)',linspace(corner4(2),corner1(2),wallPoints)';];

%% main entry of the whole program

dx = (waypoint2 - waypoint1) / frequency; %Attention Bug! Angle changes along with position.
x = waypoint1;

observeAll(x,S,wallmark);

axis([-12 12 -12 12]);
grid on;

for i = 1:frequency
    x = movePosition(x,dx);
    plot(x(1),x(2),'ro');
    hold on;
    Z = observeAll(x,S,wallmark);
    plot(Z(:,1),Z(:,2),'bo');
    %pause;
end

plot(landmark(:,1),landmark(:,2),'bx');
line(corner1,corner2);
line(corner2,corner3);
line(corner3,corner4);
line(corner4,corner1);

