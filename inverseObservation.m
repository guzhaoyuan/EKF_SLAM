%make observation with known R,S,Li
%input:
%   R,  Robot Pose
%   S,  Sensor Pose  
%   y, Observation of the all Landmark
%Output:
%   [x,y], Position of the i th Landmark
function worldR = inverseObservation(R,S,y)
%    worldR = S(:,1)+S(:,2);
%    f = @(worldR) triangu(worldR,S,y); % function of dummy variable y
%    fsolve(f,worldR);
%   worldR = [worldR; 1];
%   worldR = worldR + R;
    S1 = S(:,1);
    S2 = S(:,2);
    
    observe_center = [R(1:2) + theta2R(R(3))*S1(1:2), R(1:2) + theta2R(R(3))*S2(1:2); R(3)+S1(3), R(3)+S2(3)];
    syms ReferX ReferY;
    vb =  (ReferX - observe_center(1,1))*tan(R(3)-atan(y(1))) + (observe_center(2,1) - ReferY);
    vc =  (ReferX - observe_center(1,2))*tan(R(3)-atan(y(2))) + (observe_center(2,2) - ReferY);
    [ReferX,ReferY] = solve(vb,vc);
    worldR = [ReferX,ReferY]';
    plot(worldR(1),worldR(2),'ro');
end