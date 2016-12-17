%% to be tested


%% init robot parameter
S1 = [1,1,0]';
S2 = [1,-1,0]';
S = [S1,S2];
%% init map
%x = zeros(3,1); %state vector, denotes the map, [R' M']'
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
wallPoints = 100;
wallmark = [linspace(corner1(1),corner2(1),wallPoints)',linspace(corner1(2),corner2(2),wallPoints)';
    linspace(corner2(1),corner3(1),wallPoints)',linspace(corner2(2),corner3(2),wallPoints)';
    linspace(corner3(1),corner4(1),wallPoints)',linspace(corner3(2),corner4(2),wallPoints)';
    linspace(corner4(1),corner1(1),wallPoints)',linspace(corner4(2),corner1(2),wallPoints)';];
%plot(wallmark(:,1),wallmark(:,2),'ro');
%% 
dx = (waypoint2 - waypoint1) / frequency; %Attention Bug! Angle changes along with position.
dx(3) = 0;
x = waypoint1;
%x = [0,0,3*pi/4]';

Z = directObservation(x,S,landmark(2,:));
worldR = inverseObservation(x,S,Z);
plot(worldR(1),worldR(2),'ro');



