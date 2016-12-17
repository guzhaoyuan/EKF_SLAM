function F = triangu(Position,S,y)
%	F = zeros(3,1);
    k1 = 1/y(1);%Attention! might become infinite.
    k2 = 1/y(2);
    F(1) = k1 * (Position(1) - S(1,1)) + S(2,1) - Position(2);
    F(2) = k2 * (Position(1) - S(1,2)) + S(2,2) - Position(2);
end