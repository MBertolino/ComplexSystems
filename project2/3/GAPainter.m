clear all; close all; 

% Setup
% 1 = non-accessible, 0 = empty
% 1 = forward, 0 = left, -1 = right
environment = zeros(20, 40);
% 1 = straight, 2 = left, 3 = right, 4 = random
chromosome = ones(54, 1)*4;

% Plot initial environment
figure()
imagesc(environment)

% Paint
out_environment = OneChromPerf(environment, chromosome);

% Plot map after painter
figure()
imagesc(out_environment)