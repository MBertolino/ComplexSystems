clear all; close all;

% Params
n = 3;
a = 5;
u = 1;
mu = 500;
p = 0.001;

% Initialize data
S = ones(2*n, 1); % Species
R = zeros(n, 1);

% Constants
T = 1000;

% Step in time
for t = 1:T
    % Generate a time interval
    dt = exprnd(1/sum(S), sum(S), 1);
    
    % Inflow of metabolites
    R(u) = R(u) + mu*dt;
    
    % Select one individual
    s = randsample(1:length(S), 1, 1, S);
    
    % Reproduce
    
    q = 
    
end