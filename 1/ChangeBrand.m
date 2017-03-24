function u = ChangeBrand(p, N, u1, T)
%CHANGEBRAND Summary of this function goes here
%   Detailed explanation goes here

u = zeros(1, T);
u(1) = u1;

for t = 1:T-1
    u(t+1) = u(t);
    
    % Changing to iPhone
    for i = 1:u(t)
        % Probability of changing brand
        if rand < p
            u(t+1) = u(t+1) - 1;
        else
            % Get influenced by others
        end    
    end
    
    % Changing to other brand
    for i = u(t)+1:N
        if rand < p
            u(t+1) = u(t+1) + 1;
        else
            % Get influenced by others
        end
    end
end
