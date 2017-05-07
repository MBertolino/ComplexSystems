clear all; %close all;

% Setup
N_gen = 200;
N_sims = 10;

% Environment Setup
% -1 = non-accessible, 0 = empty, 1 = painted
% 1 = forward,  0 = left, -1 = right
x_max = 40;
y_max = 20;
environment = zeros(y_max, x_max);
environment(:, [1 end]) = 2;
environment([1 end], :) = 2;

% Chromosomes
% 1 = straight, 2 = left, 3 = right, 4 = random
N_chrom = 50;
chromosome = randi([3 6], 54, N_chrom);

% Pre-allocate
empty = zeros(N_gen, N_chrom);
paint = zeros(N_gen, N_chrom);
fitness = zeros(N_gen, N_chrom);


% Paint
tic;
for i = 1:N_gen
    for j = 1:N_chrom
        for k = 1:N_sims
            out_environment = OneChromPerf(environment, chromosome(:, j));
            paint(i, j) = nnz(out_environment(2:end-1, 2:end-1));
            fitness(i, j) = fitness(i, j) + paint(i, j)/(x_max*y_max);
        end
    end
    
    % Single point cross-over
    cross_over = randsample(1:N_chrom, 2, 1, fitness(i, :));
    while (cross_over(1) == cross_over(2))
        cross_over(2) = randsample(1:N_chrom, 1, 1, fitness(i, :));
    end
    split = randi(54);
    temp_mutation = chromosome(1:split, cross_over(1));
    chromosome(1:split, cross_over(1)) = chromosome(1:split, cross_over(2));
    chromosome(1:split, cross_over(2)) = temp_mutation;
    
    % Mutate
    for j = 1:N_chrom
        if (rand < 0.05)
            mutate = randi(54);
            chromosome(mutate, j) = randi([3 6]);
        end
    end
    disp(i/N_gen)
end
toc;

% Plot map after painter
% figure()
% imagesc(out_environment)