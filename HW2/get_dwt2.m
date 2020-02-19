function theta = get_dwt2(x)
    [recon_size, ~] = size(x);
    image_size = sqrt(recon_size);
    x_2d = reshape(x, image_size, image_size);
    [cA, cH, cV, cD] = dwt2(x_2d, 'db1');
    theta = [cA(:); cH(:); cV(:); cD(:)];    
end
