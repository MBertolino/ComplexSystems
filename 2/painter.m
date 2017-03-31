clear all; close all; clc;

T = 11000;
N = 1000;
world = zeros(N, N);

% Initial coordinates of painter
x_old = 300;
x_new = 300;
y_old = 300;
y_new = 299;
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