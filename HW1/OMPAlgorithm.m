function basis_coeffs_vector = OMPAlgorithm(support_matrix, measurements, epsilon)
% OMPALGORITHM implentation of OMP algorithm
%
% Inputs:
%    support_matrix: matrix containing vectors whose sparse linear
%    combination in measurements (m x n)
%    measurements:  sparse linear combination of column of support matrix
%    (assumed) (m x 1)
%
% Output:
%    omp_recon:     sparse vector with size equal to number of columns of
%    support_matrix (n x 1)
%    

[~, n] = size(support_matrix);
curr_residual = measurements .* 1.0; 
support_set = [];
old_vecnorm_residual = vecnorm(curr_residual) + 100 * epsilon;

while abs(old_vecnorm_residual - vecnorm(curr_residual)) > epsilon
    old_vecnorm_residual = vecnorm(curr_residual); 
    [~, new_support_element] = max(abs((support_matrix' * curr_residual) ./ ...
        vecnorm(support_matrix)')); 
    support_set = [support_set, new_support_element];
    support_matrix_current = support_matrix(:, support_set);
    basis_coeffs_current = pinv(support_matrix_current) * measurements;
    curr_residual = measurements - support_matrix_current * ...
        basis_coeffs_current;
end

basis_coeffs_vector = zeros(n, 1);
basis_coeffs_vector(support_set, :) = basis_coeffs_current;
end