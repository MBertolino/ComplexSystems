clear all;

% Params
n = 1000; % # sites
b = 1:50; % [5, 10, 20, 30, 40];
d = [10, 80, 270, 800];
T = 100;

% Allocate
A_dyn = zeros(T, length(b));
A_dyn(1) = n;

for m = 1:length(d)
    % Setup waitbar
    h = waitbar(0, 'Please wait...');
    
    for j = 1:length(b)
        A = n;
        
        % All individuals choose which site to visit
        site = randi([1, n], 1, A);
        
        % Reproduce or disappear
        idx = histc(site, 1:n);
        idx = (idx == 2);
        A = sum(idx)*b(j);
        for t = 2:T-1
            site = zeros(1, n);
            for i = find(idx == 1)
                move = i-d(m):i+d(m);
                move(move > n) = move(move > n) - n;
                move(move < 1) = n + move(move < 1);
                
                % All individuals choose which site to visit locally [i-d, i+d]
                pos = randi(length(move), 1, b(j));
                site_temp = move(pos);
                site(unique(move)) = site(unique(move)) + histc(site_temp, unique(move));
            end
            
            % Reproduce or disappear
            idx = (site == 2);
            A_dyn(t+1, j) = sum(idx == 1)*b(j);
        end
        
        % Update waitbar
        waitbar(j/length(b))
    end
    close(h)
    
    % Plot results
    subplot(2, 2, m)
    plot(b, A_dyn, 'k.')
    xlabel('Number of offsprings, b');
    ylabel('Population size')
end