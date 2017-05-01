
T = 1000;
N = 5000;
link_density = 0.0016;
r = 0.03; % Rate of recovery
p = 0.001:0.001:0.01;

% Pre-allocate links
links = zeros(N, N);
links_tot = zeros(N, 1);
inf_eq = zeros(length(p), 1);
rate = zeros(length(p), 1);

% Infection probability
P = zeros(N+1, length(p));
for ip = 1:length(p)
    for n = 1:N+1
        P(n, ip) = 1 - exp(-p(ip)*n);
    end
end
inf_idx = randperm(N, 100);
inf = zeros(T, N);
inf(1, inf_idx) = 1;

% Build network
for n = 1:N
    % Link with other individuals
    for n2 = n:N
        if rand < link_density && n ~= n2
            links(n, n2) = 1;
            links(n2, n) = 1;
        end
    end
end

% Calculate link distribution
for n = 1:N
    links_tot(n) = sum(links(n, :));
end

% Step in time for each p
figure()
hold on;
for ip = 1:length(p)
    for t = 2:T
        inf(t, :) = inf(t-1, :);
        
        % Recover
        inf(t, (rand(1, n) < r)) = 0;
        
        % Get infected
        for n = 1:N
            if rand < P(links_tot(n)+1, ip)
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