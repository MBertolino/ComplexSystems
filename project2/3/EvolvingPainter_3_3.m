clear all; close all;

% Setup
N_gen = 200;
N_sims = 5;

% Environment Setup
% -1 = non-accessible, 0 = empty, 1 = painted
% 1 = forward,  0 = left, -1 = right
x_max = 40;
y_max = 20;
environment = zeros(y_max, x_max);
environment(:, [1 end]) = 2;
environment([1 end], :) = 2;

% Chromosomes
% 3 = straight, 4 = left, 5 = right, 6 = random
N_chrom = 20;
L = 54;
chromosome = randi([3 6], L, N_chrom);

% Pre-allocate
empty = zeros(N_gen, N_chrom);
paint = zeros(N_gen, N_chrom);
fitness = zeros(N_gen, N_chrom);
D = zeros(N_gen, 1);
chromosome_new = zeros(L, N_chrom);
temp_mutation = zeros(L, 1);

% Evolve
tic;
for i = 1:N_gen
    for j = 1:N_chrom
        for k = 1:N_sims
            out_environment = OneChromPerf(environment, chromosome(:, j));
            paint(i, j) = nnz(out_environment(2:end-1, 2:end-1));
            fitness(i, j) = fitness(i, j) + paint(i, j)/((x_max-2)*(y_max-2));
        end
    end
    fitness(i, :) = fitness(i, :)./N_sims;
    %     fitness(i, :) = fitness(i, :)/(sum(fitness(i, :)));
    
    %     % 3.4 Genetic diveristy
    %     for l = 1:L
    %         for
    %         D(i) =
    
    % Single point cross-over
    for j = 1:2:N_chrom
        N_chroms = 1:N_chrom;
        cross_over = randsample(N_chroms, 1, 1, fitness(i, :));
        N_chroms(cross_over) = [];
        cross_over(2) = randsample(N_chroms, 1, 1, fitness(i, N_chroms));
        split = randi(L);
        temp_mutation(1:split) = chromosome(1:split, cross_over(1));
        temp_mutation(split+1:end) = chromosome(split+1:end, cross_over(2));
        chromosome_new(1:split, j) = chromosome(1:split, cross_over(2));
        chromosome_new(split+1:end, j) = chromosome(split+1:end, cross_over(1));
        
        chromosome_new(1:split, j+1) = temp_mutation(1:split);
        chromosome_new(split+1:end, j+1) = temp_mutation(split+1:end);
    end
    
    % Mutate
    for j = 1:N_chrom
        if (rand < 0.05)
            mutate = randi(L);
            chromosome_new(mutate, j) = randi([3 6]);
        end
    end
    disp(i/N_gen)
    
    % Update chromosomes
    chromosome = chromosome_new
end
toc;

% 3.4 Average fitness
% figure()
plot(1:N_gen, mean(fitness, 2))