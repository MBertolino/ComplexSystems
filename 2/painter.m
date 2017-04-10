clear all; % close all; clc;

T = 11000;
N = 100;
world = zeros(N, N);

% Colors and rules
color = [0 1];
turn = [1 -1]; % 1 = left, -1 = right

% Initial coordinates of painter
x_old = N/2;
x_new = N/2;
y_old = N/2 + 1;
y_new = N/2;
world(y_new, x_new) = color(1);

% Step in time and paint
for t = 1:T
    % Update coordinates
    x = x_new;
    y = y_new;
    
    % Paint :)
    idx = world(y, x) == color;
    world(y, x) = color(circshift(idx, 1));
    
   % Update old coordinates
    x_new = x + turn(idx)*(y_old - y);
    y_new = y + turn(idx)*(x - x_old);   
    
    x_old = x;
    y_old = y;
    
    % Account for boundary conditions
    if x_new == N+1
        x_new = 1;
        x_old = 0;
    end
    if x_new == 0
        x_new = N;
        x_old = N+1;
    end
    
    if y_new > N
        y_new = 1;
        y_old = 0;
    end
    if y_new < 1
        y_new = N;
        y_old = N+1;
    end
end

% Final world
figure()
colormap('gray')
imagesc(imcomplement(world));
title(['Time: ' num2str(T)])
xlabel('x-coordinates')
ylabel('y-coordinates')
