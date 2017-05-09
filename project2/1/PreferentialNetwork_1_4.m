clear all; close all;

% Param
T = 5000;
N = 4;
m = 4; % Number of links to added individiual

% Initialize links
links = zeros(T, T);
links([1 2], [1 2]) = 1;
links([3 4], [3 4]) = 1;
links = links - diag(diag(links));
k = zeros(T, 1);
k(1:N) = 1;
k_cum = zeros(N-m+1, 1);
prob = zeros(N, 1);
P = zeros(T, 1);

% Initialize waitbar
h = waitbar(0, 'Progress: ');

% Step in time
tic;
for t = 5:T
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
    
    waitbar(t/T)
end
toc;
close(h)

% Plot histogram of resulting links
bins = histcounts(k, 1:T)/T;
% figure()
% plot(1:T-1, bins)
% ylabel('Relative frequency')
% xlabel('Number of links')

figure()
loglog(1:T-1, bins, '.')
ylabel('Relative frequency')
xlabel('Number of links')

% Plot cumulative distribution
for i = 1:N-m+1
    k_cum(i) = sum(k > i+m-1);
end

loglog(m:N, k_cum, '.')
ylabel('Relative frequency of individuals > x')
xlabel('Number of links')