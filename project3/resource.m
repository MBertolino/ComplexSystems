clear all; close all;

% Params
n = 3;
a = 5;
u = 1;
mu = 500;
p = 0.0002;

% Constants
T = 1000;

% Initialize data
S = zeros(6, T); % Species at time t
S(1:end, 1) =  1;
R = zeros(n, 1); % Metabolites
N = zeros(T, 1); % Total number of species at time t

% Step in time
for t = 1:T
    N(t) = sum(S(:, t));
    if (N(t) == 0)
        break;
    end
    % Generate a time interval
    dt = exprnd(1/N(t), N(t), 1);
    
    % Inflow of metabolites
    R(u) = R(u) + mu*dt(u);
    
    for k = 1:N(t)
        
        % Select one individual
        s = randsample(1:length(S(:, t)), 1, 1, S(:, t));
%         disp(s);
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
%         disp(i);
%         disp(j);
%         disp(' ');
        % Reproduce
        if (i == j)
            q = (R(i)./(a + R(i))).*((R(i) - 1)./(a + R(i) - 1));
        else
            q = (R(i)./(a + R(i))).*(R(j)./(a + R(j)));
        end
        
        % If reproduction else death
        m = 0;
        while ( m ~= s )
            m = randi(length(S(:, 1)));
        end
        
        if (rand < q)
            
            if (rand >= p)
                m = s;
            end
            if ((i+j) < (n+1))
                S(m, t+1) = S(m, t) + 1;
                R(i) = R(i+j) + 1;
            elseif ((i+j) == (n+1))
                S(m, t+1) = S(m, t) + 1;
                R(1) = R(1) + 1;
            else
                S(m, t+1) = S(m, t) + 1;
                R(1) = R(1) + 1;
                R(mod((i+j), (n+1))) = R(mod((i+j), (n+1))) + 1;
            end
            % Metabolites consumed during reproduction
            R(i) = R(i) - 1;
            R(j) = R(j) - 1;
        else
            S(s, t+1) = S(s, t) - 1;
        end
        
    end
    % Mutate species
    %     for k = 1:length(S(:,t))
    %        for m = 1:sum(S(k,t))
    %            if rand < p
    %                S(k, t+1) = S(k, t+1) -1;
    %
    %            end
    %        end
    %     end
    
    
end
N(t) = sum(S(:, t));
plot(1:t, N(1:t));