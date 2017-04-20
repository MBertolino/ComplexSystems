clear all; %close all;

% Param
b = 1:4:50; %[5 10 20 30 40]; % Newborn at each site populated by 2
n = 480; % Number of sites
d = [n/8 n/6 n/4 n/2]; % How far they move [1, n/2]
T = 40;
N_sims = 50;
A_range = 0:15000;

A = zeros(T, 1); % Population
A_eq = zeros(N_sims, length(b));
A_dyn = zeros(A_range(end), length(b));
A(1) = n;

% Figure param
figure()
% hold on;

% Setup waitbar
h = waitbar(0, 'Please wait...');

% Simulate
for m = 1:length(d)
    for j = 1:length(b)
        for i = 1:N_sims
            % Calculate A
            A = pop_local_func(n, b(j), T, A(1), d(m));
            %         A = pop_func(n, b(j), T, A(1));
            A_eq(i, j) = A(end);
        end
        
        % Bifurcation diagram
        for k = 0:(max(A_eq(:, j))-1)
            A_dyn(k+1, j) = sum(A_eq(:, j) == k);
        end
        
        % Plot population
        %     plot(1:T, A)
        
        % Update waitbar
        waitbar(j/length(b))
    end
    
    % 3.1 Bifurcation diagram
    figure()
    subplot(2, 2, m)
    colormap hot
    imagesc(b, A_range, A_dyn/N_sims, [0 0.3])
    xlabel('Parameter b')
    ylabel('Relative frequency')
    title(d(m))
    colorbar
end
close(h)