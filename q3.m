format long
data = readtable("II-10-3-2020.csv");
data = table2array(data);
n = height(data);
k = 100;       % number of repeated experiments
B = 10^7;      % number of bootstrap samples
sigma_B = zeros(k,1);   % time we repeat the algorithm
t = zeros(B,1);     % stores values of t(Y_b)
for l = 1:k
    for i = 1:B
        rnum = randi([1,n],1,n);  % select n random samples from X
        temp_y = zeros(n,1);  
        temp_z = zeros(n,1);
        % assign corresponding y and z values
        for j=1:n
            temp_y(j) = data(rnum(j),1);
            temp_z(j) = data(rnum(j),2);
        end
        % calculate the mean of Y and Z
        y_mean = sum(temp_y)/n;
        z_mean = sum(temp_z)/n;
        % calculate r(X) where X=(Y,Z)
        r_num = sum((temp_y-y_mean).*(temp_z-z_mean));
        r_denom = sqrt(sum((temp_y-y_mean).^2)*sum((temp_z-z_mean).^2));
        r = r_num/r_denom;
        t(i) = log((1+r)/(1-r))/2;      % T(Y_b)
    end
    % to calculate sigma_B
    t_mean = sum(t)/B;
    sigma_B(l) = (sqrt(sum((t-t_mean).^2)./(B-1)));
end
% to plot the histograms
h=histogram(sigma_B);
xlabel('$\hat{\sigma}_B$','Interpreter','latex')
legend()
disp(h)