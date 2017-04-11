
% Param
b = 10; % Newborn at each site populated by 2
n = 1000; % Number of sites
T = 20;
A = zeros(T, 1); % Population
A(1) = n;
mf = zeros(T, 1);
mf(1) = n;

for t = 2:T
    % All individuals choose which site to visit
    site = round((n-1)*rand(1, A(t-1))) + 1;
    
    % Reproduce or disappear
    for i = 1:A(t-1)
        if sum(site == i) == 2
            A(t) = A(t) + b;
        end
    end
    
    % Mean field equation
%     for i = 1:A(t)/2
%         mf(t) = mf(t) + (A(t)/n.^2).^i/(factorial(i-1));
%     end
%     mf(t) = b*exp(-A(t)/n.^2)*mf(t);
    mf(t) = b*n*nchoosek(mf(t-1), 2)*(1./n).^2*((n-1)./n).^(mf(t-1)-2)
    
end

% Plot population
figure()
plot(1:T, A)
hold on;
figure()
plot(1:T, mf)