% Lyapunov
clear all; %close all;

% Param
b = 1:0.01:40; % Newborn at each site populated by 2
n = 1000; % Number of sites
T = 100;

A_p = zeros(T, length(b));
A_mf = zeros(T, length(b));
B_p = zeros(T, length(b));
lambda = zeros(1, length(b));
A_mf(1, :) = n;
B_p(1, :) = n+1;

% 3.2 Mean-field equation & 3.3 Lyapunov
for i = 1:length(b)
    for t = 1:T-1
        A_mf(t+1, i) = n*0.5*b(i)*exp(-A_mf(t, i)./n)*(A_mf(t, i)./n).^2;
        A_p(t+1, i) = 0.5*b(i)/(n.^2)*exp(-A_mf(t, i)./n)*(2*n - A_mf(t, i));
        lambda(i) = lambda(i) + (abs(A_p(t+1, i)));
    end
    lambda(i) = (lambda(i))./T;
end

figure()
plot(b, lambda)
hold on;
plot(0:40, (0:40)*0)
xlabel('Parameter b')
ylabel('Lyapunov exponent')

% figure()
% plot(1:T, A_mf)5:5:2