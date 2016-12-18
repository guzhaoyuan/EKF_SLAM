function [y, Y_p] = scan (p)
px = p(1);
py = p(2);
d = sqrt(px^2+py^2);
a = atan2(py,px);
% a = atan(py/px);  % use this line if you are in symbolic mode.
y = [d;a];
if nargout > 1 % Jacobians requested
Y_p = [...
px/sqrt(px^2+py^2) , py/sqrt(px^2+py^2)
-py/(px^2*(py^2/px^2 + 1)), 1/(px*(py^2/px^2 + 1)) ];
end
end
function f()
%%
syms px py real
p = [px;py];
y = scan(p);
Y_p = jacobian(y,p);
[y,Y_p] = scan(p);
simplify(Y_p - jacobian(y,p));
end