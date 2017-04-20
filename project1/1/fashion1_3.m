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
% 1.5
y = 0.5*ones(length(q), 3);

% Setup waitbar
h = waitbar(0, 'Please wait...');

for j = 1:length(q)
    for i = 1:N_sims
        u1 = randi([0, N], 1);
        u(:, i) = ChangeBrand(p, q(j), N, u1, T);
        u_eq(i, j) = u(end, i);
    end
    
%     for k = 0:N-1
%         u_dynamics(k+1, j) = sum(u_eq(:, j) == k);
%     end
%     
    waitbar(j/length(q))
end
close(h)

% 1.5 Mean-field equation
for i = 1:length(q)
    if q(i) > 0.33333
        break;
    end
    y(i, 2) = 0.5 - sqrt(0.25 + 0.5*q(i)./(q(i) - 1));
    y(i, 3) = 0.5 + sqrt(0.25 + 0.5*q(i)./(q(i) - 1));
end

% 1.3 plot histogram for q = 0.2 (16) (?)
figure()
hist(u_eq(:, 16))
xlabel('Number of iPhone owners')
ylabel('Relative frequency')

% 1.4 Bifurcation diagram
figure()
colormap hot
imagesc(q, 1:N, u_dynamics/N_sims, [0 0.1])
xlabel('Parameter q')
ylabel('Relative frequency')

% % 1.5 Plot Mean-field equation
% figure()
% plot(q, y)
% xlabel('Parameter q')
% ylabel('Relative frequency')