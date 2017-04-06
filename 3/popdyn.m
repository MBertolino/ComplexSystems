
% Param
b = 5; % Newborn at each site populated by 2
n = 1000; % Number of sites
T = 100;
A = zeros(T, 1); % Population
A(1) = 1000;

for t = 2:T
    % All individuals choose which site to visit
    site = round((n-1)*rand(1, A(t-1))) + 1;
    
    % Reproduce or disappear
    for i = 1:A(t-1)
        if sum(site == i) == 2
            A(t) = A(t) + 2 + b;
        end
    end
end

% Plot population
figure()
plot(1:T, A)