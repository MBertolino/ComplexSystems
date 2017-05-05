function [out] = OneChromPerf(environment, chromosome)

color = size(environment, 1)*size(environment, 2);
position = [randi(size(environment(:, 1), 1)) randi(size(environment(:, 2), 1))];
direction = randi(4); % 1 = north, 2 = west, 3 = south, 4 = east

% Start painting
while (color > 0)
    % Read environment
    h = num2str(environment(position(1), position(2)));
    f = num2str(environment(position(1)+1, position(2)));
    l = num2str(environment(position(1), position(2)-1));
    r = num2str(environment(position(1), position(2)+1));
    
    % Action depending on chromosome
    [h f l r]
    base2dec([h f l r], 3)
    action = chromosome(base2dec([h f l r], 3) + 1);
    switch action
        case 1
            postion(1) = postion(1) + 1;
        case 2
            position(2) = position(2) - 1;
        case 3
            position(2) = position(2) + 1;
        case 4
            position = position + [randi([-1 1]) randi([-1 1])];
    end
    
    % Paint
    environment(position(1), position(2)) = 2;
    color = color - 1;
end

out = environment;
end
