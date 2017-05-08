clear all; close all; 

% Setup
% -1 = non-accessible, 0 = empty, 1 = painted
% 1 = forward,  0 = left, -1 = right
environment = zeros(20, 40);
environment(:, [1 end]) = 2;
environment([1 end], :) = 2;
% 3 = straight, 4 = left, 5 = right, 6 = random
% chromosome = ones(54, 1)*6;
chromosome = randi([3 6], 54, 1);

% Plot initial environment
% figure()
% imagesc(environment)

% Paint
out_environment = OneChromPerf(environment, chromosome);
empty = sum(sum(out_environment == 0));
paint = sum(sum(out_environment == 1));
fitness = paint/(paint + empty)

% Plot map after painter
% figure()
% hold on;
% subplot(2, 2, 4)
% imagesc(out_environment)