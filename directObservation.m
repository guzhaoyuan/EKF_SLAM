%make observation with known R,S,Li
%input:
%   R,  Robot Pose,[x,y,theta]'
%   S,  Sensor Pose,[x,y,theta]'
%   Li, Position of the i th Landmark,[x,y]
%Output:
%   yi, The Observation result
%   yi=NaN if angle is larger than 90?
function yi = directObservation(R,S,Li)
    yi = NaN;
    
    observe_center = [R(1:2) + theta2R(R(3))*S(1:2); R(3)+S(3)];
    
    inner_product = cos(observe_center(3)) * (Li(1)-observe_center(1)) + sin(observe_center(3)) * (Li(2)-observe_center(2));
    if inner_product < 0 % the Li is in the back of the sensor
       yi = NaN;
       %disp('in the back');
    else % Li is in the front of the sensor
        dtheta = atan((Li(2)-observe_center(2))/(Li(1)-observe_center(1))) - observe_center(3);
        while dtheta < -pi/2
             dtheta = dtheta + pi;
        end
        while dtheta > pi/2
             dtheta = dtheta - pi;
        end
        yi = -tan(dtheta);
        if ((yi > 1) || (yi < -1))
            yi = NaN;
        end
    end
end