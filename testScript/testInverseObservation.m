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
%% 
dx = (waypoint2 - waypoint1) / frequency; %Attention Bug! Angle changes along with position.
dx(3) = 0;
%x = waypoint1;
x = [0,0,3*pi/4]';

y = zeros(2,1);
y(1) = directObservation(x,S1,landmark(2,:));
y(2) = directObservation(x,S2,landmark(2,:));
worldR = inverseObservation(x,S,y);



