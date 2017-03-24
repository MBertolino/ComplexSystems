% MoCS Project 1
%
%

clear all; close all; clc;

% Param
T = 10000;
N = 15; % Total students 15 or 100
p = 0.7; % 0.5 or 0.7
q = 0.1:0.01:1;
u1 = rand*N;

figure()
hold on;
%for i = 1:length(q)
% 1.1 & 1.3 Changing brand
u = ChangeBrand(p, q, N, u1, T);

% % 1.2 Implementing master equation
% u_m = zeros(1, N);
% i = 1;
% for t = 1:T-1
%     u_m(
%     for i = 1:(N)
%         u_m(t, i) = nchoosek4(N, i)*p^i*(1-p)^(N-i);
%     end
% end

% Plot equilibrium distribution

plot(1:T, u);
%end