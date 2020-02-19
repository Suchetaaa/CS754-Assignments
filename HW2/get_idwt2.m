function x = get_idwt2(theta)
    [recon_size, ~] = size(theta);
    detail_matrix_size = recon_size/4;
    detail_length = sqrt(detail_matrix_size);

    cA = theta(1:detail_matrix_size);
    cH = theta(detail_matrix_size+1:2*detail_matrix_size);
    cV = theta(2*detail_matrix_size+1:3*detail_matrix_size);
    cD = theta(3*detail_matrix_size+1:end);
        
    cA = reshape(cA, detail_length, detail_length);
    cH = reshape(cH, detail_length, detail_length);
    cV = reshape(cV, detail_length, detail_length);
    cD = reshape(cD, detail_length, detail_length);
    
    x = idwt2(cA, cH, cV, cD, 'db1');
    x = x(:);
end
