clear all; close all; clc;

% Param
T = 10000;
N = 100; % Total students 15 or 100
p = 0.7; % 0.5 or 0.7
u1 = rand*N;

% Changing brand
u = ChangeBrand(p, N, u1, T);

% % 1.2 Implementing master equation
% u_m = zeros(1, N);
% i = 1;
% for t = 1:T-1
%     u_m(
%     for i = 1:(N)
%         u_m(t, i) = nchoosek4(N, i)*p^i*(1-p)^(N-i);
%     end
% end

% 1.3 

% Plot equilibrium distribution
figure()
plot(1:T, u);