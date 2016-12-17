%make observation with known R,S,Li
%input:
%   R,  Robot Pose,[x,y,theta]'
%   S,  Sensor Pose,[x,y,theta]'
%   Li, Position of the i th Landmark,[x,y]
%Output:
%   yi, The Observation result
%   yi=NaN if angle is larger than 90?
function Z = directObservation(R,S,Li)
    Z = zeros(1,2);
    y1 = NaN;
    y2 = NaN;
    
    observe_center1 = [R(1:2) + theta2R(R(3))*S(1:2,1); R(3)+S(3,1)];
    observe_center2 = [R(1:2) + theta2R(R(3))*S(1:2,2); R(3)+S(3,2)];
    
    inner_product1 = cos(observe_center1(3)) * (Li(1)-observe_center1(1)) + sin(observe_center1(3)) * (Li(2)-observe_center1(2));
    inner_product2 = cos(observe_center2(3)) * (Li(1)-observe_center2(1)) + sin(observe_center2(3)) * (Li(2)-observe_center2(2));
    
    if inner_product1 < 0 % the Li is in the back of the sensor
       y1 = NaN;
       %disp('in the back');
    else % Li is in the front of the sensor
        dtheta1 = atan((Li(2)-observe_center1(2))/(Li(1)-observe_center1(1))) - observe_center1(3);
        while dtheta1 < -pi/2
             dtheta1 = dtheta1 + pi;
        end
        while dtheta1 > pi/2
             dtheta1 = dtheta1 - pi;
        end
        y1 = -tan(dtheta1);
        if ((y1 > 1) || (y1 < -1))
            y1 = NaN;
        end
    end
    
    if inner_product2 < 0 % the Li is in the back of the sensor
       y2 = NaN;
       %disp('in the back');
    else % Li is in the front of the sensor
        dtheta2 = atan((Li(2)-observe_center2(2))/(Li(1)-observe_center2(1))) - observe_center2(3);
        while dtheta2 < -pi/2
             dtheta2 = dtheta2 + pi;
        end
        while dtheta2 > pi/2
             dtheta2 = dtheta2 - pi;
        end
        y2 = -tan(dtheta2);
        if ((y2 > 1) || (y2 < -1))
            y2 = NaN;
        end
    end
    
    Z = [y1,y2];
end