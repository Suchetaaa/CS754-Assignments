function [patch_recon] = getPatchRecon(patch_code, patch_snapshot, epsilon)

% GETPATCHRECON a reconstruction using the ideas simplified from 
% "Video from a Single Exposure Coded Photograph"
% http://www.cs.columbia.edu/CAVE/projects/single_shot_video/
%
% Inputs:
%    patch_code:     a code of size (patch_size, patch_size, time)
%    patch_snapshot: snapshot with size (patch_size, patch_size)
%
% Output:
%    patch_recon:    reconstruction with size (patch_size, patch_size, ...
%                                              time)

% sanity checks and size variables
if size(patch_code, 1) ~= size(patch_code, 2)
    error("size of patch_code is not valid")
end

if size(patch_snapshot, 1) ~= size(patch_snapshot, 2)
    error("size of patch_code is not valid")
end

[patch_size, ~, time] = size(patch_code);

 
% reshape the patch_code and patch_snapshot
b = patch_snapshot(:);

A = zeros(patch_size^2, patch_size^2*time);
for height_index = 1:patch_size
    for width_index = 1:patch_size
        curr_code_pattern = zeros(size(patch_code));
        curr_code_pattern(height_index, width_index, :) = ...
            patch_code(height_index, width_index, :);
        curr_code_pattern = curr_code_pattern(:);
        A((width_index-1)*patch_size+height_index,:) = curr_code_pattern;
    end 
end

% create a 2d-dct matrix (size: (patch_size^2, patch_size^2))
dct1d_matrix = dctmtx(patch_size);
dct_matrix = kron(eye(time), kron(dct1d_matrix, dct1d_matrix));
inv_dct_matrix = dct_matrix';

% create matrix A and b for OMP algorithm 
omp_A_matrix = A * inv_dct_matrix;
omp_b_matrix = b;

% call the OMP algorithm
omp_theta_output = OMPAlgorithm(omp_A_matrix, omp_b_matrix, epsilon);
omp_recon = inv_dct_matrix * omp_theta_output;

% reshape the omp_recon to get patch_recon
patch_recon = reshape(omp_recon, size(patch_code));

end