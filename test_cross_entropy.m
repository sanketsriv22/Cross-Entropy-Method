function test_cross_entropy()
    close all;
    % Top-Down Test function for Cross-Entropy Method

    % Parameters
    n = 100;            % Population size
    n_elite = 20;       % Elite samples
    max_iter = 100;     % Max iteration limit 
    dim = 2;            % Dimension of obj. function

    % Initialize sampling distribution (Gaussian)
    mu0 = 5*zeros(dim, 1);         % initial mean
    sigma0 = 10*ones(dim, 1);     % initial standard dev
    init_params = zeros(1, dim);

    plotAckley();
    
    %% Run CEM on objective function
    [best_params, best_score] = cross_entropy(@fcn_ackley, dim, n, n_elite, max_iter, mu0, sigma0, init_params);

    % Display results
    fprintf('Best solution found: %s\n', mat2str(best_params));
    fprintf('Best score: %4f\n', best_score);
    
    figure(2);
    plot3(best_params(1), best_params(2), best_score, 'ro', 'MarkerSize', 15, 'MarkerFaceColor', 'g');


end