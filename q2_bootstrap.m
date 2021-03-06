data = readtable("II-10-3-2020.csv");
data = table2array(data);
B = 10^6;    % number of bootstrap samples
n = height(data);
t = zeros(B,1); % stores values of t(Y_b)

for i = 1:B
    rnum = randi([1,n],1,n);  % select n random samples from X
    temp_y = zeros(n,1);  
    temp_z = zeros(n,1);
    % assign corresponding y and z values to the bootstrap samples
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
h1 = histogram(t);
disp(h1)
xlabel('T(Y)')
ylabel('frequency')
figure()
% we normalise the histogram as a pdf
h2 = histogram(t,'Normalization','pdf');
% descriptive stats (mean, variance, minimum and maximum)
disp([mean(t), var(t),min(t),max(t)])
disp(h2)
xlabel('T(Y)')
ylabel('probability density')
