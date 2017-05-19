clear all; close all;

% Params
n = 2;
a = 5;
u = 1;
mu = 500;
p = 0.001;

% Constants
T = 1000;

% Initialize data
S = zeros(n*(n+1)*0.5, T); % Species at time t
S(1:end, 1) =  1;
R = zeros(n, 1); % Metabolites
N = zeros(T, 1); % Total number of species at time t

h = waitbar(0/T, 'Progress');
% Step in time
for t = 1:T
    waitbar(t/T, h, ['Progress: ' num2str(round((t/T)*100, 1)) ' % ']);
    % Update whole population
    N(t) = sum(S(:, t));
    if (N(t) == 0)
        break;
    end
    
    % Generate a time interval
    dt = exprnd(1/N(t));
    
    % Inflow of metabolites
    R(u) = R(u) + mu*dt;
    
    % Select one individual
    s = randsample(1:length(S(:, t)), 1, 1, S(:, t));
    
    % Calculating chosen organisms species (the ugly way);
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
    reproduce = rand;
    
    if (i == j)
        q = (R(i)./(a + R(i))).*((R(i) - 1)./(a + R(i) - 1));
        if (R(i) < 2)
            reproduce = q + 1;
        end
    else
        q = (R(i)./(a + R(i))).*(R(j)./(a + R(j)));
        if (R(i) < 1 || R(j) < 1)
            reproduce = q + 1;
        end
    end
    
    % If reproduction else death
    m = 0;
    while (m ~= s)
        m = randi(length(S(:, 1)));
    end
    
    if (reproduce < q)
        % Mutate if smaller
        if (rand >= p)
            m = s;
        end
        
        % Update
        if ((i+j) < (n+1))
            S(m, t) = S(m, t) + 1;
            R(i+j) = R(i+j) + 1;
        else
            S(m, t) = S(m, t) + 1;
            R(1) = R(1) + 1;
            if ((i+j) - (n+1) > 0)
                R(1) = R(1) + 1;
            end
        end
        
        % Metabolites consumed during reproduction
        R(i) = R(i) - 1;
        R(j) = R(j) - 1;
        
        S(s, t) = S(s, t) + 1;
    end
    
    % Individual dies
    S(s, t) = S(s, t) - 1;
    
    % Update
    S(:, t+1) = S(:, t);
end
N(t) = sum(S(:, t));
disp(['standard deviation of N: ' num2str(std(N))]);
close(h);

% Plot population
figure()
area(1:t, S(:,1:t)');
legend('1', '2', '3', '4', '5', '6');
xlabel('Time')
ylabel('Population')