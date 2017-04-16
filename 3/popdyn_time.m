clear all;

% Params
n = 1000; % # sites
b = 1:50; % [5, 10, 20, 30, 40];
T = 100;

% Allocate
A_dyn = zeros(T, length(b));
A_dyn(1) = n;

% Setup waitbar
h = waitbar(0, 'Please wait...');

for j = 1:length(b)
    A = n;
    for t = 2:T-1
        % All individuals choose which site to visit
        site = randi([1, n], 1, A);
        
        % Reproduce or disappear
        idx = histc(site, 1:n);
        A =  sum(idx == 2)*b(j);
        
        A_dyn(t+1, j) = A;
    end
    
    % Update waitbar
    waitbar(j/length(b))
end
close(h)

% Plot results
figure()
plot(b, A_dyn, 'k.')
xlabel('Number of offsprings, b');
ylabel('Population size')