clear all; close all; clc;

T = 18000;
N = 300;
world = zeros(N, N);

% Initial coordinates of painter
x_old = 100;
x_new = 100;
y_old = 101;
y_new = 100;
world(y_new, x_new) = 1;

% Step in time and paint
figure()
colormap('gray')
for t = 1:T
    % Update coordinates
    x = x_new;
    y = y_new;
    
    % If white
    if (world(y, x) == 0)
       world(y, x) = 1;
       
       % Turn right
       x_new = x + (y_old - y); % x = 10 + (10 - 10) = 10
       y_new = y + (x - x_old); % y = 10 + (10 - 9) = 11
    else
        world(y, x) = 0;

        % Turn left
        x_new = x + (y - y_old);
        y_new = y + (x_old - x);
    end
    
    % Update old coordinates
    x_old = x;
    y_old = y;
    
    % Paint :)
    %imagesc(imcomplement(world))
    %pause(0.002);
end

% Final world
imagesc(imcomplement(world));
title(['Time: ' num2str(T)])
