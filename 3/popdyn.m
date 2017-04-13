% clear all; close all;

% Param
b = 1:50; %[5 10 20 30 40]; % Newborn at each site populated by 2
n = 1000; % Number of sites
T = 100;
N_sims = 100;
A_range = 0:15000;

A = zeros(T, 1); % Population
A_eq = zeros(N_sims, length(b));
A_dyn = zeros(A_range(end), length(b));
mf = zeros(T, 1);
mf(1) = n;

% Figure param
% figure()
% hold on;
% color = ['b', 'r', 'k', 'g', 'm'];

% Setup waitbar
h = waitbar(0, 'Please wait...');

% Simulate
for j = 1:length(b)
    for i = 1:N_sims
        % Calculate A
        A = pop_func(n, b(j), T, A1);
        A_eq(i, j) = A(end);
    end
    
    % Bifurcation diagram  
    for k = 0:(max(A_eq(:, j))-1)
        A_dyn(k+1, j) = sum(A_eq(:, j) == k)/N_sims;
    end
    
    % Plot population
    % plot(1:T, A, color(k))
    
    % Update waitbar
    waitbar(j/N_sims)
end
close(h)

% xlabel('Time')
% ylabel('Population size')
% legend('b = 5', 'b = 10', 'b = 20', 'b = 30', 'b = 40')

% 3.1 Bifurcation diagram
figure()
colormap hot
imagesc(b, A_range, A_dyn, [0 0.3])
xlabel('Parameter b')
ylabel('Relative frequency')
colorbar


% 3.2 Mean-field equation
A_mf(1) = n;
for i = 2:length(b)
    A_mf(i) = 0.5*b(i)*exp(A_mf(t-1)/n)*A_mf(t-1).^2/n;
end
hold on;
figure()
plot(1:T, mf)