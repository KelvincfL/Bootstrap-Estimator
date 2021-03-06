format long
B = 10^6;    % number of bootstrap samples
T = zeros(B,1);     % stores values of T(Y)
theta = 5;      % upper bound for the distribution
N = [10^3,10^4];        % number of data points
sigma_hat = zeros(numel(N),1);
for n = 1:numel(N)
% generating n iid data unif distribution on [0,theta]
    X = theta*rand(N(n),1);
    for i = 1:B
        rnum = randi([1,N(n)],1,N(n));  % select n random indices in range(1,n)
        temp_y = zeros(N(n),1);       % current bootstrap sample
        % assign current bootstrap sample
        for j = 1:N(n)
           temp_y(j) = X(rnum(j)); 
        end
        % find T
        T(i) = max(temp_y);
    end    
    % caching T_mean
    T_mean = sum(T)/B;
    % calculate sigma(T;F_hat)
    sigma_hat(n) = (sqrt(sum((T-T_mean).^2)./(B-1)));
end
disp(sigma_hat)
