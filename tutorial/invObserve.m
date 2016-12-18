function [p, P_r, P_y] = invObserve(r, y)
    if nargout == 1 % No Jacobians requested
        p = fromFrame(r, invScan(y));
    else % Jacobians requested
        [p_r, PR_y] = invScan(y);
        [p, P_r, P_pr] = fromFrame(r, p_r);
        % here the chain rule !
        P_y = P_pr * PR_y;
    end
end


function f()
%%
syms rx ry ra yd ya real
r = [rx;ry;ra];
y = [yd;ya];
[p, P_r, P_y] = invObserve(r, y); % We extract also the coded Jacobians P r and P y 
% We use the symbolic result to test the coded Jacobians
simplify(P_r - jacobian(p,r)); % zero?matrix if coded Jacobian is correct 
simplify(P_y - jacobian(p,y)); % zero?matrix if coded Jacobian is correct
end