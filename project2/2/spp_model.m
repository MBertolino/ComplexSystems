clear all; close all;

% Param
L = 20;
N = 50; % Individuals
R = 2; % Neighbor distance
p = 0:0.1:0.9;
q = p + 0;
delta = 0.5;
eta = 0.1;
T = 200;
N_sims = 10;

% Initialize position and velocities
status = rand(N, 3); % x_i(t), y_i(t), theta_i(t)
status(:, [1 2]) = status(:, [1 2])*L;
status(:, 3) = status(:, 3)*2*pi;
theta_new = zeros(N, 1); % theta_i(t+1)

% Allocate alignment and aggregation measures
psi = zeros(T, length(q));
phi = zeros(T, length(p));

% Simulate
% figure()
% plot(status(:, 1), status(:, 2), '*')
% xlim([0 20])
% ylim([0 20])
% pause(1)
tic;
for iq = 1:length(q)
    for j = 1:N_sims
        psi(1, iq) = (sum(cos(status(:, 3))).^2 + sum(sin(status(:, 3))).^2)/N;
        for t = 2:T
            for n = 1:N
                % Find neighbors
                dist(:, n) = sqrt((status(n, 1) - status(:, 1)).^2 + (status(n, 2) - status(:, 2)).^2);
                total_dist(n) = mean(dist(:, n));
                neigh = status((dist(:, n) > 0) & (dist(:, n) < R), :);
                
                % Follow neighbors with probability p or q
                chance = rand;
                noise = rand*eta - eta/2;
                if (~isempty(neigh))
                    follow_me = randi([1 size(neigh, 1)], 1, 1);
                else
                    chance = 2;
                    theta_new(n) = status(n, 3) - noise;
                end
                
                % Face neighbor
                if (chance < p(iq))
                    neigh_x = neigh(follow_me, 1);
                    neigh_y = neigh(follow_me, 2);
                    theta_new(n) = atan2((neigh_y - status(n, 2)),(neigh_x - status(n, 1)));
                end
                
                % Same direction
                if (chance < q(iq) && chance > p(iq))
                    %             dir_new = pi + neigh(follow_me, 3);
                    %             theta_new(n) = dir_new - floor(dir_new);
                    theta_new(n) = neigh(follow_me, 3);
                end
                % Add noise
                theta_new(n) = theta_new(n) + noise;
            end
            % Update directions
            status(:, 3) = theta_new;
            
            % Update positions
            dir(:, 1) = cos(status(:, 3));
            dir(:, 2) = sin(status(:, 3));
            status(:, [1 2]) = status(:, [1 2]) + delta*dir(:, [1 2]);
            
            % Periodic boundaries
            status(status(:, 1) > L, 1) = status(status(:, 1) > L, 1) - L;
            status(status(:, 2) > L, 2) = status(status(:, 2) > L, 2) - L;
            status(status(:, 1) < 0, 1) = L + status(status(:, 1) < 0, 1);
            status(status(:, 2) < 0, 2) = L + status(status(:, 2) < 0, 2);
            
            % 2.2 Alignment measure
%             psi(t, iq) = psi(t, iq) + (sum(cos(status(:, 3))).^2 + sum(sin(status(:, 3))).^2)/N;
            
            % 2.3 Aggregation measure
%             mu = mean(status(:, [1 2]));
            phi(t, iq) = phi(t, iq) + mean(total_dist);
%             phi(t, iq) = phi(t, iq) + (sum(status(:, 1) - mu(1)).^2 + sum(status(:, 2) - mu(2)).^2)/N;
            
            % Plot all individuals
            %             plot(status(:, 1), status(:, 2), 's')
            %             xlim([0 L])
            %             ylim([0 L])
            %             pause(0.01)
        end
    end
    %     fprintf('Running (N = %i). Progress: ', iq); tic;
end
toc;
psi = psi/N_sims;
phi = phi/N_sims;

% 2.2 Plot alignment measure
% figure()
% plot(q, psi, 'k.')
% xlabel('Parameter q')
% ylabel('Alignment [\psi(t)]')

% 2.3 Plot aggregation measure
figure()
plot(1:T, phi)
xlabel('Time')
ylabel('Aggregation [\phi(t)]')