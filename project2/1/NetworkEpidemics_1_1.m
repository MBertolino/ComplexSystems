clear all; close all;

N_sims = 1;
N = 5000;
link_density = 0.0016;

% Pre-allocate
links = zeros(N, N);
links_hist = zeros(N, 1);

% Build network
for i = 1:N_sims
    for n = 1:N
        % Link with other individuals
        for n2 = 1:N
            if rand < link_density && n ~= n2
                links(n, n2) = 1;
                links(n2, n) = 1;
            end
        end
    end
    links = links./N_sims;
    
    % Calculate link distribution
    for n = 1:N
        links_hist(n) = links_hist(n) + sum(links(n, :));
    end
end


% Plot histogram
figure()
hist(links_hist, 100)
xlabel('Number of links')
ylabel('Frequency')
% plot(graph(links))

