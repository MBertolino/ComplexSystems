function A = pop_func(n, b, T, A1)

A = zeros(T, 1); % Population
A(1) = A1;

for t = 2:T
    % All individuamicsals choose which site to visit
    site = randi([1, n], 1, A(t-1));
    
    % Reproduce or disappear
    idx = histc(site, 1:n);
    A(t) = A(t) + sum(idx == 2)*b;
end