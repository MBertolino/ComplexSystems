% MoCS Project 1
%
% fashion 1.1


clear all; close all; clc;

% Param
T = 10000;
N = 15; % Total students 15 or 96
p = 0.5; % 0.5 or 0.7
q = 1;

% 1.1 Changing brand
N_sims = 100;
u = zeros(N_sims, T);
for i = 1:N_sims
   u1 = round(rand*N);
   u(i, :) = ChangeBrand(p, q(1), N, u1, T);
end

% 1.2 Implementing master equation
% u_m = zeros(1, N);
% i = 1;
% for t = 1:T-1
%     u_m(
%     for i = 1:(N)
%         u_m(t, i) = nchoosek4(N, i)*p^i*(1-p)^(N-i);
%     end
% end

% Plot equilibrium distribution
figure()
hist(u(:,end), 100);

