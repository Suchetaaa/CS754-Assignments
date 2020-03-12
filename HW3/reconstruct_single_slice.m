function brain_slice_recon = reconstruct_single_slice(...
    sparse_tranform, sparse_tranform_inv, image_size, random_angles, ...
    projections)
%RECONSTRUCT_SINGLE_SLICE Summary of this function goes here
%   Detailed explanation goes here
    projection_size = size(projections, 1);
    
    A = forward_simple(sparse_tranform_inv, image_size, random_angles, ...
        projection_size);
    At = forward_simple_t(sparse_tranform, image_size, random_angles, ...
        projection_size);
    m = numel(projections);
    n = image_size^2;
    y = projections(:);
    lambda = 0.1;
    rel_tol = 1e-6;
    quiet = true;

    [sparse_vector, status] = l1_ls(A, At, m, n, y, lambda, rel_tol, quiet);
    status = status
    sparse_vector = reshape(sparse_vector, image_size, image_size);
    brain_slice_recon = sparse_tranform_inv(sparse_vector);
end

