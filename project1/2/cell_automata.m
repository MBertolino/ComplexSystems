clear all; close all; % clc;

T = 70;
% Classes: 136 37 18 110
%init = 1024^8;
init = round(1024^8*rand);
rules = [136 37 18 110];

% Repeat for each class
figure()
colormap(gray)
for c = 1:4
    rule = dec2bin(rules(c), 8);
    x0 = dec2bin(init, 161);
    
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
    subplot(2, 2, c)
    imagesc(imcomplement(a))
    title(['Rule ' num2str(rules(c))])
end