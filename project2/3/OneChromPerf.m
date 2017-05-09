function [out] = OneChromPerf(environment, chromosome)

% Setup
x_max = size(environment, 2);
y_max = size(environment, 1);
color = (x_max-1)*(y_max-1);

% Coordinates: x = [x0 x1 xf xl xr]
pos(1, 2) = randi([2 x_max-1]);
pos(2, 2) = randi([2 y_max-1]);
pos(1, 1) = x_max;
pos(2, 1) = y_max;
while (environment(pos(2, 1), pos(1, 1)) == 2)
    direction = randi(4); % 1 = north, 2 = west, 3 = south, 4 = east
    switch direction
        case 1
            pos(1, 1) = pos(1, 2);
            pos(2, 1) = pos(2, 2) + 1;
        case 2
            pos(1, 1) = pos(1, 2) - 1;
            pos(2, 1) = pos(2, 2);
        case 3
            pos(1, 1) = pos(1, 2);
            pos(2, 1) = pos(2, 2) - 1;
        case 4
            pos(1, 1) = pos(1, 2) + 1;
            pos(2, 1) = pos(2, 2);
    end
end
pos(:, 3) = pos(:, 2) + pos(:, 2) - pos(:, 1); % forward
pos(1, 4) = pos(1, 2) + pos(2, 2) - pos(2, 1); % left
pos(2, 4) = pos(2, 2) + pos(1, 1) - pos(1, 2);
pos(1, 5) = pos(1, 2) + pos(2, 1) - pos(2, 2); % right
pos(2, 5) = pos(2, 2) + pos(1, 2) - pos(1, 1);

% Start painting
while (color > 0)
    % Update old state
    pos_temp = pos(:, 1);
    pos(:, 1) = pos(:, 2);
    
    % Read environment
    h = num2str(environment(pos(2, 2), pos(1, 2)));
    f = num2str(environment(pos(2, 3), pos(1, 3)));
    l = num2str(environment(pos(2, 4), pos(1, 4)));
    r = num2str(environment(pos(2, 5), pos(1, 5)));
    
    % Action depending on chromosome
    %     [h f l r]
    %     base2dec([h f l r], 3) + 1
    if ((base2dec([h f l r], 3) + 1) > 54)
        pos
    end
    action = chromosome(base2dec([h f l r], 3) + 1);
    if (action > 5)
        action = randi([3 5]);
    end
    
    % If hitting the wall, stay
    if (environment(pos(2, action), pos(1, action)) == 2)
        pos(:, 1) = pos_temp;
    else
        % Move
        pos(:, 2) = pos(:, action);
        
        % Update surroundings
        pos(:, 3) = pos(:, 2) + pos(:, 2) - pos(:, 1); % forward
        pos(1, 4) = pos(1, 2) + pos(2, 2) - pos(2, 1); % left
        pos(2, 4) = pos(2, 2) + pos(1, 1) - pos(1, 2);
        pos(1, 5) = pos(1, 2) + pos(2, 1) - pos(2, 2); % right
        pos(2, 5) = pos(2, 2) + pos(1, 2) - pos(1, 1);
        
        % Paint
        environment(pos(2, 2), pos(1, 2)) = 1;
    end
    
    % Paint
    color = color - 1;
    %     imagesc(environment)
    %     pause(0.5)
end

out = environment;
end
