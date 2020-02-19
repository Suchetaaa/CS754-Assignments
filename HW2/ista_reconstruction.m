function theta = ista_reconstruction(measurements, ...
    A_matrix, alpha, lambda, epsilon)
    %ISTA_RECONSTRUCTION recon using ista algorithm
    %   Inputs:
    %       measurements: measurements in compressive sensing
    %       A_matrix: product of sensing matrix and sparse tranformation
    %           inv
    %       alpha: a number greater than the highest eigenvalue of A'A
    %       lambda: relative weightage to norm 1 of theta
    %       epsilon: convergence threshold

    [~, recon_size] = size(A_matrix);
    theta = zeros(recon_size, 1);
    i = 0;
    theta_new = theta + epsilon * 1.1;
    while norm(theta - theta_new) > epsilon
        theta = theta_new;
        theta_new = theta + 1/alpha * A_matrix' * (measurements - ...
            A_matrix * theta);
        theta_new = soft(theta_new, lambda/(2*alpha));
        i = i + 1;
    end
    
    theta = theta_new;

end