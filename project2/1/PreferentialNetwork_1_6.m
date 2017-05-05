clear all; close all;

% Param
T = 1000;
N_tot = 5000;
N = 4;
m = 4; % Number of links to added individiual

% Infection param
r = 0.03;
p = 0.001:0.001:0.01;

% Initialize links
links = zeros(N_tot, N_tot);
links([1 2], [1 2]) = 1;
links([3 4], [3 4]) = 1;
links = links - diag(diag(links));
k = zeros(N_tot, 1);
k(1:N) = 1;
prob = zeros(N, 1);

% Infection probability
P = zeros(N_tot, length(p));
for ip = 1:length(p)
    for n = 1:N+1
        P(n, ip) = 1 - exp(-p(ip)*n);
    end
end
inf_idx = randperm(N_tot, 100);
inf = zeros(T, N_tot);
inf(1, inf_idx) = 1;
inf_eq = zeros(length(p), 1);
rate = zeros(length(p), 1);

% Initialize waitbar
h = waitbar(0, 'Progress: ');

% Build network
tic;
for t = 5:N_tot
    % Which to link
    k_tot = sum(k);
    for n = 1:N
        P(n) = k(n)./k_tot;
    end
    
    % Add one new individual
    new_idx = randsample(1:N, m, 1, P(1:t-1));
    links(t, new_idx) = 1;
    links(new_idx, t) = 1;
    
    % Update k and population
    k(new_idx) = k(new_idx) + 1;
    k(t) = k(t) + m;
    N = N + 1;
    
    waitbar(t/N_tot)
end
toc;
close(h)

% Step in time for each p
figure()
hold on;
for ip = 1:length(p)
    for t = 2:T
        inf(t, :) = inf(t-1, :);
        
        % Recover
        inf(t, (rand(1, N_tot) < r)) = 0;
        
        % Get infected
        for n = 1:N_tot
            if rand < P(k(n)+1, ip)
                inf(t, n) = 1;
            end
        end
    end
    
    % 1.3 Number of infected at T = 1000 vs rate = r/p
    inf_eq(ip) = sum(inf(T, :));
    rate(ip) = r./p(ip);
    
    % Plot infected
    % figure()
    plot(sum(inf, 2))
    ylabel('Infected individuals')
    xlabel('Time [Days]')
end


% Plot 1.3
figure()
plot(rate, inf_eq, '*')
ylabel('Infected individuals at T = 1000')
xlabel('Rate r/p')