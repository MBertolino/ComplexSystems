clear all; close all;

% Param
T = 7;
N = 4;
m = 4; % Number of5links to added individiual

% Initialize links
links = zeros(T+3, T+3);
links([1 2], [1 2]) = 1;
links([3 4], [3 4]) = 1;
for i = 1:4
    links(i, i) = 0;
end
N_links = zeros(T+3, 1);
N_links([1:4]) = 1;
prob = zeros(N, T);

% Plot initial network
% plot(graph(links))
% pause(1)

% Initialize probabilities
k = zeros(T+3, 1);
P = zeros(T+3, T);

% Initialize waitbar
h = waitbar(0, 'Progress: ');

% Step in time
tic;
for t = 2:T
    % Which to link
    for n = 1:N
        P(n, t) = N_links(n)./(sum(N_links));
    end
    
    prob(1:t+2) = P(1:t+2, t).*rand(t+2, 1);
    
    % Add one new individual
    [~, new_idx] = sort(prob(1:t+2));
    links(t+3, new_idx(end-(m-1):end)) = 1;
    links(new_idx(end-(m-1):end), t+3) = 1;
    
    % Update
    N_links(new_idx(end-(m-1):end)) = N_links(new_idx(end-(m-1):end)) + 1;
    N_links(t+3) = N_links(t+3) + 4;
    N = N + 1;
    waitbar(t/T)
    
    % Plot graph
    %     plot(graph(links))
    %     pause(1)
end
toc;
close(h)

% Plot resulting network
figure()
plot(graph(links))

% Plot histogram of resulting links
bins = histcounts(sum(links));
bin_length = 1:length(bins);
figure()
loglog(bin_length, bins)