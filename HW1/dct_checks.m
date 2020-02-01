%% 1d DCT

a = rand(10, 1);
dct_matrix = dctmtx(10);
dct_guess = dct_matrix * a;

dct_matlab = dct(a);

error = sum((dct_guess - dct_matlab).^2);
error

a_recon = dct_matrix' * dct_guess;

error = sum((a - a_recon).^2);
error


%% 2d DCT

a = rand(10, 10);
a_linear = a(:);
dct_matrix = kron(dctmtx(10), dctmtx(10));
dct_guess = dct_matrix * a_linear;
dct_guess = reshape(dct_guess, size(a));

dct_matlab = dct2(a);

error = sum((dct_guess - dct_matlab).^2, 'all');
error

a_recon = dct_matrix' * dct_guess(:);

error = sum((a(:) - a_recon).^2);
error

%% 2d DCT with time points

a = rand(10, 10, 3);
a_linear = a(:);
dct_matrix = kron(eye(3), kron(dctmtx(10), dctmtx(10)));
dct_guess = dct_matrix * a_linear;

dct_matlab(:,:,1) = dct2(a(:,:,1));
dct_matlab(:,:,2) = dct2(a(:,:,2));
dct_matlab(:,:,3) = dct2(a(:,:,3));

error = sum((dct_guess - dct_matlab(:)).^2, 'all');
error

a_recon = dct_matrix' * dct_guess(:);

error = sum((a(:) - a_recon).^2);
error
