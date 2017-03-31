clear all; %close all; clc;

T = 100;
N = 30;
world = zeros(N, N);

% Colors and rules
color = [0 12 24];
turn = [1 -1 1]; % 1=left, -1=right

% Initial coordinates of painter
x_old = 15;
x_new = 15;
y_old = 15;
y_new = 14;
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
