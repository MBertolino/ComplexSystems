clear all; close all;

% Param
T = 100;
N = 4;
m = 4; % Number of links to added individiual

% Initialize links
links = zeros(T+3, T+3);
links([1 2], [1 2]) = 1;
links([3 4], [3 4]) = 1;
for i = 1:4
    links(i, i) = 0;
end
N_links = zeros(T+3, 1);
N_links([1:4]) = 1;
prob = zeros(N, 1);

% Plot initial network
% plot(graph(links))
% pause(1)

% Initialize probabilities
k = zeros(T+3, 1);
P = zeros(T+3, 1);

% Initialize waitbar
h = waitbar(0, 'Progress: ');

% Step in time
tic;
for t = 2:T
    % Which to link
    tot_links = sum(N_links);
    for n = 1:N
        P(n) = N_links(n)./(tot_links);
    end

    prob(1:t+2) = P(1:t+2).*rand(t+2, 1);
    
    % Add one new individual
    [~, new_idx] = sort(prob(1:t+2));
    %     links(t+3, new_idx(end-(m-1):end)) = 1;
    %     links(new_idx(end-(m-1):end), t+3) = 1;
    %     new_idx(end-(m-1):end)
    
    % Update
    N_links(new_idx(end-(m-1):end)) = N_links(new_idx(end-(m-1):end)) + 1;
    N_links(t+3) = N_links(t+3) + m;
    N = N + 1;
    waitbar(t/T)
    
    % Plot graph
    %     plot(graph(links))
    %     pause(1)
end
toc;
close(h)

% Plot resulting network
% figure()
% plot(graph(links))

% Plot histogram of resulting links
bins = histcounts(N_links, 1:length(N_links));
bin_length = 1:(length(N_links) - 1);
figure()
plot(bin_length, bins, '*')

figure()
loglog(bin_length, bins)