clear all; %close all; clc;

T = 10000;
N = 100;
world = zeros(N, N);

% Colors and rules
color = [0 12 24 36 48 60 72 84 96];
turn = [1 1 1 1 -1 1 1 1 1]; % 1=left, -1=right

% Initial coordinates of painter
x_old = N/2;
x_new = N/2;
y_old = N/2;
y_new = N/2 - 1;
world(y_new, x_new) = color(1);

% Step in time and paint
figure()
colormap('jet')
for t = 1:T
    % Update coordinates
    x = x_new;
    y = y_new;
    
    idx = world(y, x) == color;
    world(y, x) = color(circshift(idx, 1));
    
   % Update old coordinates
    x_new = x + turn(idx)*(y_old - y);
    y_new = y + turn(idx)*(x - x_old);
    x_old = x;
    y_old = y;
    
    % Paint :)
    %image(world)
    %pause(0.002);
end

% Final world
image(world);
