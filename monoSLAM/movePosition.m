%input: origin_x    :[origin_x origin_y origin_theta]'
%       dx          :[dx dy dtheta]'
%output:new_x       :[new_x new_y new_theta]'
function new_x = movePosition(origin_x,dx)
    new_x = origin_x + dx;
end