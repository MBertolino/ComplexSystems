% MoCS Project 1
%
% fashion 1.1


clear all; close all; clc;

% Param
T = 1000;
N = 100; % Total students 15 or 96
p = 0.5; % 0.5 or 0.7
q = 1;

% 1.1 Changing brand
N_sims = 10000;
u = zeros(N_sims, T);
for i = 1:N_sims
    u1 = round(rand*N);
    u(i, :) = ChangeBrand(p, q(1), N, u1, T);
end

% Find distribution of equilibrium value
u_eq = zeros(N, 1);
for k = 0:N-1
    u_eq(k+1, 1) = sum(u(:, end) == k)/N_sims;
end


% 1.2 Implementing master equation
u_m = zeros(N, 1);
for i = 1:N
    u_m(i, 1) = nchoosek(N, i)*p^i*(1-p)^(N-i);
end

% Plot equilibrium distribution
figure()
plot(1:N, u_eq, 1:N, u_m);
xlabel('People with iPhone at equilibrium')
ylabel('Relative frequency for the simulations')
legend('Simulated', 'Master equation')