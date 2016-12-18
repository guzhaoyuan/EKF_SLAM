function [pf, PF_f, PF_p] = toFrame(F , p)
% NP angle intervals for one turn
%TOFRAME transform point P from global frame to frame F
%In:
%      F :     reference frame
%p :     point in global frame
%F = [fx ; fy ; falpha] p = [p x ; p y]
% Out:
% pf:
% PF f:
% PF p:
%point in frame F
%Jacobian wrt F
%Jacobian wrt p
            %   (c) 2010, 2011, 2012 Joan Sola
t = F(1:2);
a = F(3);

R = [cos(a) -sin(a) ; sin(a) cos(a)];

pf = R' * (p - t);
if nargout > 1 % Jacobians requested 
    px = p(1);
    py = p(2);
    x = t(1);
    y = t(2);
PF_f = [...
[ -cos(a), -sin(a),  cos(a)*(px - x) - sin(a)*(py - y)]
[ sin(a), -cos(a), - cos(a)*(px - x) - sin(a)*(py - y)]];
PF_p = R';
end
end

function f()
%% Symbolic code below ?? Generation and/or test of Jacobians
% ? Enable 'cell mode' to use this section
% ? Left?click once on the code below ? the cell should turn yellow
% ? Type ctrl+enter (Windows, Linux) or Cmd+enter (MacOSX) to execute % ? Check the Jacobian results in the Command Window.
syms x y a px py real
F = [x y a]';
p = [px py]';
pf = toFrame(F, p);
PF_f = jacobian(pf, F)
end