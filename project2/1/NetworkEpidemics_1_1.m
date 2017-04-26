
N = 500;
link_density = 0.0016;

% Pre-allocate
links = zeros(N, N);
links_hist = zeros(N, 1);

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
    links_hist(n) = sum(links(n, :));
end

% Plot histogram
figure()
hist(links_hist)
% plot(graph(links))

