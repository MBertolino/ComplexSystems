clear all; close all;

% Params
n = 3;
a = 5;
u = 1;
mu = 500;
p = 0.001;

% Constants
T = 100;

% Initialize data
S = zeros(2*n, T); % Species at time t
S(:, 1) =  1;
R = zeros(n, 1); % Metabolites
N = zeros(T, 1); % Total number of species at time t
N(1) = sum(S(:, 1));
% Step in time
for t = 2:T
    
    
    % Generate a time interval
    dt = exprnd(1/N(t-1), N(t-1), 1);
    
    % Inflow of metabolites
    R(u) = R(u) + mu*dt(u);
    
    for k = 1:N(t)
        % Select one individual
        s = randsample(1:length(S(:, t-1)), 1, 1, S(:, t-1));
        
        % Calculating chosen organisms speciess = 5;
        c = 0;
        for ii = 1:n
            for jj = ii:n
                if (c < s)
                    c = c + 1;
                    i = ii;
                    j = jj;
                else
                    jj = n;
                    ii = n;
                end
            end
        end
        
        % Reproduce
        if (i == j)
            q = (R(i)./(a + R(i))).*((R(i) - 1)./(a + R(i) - 1));
        else
            q = (R(i)./(a + R(i))).*(R(j)./(a + R(j)));
        end
        
        % If reproduction else death
        if (rand < q)
            if ( (i + j) < (n + 1) )
                S(s) = S(s) + 1;
                R(i) = R(i + j) + 1;
            elseif ( (i + j) == (n + 1) )
                S(s) = S(s) + 1;
                R(1) = R(1) + 1;
            else
                S(s) = S(s) + 1;
                R(1) = R(1) + 1;
                R(mod((i + j), (n + 1))) = R(mod((i + j), (n + 1))) + 1;
            end
            % Metabolites consumed during reproduction
            R(i) = R(i) - 1;
            R(j) = R(j) - 1;
        else
            S(s) = S(s) - 1;
        end
    end
    N(t) = sum(S(:, t));
end