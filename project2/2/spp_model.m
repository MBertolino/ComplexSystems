clear all;

% Param
L = 20;
N = 5; % Individuals
R = 2; % Neighbor distance
p = 0.3;
q = p + 0.3;
delta = 0.1;
eta = 0.5;
T = 1000;

% Initialize position and velocities
status = rand(N, 4); % x_i(t), y_i(t), theta_i(t), distance traveled(t)
status(:, [1 2]) = status(:, [1 2])*L;
status(:, 3) = status(:, 3)*2*pi;
status(:, 4) = 0;
theta_new = zeros(N, 1); % theta_i(t+1)

% Simulate
figure()
plot(status(:, 1), status(:, 2), '*')
xlim([0 20])
ylim([0 20])
pause(0.1)
for t = 2:T
    for n = 1:N
        % Find neighbors
        dist = sqrt((status(n, 1) - status(:, 1)).^2 + (status(n, 2) - status(:, 2)).^2);
        neigh = status((dist > 0) & (dist < R), :);
        
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
        if (chance < p)
            neigh_x = neigh(follow_me, 1);
            neigh_y = neigh(follow_me, 2);
            dir_new = pi + tan((neigh_y - status(n, 2))/(neigh_x - status(n, 1)));
            theta_new(n) = dir_new - floor(dir_new);
        end
        
        % Same direction
        if (chance < q && chance > p)
            dir_new = pi + neigh(follow_me, 3);
            theta_new(n) = dir_new - floor(dir_new);
        end
        
        % Add noise
        theta_new(n) = theta_new(n) + noise;
    end
    % Update directions
    status(:, 3) = theta_new;
    
    % Update positions
    dir(:, 1) = cos(status(:, 3));
    dir(:, 2) = sin(status(:, 3));
    status(:, 4) = sqrt(dir(:, 1).^2 + dir(:, 2).^2);
    status(:, [1 2]) = status(:, [1 2]) + delta*dir(:, [1 2])./status(:, 4);
    
    % Periodic boundaries
    status(status(:, 1) > L, 1) = status(status(:, 1) > L, 1) - ...
        floor(status(status(:, 1) > L, 1));
    status(status(:, 2) > L, 2) = status(status(:, 2) > L, 2) - ...
        floor(status(status(:, 2) > L, 2));
    status(status(:, 1) < 0, 1) = L;
    status(status(:, 2) < 0 , 2) = L;
    
    % Plot all individuals
    plot(status(:, 1), status(:, 2), '*')
    xlim([0 20])
    ylim([0 20])
    
    pause(0.01)
end

