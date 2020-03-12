function radonMatrix = getRadonMatrix(theta, N)
% GETRADONMATRIX returns a matrix representing the radon transform of a NxN
% image. 
%   Inputs:
%       theta: angles at which radon transform is computed
%       N: size of the image
%   Outputs:
%       radonMatrix: matrix of size radon_size x (N x N) where radon_size =
%           ceil(sqrt(2) * N + 2 ) * length(theta)
    radon_size = numel(radon(rand(N), theta));
    radonMatrix = zeros(radon_size, N * N);
    for i = 1:N 
        for j = 1:N
            one_hot_input = zeros(N, N);
            one_hot_input(i, j) = 1;
            one_hot_radon = radon(one_hot_input, theta);
            radonMatrix(:,i+(j-1)*N) = one_hot_radon(:);
        end
    end
end

