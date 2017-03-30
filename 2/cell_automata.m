clear all; close all; % clc;

T = 70;
rule = dec2bin(30, 8);
x0 = dec2bin(1024^8, 160);

% Initialize matrix
a = zeros(T, length(x0));
for i = 1:length(x0)
    a(1, i) = str2double(x0(i));
end

% Update
for t = 2:T
    x1 = ca_func([x0(end) x0(1) x0(2)], rule);
    for i = 2:length(x0)-1
        x1 = [x1 ca_func([x0(i-1) x0(i) x0(i+1)], rule)];
    end
    x1 = [x1 ca_func([x0(end-1) x0(end) x0(1)], rule)];
    
    % Save in matrix
    for i = 1:length(x0)
        a(t, i) = str2double(x1(i));
    end
    x0 = x1;
end

% Plot development
colormap(gray)
imagesc(imcomplement(a))