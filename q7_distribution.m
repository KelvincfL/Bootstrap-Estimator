format long
% plotting histogram of n(theta-T)
theta = 5;      % upper bound for the distribution
n=10^3;        % number of data points
M = 10^4;
T = zeros(M,1);
stat = zeros(M,1);
for i = 1:M
    % generating n iid data unif distribution on [0,theta]
    X = theta*rand(n,1);
    T(i) = max(X);
    stat(i) = n*(theta-T(i));
end
histogram(stat)
legend('n=10^3,M=10^4')

% plotting histogram for bootstrap n(theta-T)
B = 10^4;    % number of bootstrap samples
X_bootstrap = theta*rand(n,1);
T_bootstrap = zeros(B,1);
stat_bootstrap = zeros(B,1);
for k = 1:B
    rnum = randi([1,n],1,n);  % select n random indices in range(1,n)
    temp_y = zeros(n,1);       % current bootstrap sample
    % assign current bootstrap sample
    for j = 1:n
       temp_y(j) = X_bootstrap(rnum(j)); 
    end
    % find T
    T_bootstrap(k) = max(temp_y);
    stat_bootstrap(k) = n*(max(X_bootstrap)-T_bootstrap(k));
end
figure()
histogram(stat_bootstrap)
legend('n=10^3,B=10^4')