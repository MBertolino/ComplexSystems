function u = ChangeBrand(p, N, u1, T)
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
    if rand < p
        u(t+1) = u(t+1) + 1;
    end
end
