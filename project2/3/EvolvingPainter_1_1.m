clear all; %close all; 

% Setup
% -1 = non-accessible, 0 = empty, 1 = painted
% 1 = forward,  0 = left, -1 = right
environment = zeros(20 + 2, 40 + 2);
environment(:, [1 end]) = 2;
environment([1 end], :) = 2;
% 1 = straight, 2 = left, 3 = right, 4 = random
chromosome = ones(54, 1)*4;

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
hold on;
subplot(2, 2, 4)
imagesc(out_environment)