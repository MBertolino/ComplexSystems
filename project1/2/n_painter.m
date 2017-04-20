clear all; % close all; clc;
ip = 4;
n = 4;

T = 1000;
N = 200;
world = zeros(N, N);

% Colors and rules
color = [0 12 24];
turn = [1 1 -1]; % 1=left, -1=right

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
end

% Final world
%figure()
colormap('jet')
subplot(2, 2, ip)
imagesc(imcomplement(world));
title([num2str(n)])
