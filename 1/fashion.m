% MoCS Project 1
%
% fashion 1.1

clear all; close all; clc;

% Param
T = 10000;
N = [15 100]; % Total students 15 or 96
p = 0.5; % 0.5 or 0.7
q = 1;

% 1.1 Changing brand
N_sims = 10000;
u = zeros(N_sims, T);

figure()
hold on;
for n = 1:length(N)
    u_eq = zeros(N(n)+1, 1);
    u_m = zeros(N(n), 1);
    
    % Simulate 
    for i = 1:N_sims
        u1 = round(rand*N(n));
        u(i, :) = ChangeBrand(p, q(1), N(n), u1, T);
    end
    
    % Find distribution of equilibrium value
    u_eq(1, 1) = sum(u(:, end) == 0)/N_sims;
    for k = 1:N(n)-1
        u_eq(k+1, 1) = sum(u(:, end) == k)/N_sims;
    end
    u_eq(N(n)+1, 1) = sum(u(:, end) == N(n))/N_sims;
        
    % 1.2 Implementing master equationuntitled
    for i = 0:N(n)
        u_m(i, 1) = nchoosek(N(n), i)*p^i*(1-p)^(N(n)-i);
    end
    
    % Plot equilibrium distribution
    plot(0:N(n), u_eq, 'DisplayName',['Simulated ' num2str(N(n))])
    plot(1:N(n), u_m, '--', 'DisplayName',['Master equation ' num2str(N(n))]);
end

legend(gca, 'show')
xlabel('Number of iPhones at equilibrium')
ylabel('Relative frequency')