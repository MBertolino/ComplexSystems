function A = pop_local_func(n, b, T, A1, d)

A = zeros(T, 1); % Population
A(1) = A1;

% All individuals choose which site to visit
site = randi([1, n], 1, A(1));

% Reproduce or disappear
idx = histc(site, 1:n);
idx = (idx == 2);
A(2) = sum(idx)*b;

for t = 3:T
    site = zeros(1, n);
    for i = find(idx == 1)
        move = i-d:i+d;
        move(move > n) = move(move > n) - n;
        move(move < 1) = n + move(move < 1);
        
        % All individuals choose which site to visit locally [i-d, i+d]
        pos = randi(length(move), 1, b);
        site_temp = move(pos);        
        site(unique(move)) = site(unique(move)) + histc(site_temp, unique(move));
    end
    
    % Reproduce or disappear
    idx = (site == 2);
    A(t) = A(t) + sum(idx == 1)*b;
end