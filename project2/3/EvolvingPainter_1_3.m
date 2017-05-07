clear all; %close all;

% Setup
N_gen = 20;

% Environment Setup
% -1 = non-accessible, 0 = empty, 1 = painted
% 1 = forward,  0 = left, -1 = right
x_max = 40;
y_max = 20;
environment = zeros(y_max + 2, x_max + 2);
environment(:, [1 end]) = 2;
environment([1 end], :) = 2;

% Chromosomes
% 1 = straight, 2 = left, 3 = right, 4 = random
N_chrom = 50;
chromosome = randi(4, 54, N_chrom);

% Pre-allocate
empty = zeros(N_gen, N_chrom);
paint = zeros(N_gen, N_chrom);
fitness = zeros(N_gen, N_chrom);


% Paint
for i = 1: N_gen
    disp(i/N_gen)
    tic;
    for j = 1:N_chrom
        out_environment = OneChromPerf(environment, chromosome(:, j));
        paint(i, j) = nnz(out_environment(2:end-1, 2:end-1)); % sum(sum(out_environment == 1));
        empty(i, j) = y_max*x_max - paint(i, j); % sum(sum(out_environment == 0));
        fitness(i, j) = paint(i, j)/(paint(i, j) + empty(i, j));
    end
    toc;

    % Single point cross-over
    cross_over = randsample(1:N_chrom, 2, 1, fitness(i, :));
    split = randi(54);
    temp_mutation = chromosome(1:split, cross_over(1));
    chromosome(1:split, cross_over(1)) = chromosome(1:split, cross_over(2));
    chromosome(1:split, cross_over(2)) = temp_mutation;
    
    % Mutate
    for j = 1:N_chrom
        if (rand < 0.05)
            mutate = randi(54);
            chromosome(mutate, j) = randi(4);
        end
    end
end

% Plot map after painter
% figure()
hold on;
subplot(2, 2, 4)
imagesc(out_environment)