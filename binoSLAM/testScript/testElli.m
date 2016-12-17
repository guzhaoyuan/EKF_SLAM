x = [1;2];
P = [2 3;3 2];
[xx,yy] = cov2elli(x, P, 3);
plot(xx,yy);
axis equal