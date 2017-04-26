
T = 1000;
N = 5000;
link_density = 0.0016;
r = 0.03; % Rate of recovery
p = 0.01;

% Pre-allocate links
links = zeros(N, N);
links_tot = zeros(N, 1);

% Infection probability
P = zeros(N+1, 1);
for n = 1:N+1
    P(n) = 1 - exp(-p*n);
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

% Step in time
for t = 2:T
    % Recover
    inf(t, (rand(1, n) < r)) = 0;
    
    % Get infected
    for n = 1:N
        if rand < P(links_tot(n)+1)
            inf(t, n) = 1;
        end
    end
end


% Plot infected
figure()
plot(sum(inf, 2))


