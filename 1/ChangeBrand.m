function u = ChangeBrand(p, q, N, u1, T)
%CHANGEBRAND Summary of this function goes here
%   u - Number of iPhone users

u = zeros(1, T);
u(1) = u1;

for t = 1:T-1
    if rand < u(t)/N
        % iPhone broke
        if rand < q
            if rand < p
                % Get new iPhone
                u(t+1) = u(t);
            else
                u(t+1) = u(t) - 1;
            end
        else
            % Look at neighbors
            u(t+1) = u(t) - (rand < (N - u(t))/N)*(rand < (N - u(t))/N);
        end
    else
        % Other brand broke
        if rand < q
            if rand < p
                % Get new iPhone
                u(t+1) = u(t) + 1;
            else
                u(t+1) = u(t);
            end
        else
            u(t+1) = u(t) + (rand < u(t)/N)*(rand < u(t)/N);
        end
    end
end
