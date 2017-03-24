clear all; close all; clc;

% Param
T = 10000;
N = 100; % Total students 15 or 100
p = 0.7; % 0.5 or 0.7
u1 = 50;

% Changing brand
u = ChangeBrand(p, N, u1, T);

% Plot equilibrium distribution
plot(1:T, u);