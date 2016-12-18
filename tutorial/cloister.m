function f = cloister(xmin,xmax,ymin,ymax,n)

if nargin < 5 
    n = 9;
end

x0 = (xmin+xmax)/2;
y0 = (ymin+ymax)/2;

hsize = xmax-xmin; 
vsize = ymax-ymin;

tsize = diag([hsize vsize]);

outer = (-(n-3)/2 : (n-3)/2); 
inner = (-(n-3)/2 : (n-5)/2);

No = [outer; (n-1)/2*ones(1,numel(outer))];
Ni = [inner ; (n-3)/2*ones(1,numel(inner))];
E = [0 -1;1 0] * [No Ni];
points = [No Ni E -No -Ni -E];

f = tsize*points/(n-1);

f(1,:) = f(1,:) + x0;
f(2,:) = f(2,:) + y0;



