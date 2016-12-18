
W = cloister(-4,4,-4,4,7);
%plot(W(1,:),W(2,:),'ro');
N = size(W,2);% numbers of landmarks
R = [0;-2;0];%Robot posi
U = [0.1 ; 0.05];%
Y = zeros(2, N);%measure of landmarks

x = zeros(numel(R)+numel(W), 1);
P = zeros(numel(x),numel(x));
q = [0.01;0.01]; % amplitude or standard deviation 
Q = diag(q.^2); % covariances matrix

s = [0.01;0.01*pi/180]; % amplitude or standard deviation 
S = diag(s.^2); % covariances matrix

mapspace = false(1,numel(x));

landmarks = zeros(2, N);

r           = find(mapspace==false, numel(R) ); % set robot pointer
mapspace(r) = true; % block map positions
x(r)        = R;    % initialize robot states
P(r,r)      = 0;    % initialize robot covariance

mapFig = figure(1); % create figure
cla;
axis([-6 6 -6 6]);
axis square;

WG = line(...
    'linestyle','none',...
    'marker','+',...
    'color','r',...
    'xdata',W(1,:),...
    'ydata',W(2,:));

Rshape0 = .2*[...
2 -1 -1 2;...
0  1 -1 0];

Rshape = fromFrame(R, Rshape0);

%real simulated robot
RG = line(...
    'linestyle','-',... 
    'marker','none',... 
    'color','r',... 
    'xdata',Rshape(1,:),... 
    'ydata',Rshape(2,:));

%estimated robot
rG = line(...
    'linestyle','-',... 
    'marker','none',... 
    'color','b',... 
    'xdata',Rshape(1,:),... 
    'ydata',Rshape(2,:));

%
reG = line(...
    'linestyle','-',... 
    'marker','none',... 
    'color','m',... 
    'xdata',[ ],... 
    'ydata',[ ]);

lG = line(...
    'linestyle','none',...
    'marker','+',...
    'color','b',...
    'xdata',[ ],...
    'ydata',[ ]);

leG = zeros(1,N);
for i = 1:numel(leG)
leG(i) = line(...
    'linestyle','-',... 
    'marker','none',... 
    'color','g',... 
    'xdata',[ ],... 
    'ydata',[ ]);
end

for t = 1:200
    % II.1 SIMULATOR
    % a. motion
    n = q .* randn(2,1);
    R = move(R, U, zeros(2,1) ); % we will perturb the estimator
    
    for i=1:N % i: landmark index
        v      = s .* randn(2,1);  % measurement noise
        Y(:,i) = observe(R, W(:,i)) + v;
    end
    
    m = landmarks(landmarks ~= 0)';
    rm = [r , m];
    
    [x(r), R_r, R_n] = move(x(r), U, n);
    P(r,m) = R_r * P(r,m);
    P(m,r) = P(r,m)';
    P(r,r) = R_r * P(r,r) * R_r'+R_n * Q * R_n';

    lids = find( landmarks(1,:) );
    
    for i = lids
        l = landmarks(:, i)';
        [e, E_r, E_l] = observe(x(r), x(l) );
        rl = [r , l];
        E_rl = [E_r, E_l];
        E = E_rl * P(rl, rl) * E_rl';
        
        Yi = Y(:, i);
        z = Yi - e;
        
        if z(2) > pi
        z(2) = z(2) - 2*pi; end
        if z(2) < -pi
        z(2) = z(2) + 2*pi;
        end
        Z = S + E;
        
        if z' * Z^-1 * z < 9
            K = P(rm, rl) * E_rl' * Z^-1;
            
            x(rm) = x(rm) + K*z; 
            P(rm,rm) = P(rm,rm) - K*Z*K';
        end
    end
    
    lids = find(landmarks(1,:)==0);
    if ~isempty(lids)
        i = lids(randi(numel(lids)));
        l = find(mapspace==false, 2);
        if ~isempty(l)
            mapspace(l) = true;
            landmarks(:,i) = l;
            
            Yi = Y(:,i);
            
            [x(l), L_r, L_y] = invObserve(x(r),Yi);
            P(l,rm) = L_r * P(r,rm);
            P(rm,l) = P(l,rm)';
            P(l,l) = L_r * P(r,r)*L_r'+L_y*S*L_y';
            
        end
    end
    
    Rshape = fromFrame(R, Rshape0);
    set(RG, 'xdata', Rshape(1,:), 'ydata', Rshape(2,:));
            
    Rshape = fromFrame(x(r), Rshape0);
    set(rG, 'xdata', Rshape(1,:), 'ydata', Rshape(2,:));

    re = x(r(1:2));
    RE = P(r(1:2),r(1:2));
    [xx,yy] = cov2elli(re,RE,3,16);
    set(reG, 'xdata', xx, 'ydata', yy);
    
    lids = find(landmarks(1,:));
    lx = x(landmarks(1,lids));
    ly = x(landmarks(2,lids));
    set(lG, 'xdata', lx, 'ydata', ly);
    
    for i = lids
        l       = landmarks(:,i);
        le      = x(l);
        LE      = P(l,l);
        [xx,yy] = cov2elli(le,LE,3,16);
        set(leG(i), 'xdata', xx, 'ydata', yy);
    end
    
    drawnow;
end
    