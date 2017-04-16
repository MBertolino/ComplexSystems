clear all; %close all;

% Param
b = 1:5:50; %[5 10 20 30 40]; % Newborn at each site populated by 2
n = 480; % Number of sites
d = [n/8 n/6 n/4 n/2]; % How far they move [1, n/2]
T = 50;
N_sims = 100;
A_range = 0:15000;

A = zeros(T, 1); % Population
A_eq = zeros(N_sims, length(b));
A_dyn = zeros(A_range(end), length(b));
A_dyn2 = zeros(A_range(end), length(b));
A(1) = n;
mf = zeros(T, 1);
mf(1) = n;

% Figure param
figure()
hold on;

% Setup waitbar
h = waitbar(0, 'Please wait...');

% Simulate
for m = 1:length(d)
    for j = 1:length(b)
        A_all = [];
        for i = 1:N_sims
            % Calculate A
            A = pop_local_func(n, b(j), T, A(1), d(m));
            %         A = pop_func(n, b(j), T, A(1));
            A_eq(i, j) = A(end);
            
            % Store the last half of the simulation
            A_all = [A_all; A(T/2:T)];
        end
        
        % Take the histogram
        temp = histogram(A_all, A_range);
        figure()
        hist_A(j, :) = temp.Values/sum(temp.Values);
        
        % Bifurcation diagram
        for k = 0:(max(A_eq(:, j))-1)
            A_dyn2(k+1, j) = sum(A_eq(:, j) == k);
        end
        
        % Plot population
        %     plot(1:T, A)
        
        % Update waitbar
        waitbar(j/length(b))
    end
    
    figure()
    colormap hot
    subplot(2, 2, m)
    imagesc(b, A_range, hist_A', [0 0.2]) % scale to 0.2
    title(d(m))
    xlabel('p')
    ylabel('A')
    set(gca, 'FontSize', 18);
    colorbar
    
    % 3.1 Bifurcation diagram
    figure()
    subplot(2, 2, m)
    colormap hot
    imagesc(b, A_range, A_dyn2/N_sims, [0 0.3])
    xlabel('Parameter b')
    ylabel('Relative frequency')
    title(d(m))
    % colorbar
end
close(h)
%
% xlabel('Time')
% ylabel('Population size')
% legend('b = 5', 'b = 10', 'b = 20', 'b = 30', 'b = 40')


% 3.2 Mean-field equation
% A_mf(1) = n;
% for i = 2:length(b)
%     A_mf(i) = 0.5*b(i)*exp(-A_mf(t-1)/n)*(A_mf(t-1)/n).^2;
% end
% hold on;
% figure()
% plot(1:T, mf)