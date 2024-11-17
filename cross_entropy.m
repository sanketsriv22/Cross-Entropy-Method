function [best_params, best_score] = cross_entropy(fcn, dim, n, n_elite, max_iter, mu0, sigma0, init_params)
    % Cross-Entropy Method implementation

    % Initialize variables
    best_score = inf;
    best_params = init_params;
    mu = mu0;
    sigma = sigma0;

    % Track mean and standard deviation for plotting
    mu_history = zeros(dim, max_iter);
    sigma_history = zeros(dim, max_iter);

    % Initialize previous sigma for convergence check
    sigma_prev = sigma;  % Store previous sigma

    % figure(3);

    for iter=1:max_iter
        % Step 1: Generate Population
        population = mu + sigma .* randn(dim, n);

        % Step 2: Evaluate Population
        scores = zeros(n, 1);
        for i = 1:n
            x1 = population(1, i);
            x2 = population(2, i);
            scores(i) = fcn(population(:, i));
            plot3(x1, x2, scores(i), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'k');
            pause(0.05)
        end
    
        % Step 3: Select Elite Samples
        [~, elite_idx] = sort(scores);      % ascending
        elite_samples = population(:, elite_idx(1:n_elite))';
        x1_elite = elite_samples(:,1);
        x2_elite = elite_samples(:,2);
      
        for j=1:length(n_elite)
            plot3(x1_elite, x2_elite, scores(elite_idx(1:n_elite)), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
            pause(0.1)
        end
        % pause
    
        % Step 4: Update mean and standard deviation with smoothing
        alpha = 0.7; % Smoothing factor (between 0 and 1)
        mu_new = mean(elite_samples)';
        sigma_new = std(elite_samples)';

        % Smoothing updates, rather than simply using mu/sigma
        mu = alpha * mu_new + (1 - alpha) * mu;
        sigma = alpha * sigma_new + (1 - alpha) * sigma;

        % Track history for params for plotting
        mu_history(:, iter) = mu;
        sigma_history(:, iter) = sigma;

        % Keep track of the best objective value found so far
        iter_best = scores(elite_idx(1));
        if iter_best < best_score
            best_score = iter_best;
            best_params = elite_samples(1, :);
        end
        
        % Calculate RMS norm of the difference between current and previous sigma
        diff_sigma = sigma - sigma_prev;  % Difference between current and previous sigma
        rms_diff_sigma = sqrt(mean(diff_sigma.^2));  % Calculate the RMS norm

        % Check for convergence
        % if rms_diff_sigma <= 1
        if abs(diff_sigma) < 1e-4
            fprintf("Convergence achieved at iteration %d.\n", iter);
            break;  % Exit the loop if convergence is achieved
        end

        % Update previous sigma for next iteration
        sigma_prev = sigma;

        fprintf("Iteration %d, Best Score: %.4f\n", iter, best_score);

    end

figure;

% Plot mu convergence
subplot(2,1,1);
plot(1:iter, mu_history(:, 1:iter));
title('Mean Convergence');
xlabel('Iteration');
ylabel('Mean Value');
legend(arrayfun(@(i) sprintf('mu_%d', i), 1:dim, 'UniformOutput', false));

% Plot sigma convergence
subplot(2,1,2);
plot(1:iter, sigma_history(:, 1:iter));
title('Standard Deviation Convergence');
xlabel('Iteration');
ylabel('Standard Deviation');
legend(arrayfun(@(i) sprintf('sigma_%d', i), 1:dim, 'UniformOutput', false));

end