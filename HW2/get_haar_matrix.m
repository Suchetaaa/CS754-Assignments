function haar_matrix = get_haar_matrix(n)
    haar_matrix = zeros(n^2, n^2);
    for x = 1:n^2
        curr_image = zeros(n^2, 1);
        curr_image(x, 1) = 1;
        curr_dwt = get_dwt2(curr_image(:));
        haar_matrix(1:end,x) = curr_dwt;
    end
end

