function [y, Y_r, Y_p] = observe(r, p)

if nargout == 1 % No Jacobians requested
    y = scan(toFrame(r,p));
else % Jacobians requested
    [pr, PR_r, PR_p] = toFrame(r, p);
    [y, Y_pr] = scan(pr);
    % The chain rule!
    Y_r = Y_pr * PR_r; 
    Y_p = Y_pr * PR_p;
end