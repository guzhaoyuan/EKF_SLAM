function [p, P_r, P_y] = invObserve(r, y)
if nargout == 1 % No Jacobians requested
    p   = fromFrame(r, invScan(y));
else % Jacobians requested
[p_r, PR_y] = invScan(y);
[p, P_r, P_pr] = fromFrame(r, p_r);
    % here the chain rule !
P_y = P_pr * PR_y;
end
end
function f()
%% Symbolic code below ?? Generation and/or test of Jacobians
% ? Enable 'cell mode' to use this section
% ? Left?click once on the code below ? the cell should turn yellow
% ? Type ctrl+enter (Windows, Linux) or Cmd+enter (MacOSX) to execute
% ? Check the Jacobian results in the Command Window.
syms rx ry ra yd ya real
r = [rx;ry;ra];
y = [yd;ya];
[p, P_r, P_y] = invObserve(r, y); % We extract also the coded Jacobians P r and P y % We use the symbolic result to test the coded Jacobians
simplify(P_r - jacobian(p,r)); % zero?matrix if coded Jacobian is correct simplify(P y ? jacobian(p,y)) % zero?matrix if coded Jacobian is correct
end