clear all; close all;

% Param
N_sims = 20;
b = [5 10 20 30 40]; % Newborn at each site populated by 2
n = 1000; % Number of sites
T = 100;
mf = zeros(T, 1);
mf(1) = n;
A = zeros(T, N_sims); % Population

% Figure param
figure()
hold on;
color = ['b', 'r', 'k', 'g', 'c'];

% Setup waitbar
h = waitbar(0, 'Please wait...');

for k = 1:length(b)
    A(1, :) = n;
    
    for j = 1:N_sims
        for t = 2:T
            % All individuals choose which site to visit
            %site = round((n-1)*rand(1, A(t-1))) + 1;
            site = randi([1, n], 1, A(t-1, j));
            
            % Reproduce or disappear
            for i = 1:A(t-1, j)
                if sum(site == i) == 2
                    A(t, j) = A(t, j) + b(k);
                end
            end
            
            % Mean field equation
            %     for i = 1:A(t)/2
            %         mf(t) = mf(t) + (A(t)/n.^2).^i/(factorial(i-1));
            %     end
            %     mf(t) = b(k)*exp(-A(t)/n.^2)*mf(t);
            %     mf(t) = b(k)*n*nchoosek(mf(t-1), 2)*(1./n).^2*((n-1)./n).^(mf(t-1)-2)
        end
            % Update waitbar
        waitbar(j/N_sims)
    end
    
    % Plot population
    plot(1:T, A, color(k))
    
end
close(h)

xlabel('Time')
ylabel('Population')
legend('b = 5', 'b = 10', 'b = 20', 'b = 30', 'b = 40')

% hold on;
% figure()
% plot(1:T, mf)