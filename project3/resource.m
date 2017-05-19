clear all; close all;

% Params
n = 3;
a = 5;
u = 2;
mu = 500;
p = 0.001;
N_spec = n*(n+1)*0.5;

% Constants
t = 1;
T = 500;

% Initialize data
S = zeros(N_spec, T); % Species at time t
S(:, 1) =  1;
S_tmp = S(:, 1);
R = zeros(n, 1); % Metabolites
N = zeros(T, 1); % Total number of species at time t
N(t) = sum(S(:, t));

h = waitbar(0/T, 'Progress');
% Step in time
while t <= T
    waitbar(t/T, h, ['Progress: ' num2str(round((t/T)*100, 1)) ' % ']);
    
    % Generate a time interval
    dt = exprnd(1/sum(S_tmp));
    
    % Inflow of metabolites
    R(u) = R(u) + mu*dt;
    
    % Select one individual
    s = randsample(1:N_spec, 1, 1, S_tmp);
    
    % Calculating chosen organisms species (the ugly way);
    tmp = 0;
    for k = 0:n - 1
        tmp = tmp + n - k;
        if s < tmp
            i = k + 1;
            j = s - tmp + n;
            break;
        elseif s == tmp
            i = k + 1;
            j = n;
            break;
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
    m = randi(N_spec);
    while (m == s)
        m = randi(N_spec);
    end
    
    if (reproduce < q)
        % Metabolites consumed during reproduction
        R(i) = R(i) - 1;
        R(j) = R(j) - 1;
        
        % Mutate if smaller
        if (rand >= p)
            m = s;
        end
        
        % Update
        if ((i+j) < (n+1))
            R(i+j) = R(i+j) + 1;
        else
            R(1) = R(1) + 1;
            if ((i+j) - (n+1) > 0)
                R(1) = R(1) + 1;
            end
        end
        S_tmp(m) = S_tmp(m) + 1;
        S_tmp(s) = S_tmp(s) + 1;
    end
    
    % Individual dies
    S_tmp(s) = S_tmp(s) - 1;
    
    t_old = t;
    t = t + dt;
    if floor(t) - floor(t_old) == 1
        t_tmp = floor(t);
        %R(t_tmp,:) = resource;
        S(:, t_tmp) = S_tmp;
        N(t_tmp) = sum(S(:, t_tmp));
        if (N(t_tmp) == 0)
            break;
        end
    end
end
%N(t) = sum(S(:, t));
disp(['standard deviation of N: ' num2str(std(N))]);
close(h);

% Plot population
figure()
area(1:t_tmp, S(:, 1:t_tmp)');
legend('1', '2', '3', '4', '5', '6');
xlabel('Time')
ylabel('Population')