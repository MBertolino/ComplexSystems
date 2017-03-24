% MoCS
% fashion 1.3

% MoCS Project 1
% fashion 1.1
%

clear all; close all; clc;

% Param
T = 1000;
N = 15; % Total students 15 or 100
p = 0.5; % 0.5 or 0.7
q = 1;

% 1.3
u = zeros(length(q), T);
for j = 1:length(q)
   u1 = round(rand*N);
   u(j, :) = ChangeBrand(p, q(j), N, u1, T);
end
plot(1:T, u)