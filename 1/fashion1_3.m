% MoCS
% fashion 1.3

% MoCS Project 1
% fashion 1.1
%

clear all; close all; clc;

% Param
T = 1000;
N = 100; % Total students 15 or 100
p = 0.5; % 0.5 or 0.7
q = 0:0.01:1;
N_sims = 2000;

% 1.3
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

colormap hot
colorbar
imagesc(u_dynamics)
figure()
%hist(u(:,end),100)
plot(1:T, u(:, end-5:end))
%plot(1:N_sims, u_eq)
sum(u(:, end) == 0)
sum(u(:, end) == N)