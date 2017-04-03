% MoCS
%
% fashion 1.3 & 1.4

clear all; close all; clc;

% Param
T = 10000;
N = 15; % Total students 15 or 100
p = 0.5; % 0.5 or 0.7
q = 0:0.01:1; % 0.2 rapid change
N_sims = 1000;

% 1.3 & 1.4
u = zeros(T, N_sims);
u_eq = zeros(N_sims, length(q));
u_dynamics = zeros(N, length(q));

for j = 1:length(q)
    for i = 1:N_sims
        u1 = round(rand*N);
        u(:, i) = ChangeBrand(p, q(j), N, u1, T);
        u_eq(i, j) = u(end, i);
    end
    
    for k = 0:N-1
        u_dynamics(k+1, j) = sum(u_eq(:, j) == k);
    end
end

% 1.3 plot histogram for q = 0.2 (?)
figure()
hist(u_eq(:, 21))
xlabel('Number of iPhone owners')
ylabel('Relative frequency')

% 1.4 Bifurcation diagram
figure()
colormap hot
imagesc(u_dynamics)
xlabel('Parameter q')
ylabel('Relative frequency')

figure()
plot(1:T, u(:, end-5:end))
