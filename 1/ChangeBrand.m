function u = ChangeBrand(p, q, N, u1, T)
%CHANGEBRAND Summary of this function goes here
%   u - Number of iPhone users

u = zeros(1, T);
u(1) = u1;

for t = 1:T-1
    if rand < u(t)/N
        %disp('iPhone broke');
        u(t+1) = u(t) - 1;
    else
        %disp('Other brand broke');
        u(t+1) = u(t);
    end
    
    % Buy new phone
    % 1.1
%        if rand < p
%            u(t+1) = u(t+1) + 1;
%        end
   
    % 1.3
    if rand < q
        if rand < .5
            u(t+1) = u(t+1) + 1;
        end
    else
        u(t+1) = u(t+1) + (rand < u(t+1)/N)*(rand < u(t+1)/N);
    end
end
