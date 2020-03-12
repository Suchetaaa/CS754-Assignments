function brain_slice_recon = reconstruct_three_slices(...
    sparse_tranform, sparse_tranform_inv, image_size, random_angles, ...
    projections)
%RECONSTRUCT_SINGLE_SLICE Summary of this function goes here
%   Detailed explanation goes here
    projection_size = size(projections, 1);
    
    A = forward_coupled3(sparse_tranform_inv, image_size, random_angles, ...
        projection_size);
    At = forward_coupled3_t(sparse_tranform, image_size, random_angles, ...
        projection_size);
    m = numel(projections);
    n = 3*image_size^2;
    y = projections(:);
    lambda = 0.1;
    rel_tol = 1e-6;
    quiet = true;

    [sparse_vector, status] = l1_ls(A, At, m, n, y, lambda, rel_tol, quiet);
    status = status
    
    sparse_vector = reshape(sparse_vector, image_size, image_size, 3);
    sparse_vector(:,:,2) = sparse_vector(:,:,1) + sparse_vector(:,:,2);
    sparse_vector(:,:,3) = sparse_vector(:,:,1) + sparse_vector(:,:,3);
    
    brain_slice_recon(:,:,1) = sparse_tranform_inv(sparse_vector(:,:,1));
    brain_slice_recon(:,:,2) = sparse_tranform_inv(sparse_vector(:,:,2));
    brain_slice_recon(:,:,3) = sparse_tranform_inv(sparse_vector(:,:,3));
end

