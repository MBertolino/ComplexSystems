clear all; close all;

% Param
L = 20;
N = 50; % Individuals
R = 2; % Neighbor distance
p = 0.0; %0.1:0.01:0.3;
q = p + 0.6; %0:0.01:0.9;
delta = 0.5;
eta = 0.1;
T = 100;
N_sims = 100;

% Initialize position and velocities
status = rand(N, 3); % x_i(t), y_i(t), theta_i(t)
status(:, [1 2]) = status(:, [1 2])*L;
status(:, 3) = status(:, 3)*2*pi;
theta_new = zeros(N, 1); % theta_i(t+1)
dist = zeros(N, N);
total_dist = zeros(N, 1);

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
for ip = 1:length(p)
    for iq = 1:length(q)
        for j = 1:N_sims
            psi(1, iq) = (sum(cos(status(:, 3))).^2 + sum(sin(status(:, 3))).^2)/N;
            for t = 2:T
                % Mean position
                mu = mean(status(:, 1:2));
                
                % Move all particles
                for n = 1:N
                    % Find neighbors
                    dist(:, n) = sqrt((status(n, 1) - status(:, 1)).^2 + (status(n, 2) - status(:, 2)).^2);
                    neigh = status((dist(:, n) > 0) & (dist(:, n) < R), :);
                    neigh_len = size(neigh, 1);
                    neigh = [neigh; status((dist(:, n) > 0) & (dist(:, n) > (L-R)), :)];
                    neigh_bdry_len = size(neigh, 1);
                    
                    % Dispersion from mean
                    total_dist(n) = sqrt((mu(1) - status(n, 1)).^2 + (mu(2) - status(n, 2)).^2);
                    
                    % Follow neighbors with probability p or q
                    chance = rand;
                    noise = rand*eta - eta/2;
                    if (~isempty(neigh))
                        if (rand < neigh_len/(neigh_bdry_len))
                            follow_me = randi([1 neigh_len], 1, 1);
                            bdry = 1;
                        else
                            % If neighbour is on the other side of the bdry
                            % facing it will be different
                            follow_me = randi([(neigh_len+1) neigh_bdry_len], 1, 1);
                            bdry = -1;
                        end
                    else
                        chance = 2;
                        theta_new(n) = status(n, 3) - noise;
                    end
                    
                    % Face neighbour
                    if (chance < p(ip))
                        neigh_x = neigh(follow_me, 1);
                        neigh_y = neigh(follow_me, 2);
                        bdry = 1;
                        theta_new(n) = atan2(bdry*(neigh_y - status(n, 2)), (neigh_x - status(n, 1)));
                    end
                    
                    % Same direction
                    if (chance < q(iq) && chance > p(ip))
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
                
                delta_exp = exprnd(delta, N, 1);
                status(:, [1 2]) = status(:, [1 2]) + delta_exp.*dir(:, [1 2]);
                
                % Periodic boundaries
                status(status(:, 1) > L, 1) = status(status(:, 1) > L, 1) - L;
                status(status(:, 2) > L, 2) = status(status(:, 2) > L, 2) - L;
                status(status(:, 1) < 0, 1) = L + status(status(:, 1) < 0, 1);
                status(status(:, 2) < 0, 2) = L + status(status(:, 2) < 0, 2);
                
                % 2.2 Alignment measure
                %             psi(t, iq) = psi(t, iq) + sqrt(sum(cos(status(:, 3))).^2 + sum(sin(status(:, 3))).^2)/N;
                
                % 2.3 Aggregation measure
                phi(t, ip) = phi(t, ip) + mean(total_dist);
                
                % Plot all individuals
                plot(status(:, 1), status(:, 2), 's')
                xlim([0 L])
                ylim([0 L])
                xlabel(['Time = ' num2str(t)])
                pause(0.01)
            end
        end
    end
    ip/length(p)
end
toc;
psi = psi/N_sims;
phi = phi/N_sims;

% 2.2 Plot alignment measure
% figure()
% plot(q, psi, '.')
% xlabel('Parameter q')
% ylabel('Alignment [\psi(t)]')

% 2.3 Plot aggregation measure
figure()
plot(p, phi(2:end, :), '.')
xlabel('Parameter p')
ylabel('Aggregation [\phi(t)]')