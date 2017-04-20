
N = 100; % Individuals
R = 5; % Neighbor distance
T = 10;

% Initialize position and velocities
status = zeros(N, 4); % x_i(t), y_i(t), theta_i(t), distance traveled (t)
status(1, :) = rand(1, 4);

for t = 2:T
    for n = 1:N
        dist = status(n, 1).^2 + status(n, 2).^2;
        neighbors = 
    
end


