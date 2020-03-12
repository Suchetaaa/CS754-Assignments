clc;
clear;
addpath(genpath('l1_ls_matlab'));

%% (a) Loading image and taking radon transform

num_angles = 18;
image_size = 218;
brain_slice = get_slice(51);
random_angles = randsample(180, num_angles) - 1;
projections = radon(brain_slice, random_angles);

%% (a) Filtered Back-projection

brain_slice_recon_iradon = iradon(projections, random_angles, ...
    'linear', 'Ram-Lak', 1, image_size);

rrmse = sqrt(sum((brain_slice - brain_slice_recon_iradon).^2, 'all')) / ...
    sqrt(sum((brain_slice).^2, 'all'))

figure
subplot(1, 2, 1)
imshow(brain_slice)
title("Orig. 1")
subplot(1, 2, 2)
imshow(brain_slice_recon_iradon)
title("Recon. 1 (FBP)")

%% (b) Using non-coupled compressive sensing - 2D DCT basis

brain_slice_recon = reconstruct_single_slice(@dct2, @idct2, image_size, ...
    random_angles, projections);

rrmse = sqrt(sum((brain_slice - brain_slice_recon).^2, 'all')) / ...
    sqrt(sum((brain_slice).^2, 'all'))

figure
subplot(1, 2, 1)
imshow(brain_slice)
title("Orig. 1")
subplot(1, 2, 2)
imshow(brain_slice_recon)
title("Recon. 1 (DCT)")

%% (b) Using non-coupled compressive sensing - 2D Haar Wavelet basis

brain_slice_recon = reconstruct_single_slice(@haart2_custom, ...
    @ihaart2_custom, image_size, random_angles, projections);

rrmse = sqrt(sum((brain_slice - brain_slice_recon).^2, 'all')) / ...
    sqrt(sum((brain_slice).^2, 'all'))

figure
subplot(1, 2, 1)
imshow(brain_slice)
title("Orig. 1")
subplot(1, 2, 2)
imshow(brain_slice_recon)
title("Recon. 1 (Haar)")

%% (b) Repeating above for second slice

clc;
clear;

num_angles = 18;
image_size = 218;
brain_slice = get_slice(51);
random_angles = randsample(180, num_angles) - 1;
projections = radon(brain_slice, random_angles);

brain_slice_recon_iradon = iradon(projections, random_angles, ...
    'linear', 'Ram-Lak', 1, image_size);

rrmse = sqrt(sum((brain_slice - brain_slice_recon_iradon).^2, 'all')) / ...
    sqrt(sum((brain_slice).^2, 'all'))

figure
subplot(1, 2, 1)
imshow(brain_slice)
title("Orig. 2")
subplot(1, 2, 2)
imshow(brain_slice_recon_iradon)
title("Recon. 2 (FBP)")

brain_slice_recon = reconstruct_single_slice(@dct2, @idct2, image_size, ...
    random_angles, projections);

rrmse = sqrt(sum((brain_slice - brain_slice_recon).^2, 'all')) / ...
    sqrt(sum((brain_slice).^2, 'all'))

figure
subplot(1, 2, 1)
imshow(brain_slice)
title("Orig. 2")
subplot(1, 2, 2)
imshow(brain_slice_recon)
title("Recon. 2 (DCT)")

brain_slice_recon = reconstruct_single_slice(@haart2_custom, ...
    @ihaart2_custom, image_size, random_angles, projections);

rrmse = sqrt(sum((brain_slice - brain_slice_recon).^2, 'all')) / ...
    sqrt(sum((brain_slice).^2, 'all'))

figure
subplot(1, 2, 1)
imshow(brain_slice)
title("Orig. 2")
subplot(1, 2, 2)
imshow(brain_slice_recon)
title("Recon. 2 (Haar)")


%% (c) Loading image and taking radon transform for 2 slice coupled recon.

clc;
clear;

num_angles = 18;
image_size = 218;

brain_slice(:,:,1) = get_slice(51);
brain_slice(:,:,2) = get_slice(52);

random_angles(:,:,1) = randsample(180, num_angles) - 1;
random_angles(:,:,2) = randsample(180, num_angles) - 1;

projections(:,:,1) = radon(brain_slice(:,:,1), random_angles(:,:,1));
projections(:,:,2) = radon(brain_slice(:,:,2), random_angles(:,:,2));

projection_size = size(projections, 1);

%% (c) Using coupled compressive sensing - 2D DCT basis - 2 slices

brain_slice_recon = reconstruct_two_slices(@dct2, @idct2, image_size, ...
    random_angles, projections);

rrmse = sqrt(sum((brain_slice - brain_slice_recon).^2, 'all')) / ...
    sqrt(sum((brain_slice).^2, 'all'))

figure
subplot(2, 2, 1)
imshow(squeeze(brain_slice(:,:,1)))
title("Orig. 1 ")
subplot(2, 2, 2)
imshow(squeeze(brain_slice(:,:,2)))
title("Orig. 2 ")
subplot(2, 2, 3)
imshow(squeeze(brain_slice_recon(:,:,1)))
title("Recon. 1 (DCT)")
subplot(2, 2, 4)
imshow(squeeze(brain_slice_recon(:,:,2)))
title("Recon. 2 (DCT)")

%% (c) Using coupled compressive sensing - 2D Haar Wavelet basis - 2 slices

brain_slice_recon = reconstruct_two_slices(@haart2_custom, ...
    @ihaart2_custom, image_size, random_angles, projections);

rrmse = sqrt(sum((brain_slice - brain_slice_recon).^2, 'all')) / ...
    sqrt(sum((brain_slice).^2, 'all'))

figure
subplot(2, 2, 1)
imshow(squeeze(brain_slice(:,:,1)))
title("Orig. 1 ")
subplot(2, 2, 2)
imshow(squeeze(brain_slice(:,:,2)))
title("Orig. 2 ")
subplot(2, 2, 3)
imshow(squeeze(brain_slice_recon(:,:,1)))
title("Recon. 1 (Haar)")
subplot(2, 2, 4)
imshow(squeeze(brain_slice_recon(:,:,2)))
title("Recon. 2 (Haar)")

%% (c) Loading image and taking radon transform for 3 slice coupled recon.

clc;
clear;

num_angles = 18;
image_size = 218;

brain_slice(:,:,1) = get_slice(51);
brain_slice(:,:,2) = get_slice(52);
brain_slice(:,:,3) = get_slice(53);

random_angles(:,:,1) = randsample(180, num_angles) - 1;
random_angles(:,:,2) = randsample(180, num_angles) - 1;
random_angles(:,:,3) = randsample(180, num_angles) - 1;

projections(:,:,1) = radon(brain_slice(:,:,1), random_angles(:,:,1));
projections(:,:,2) = radon(brain_slice(:,:,2), random_angles(:,:,2));
projections(:,:,3) = radon(brain_slice(:,:,3), random_angles(:,:,3));

projection_size = size(projections, 1);

%% (c) Using coupled compressive sensing - 2D DCT basis - 3 slices

brain_slice_recon = reconstruct_three_slices(@dct2, @idct2, image_size, ...
    random_angles, projections);

rrmse = sqrt(sum((brain_slice - brain_slice_recon).^2, 'all')) / ...
    sqrt(sum((brain_slice).^2, 'all'))

figure
subplot(2, 3, 1)
imshow(squeeze(brain_slice(:,:,1)))
title("Orig. 1 ")
subplot(2, 3, 2)
imshow(squeeze(brain_slice(:,:,2)))
title("Orig. 2 ")
subplot(2, 3, 3)
imshow(squeeze(brain_slice(:,:,3)))
title("Orig. 3 ")
subplot(2, 3, 4)
imshow(squeeze(brain_slice_recon(:,:,1)))
title("Recon. 1 (DCT)")
subplot(2, 3, 5)
imshow(squeeze(brain_slice_recon(:,:,2)))
title("Recon. 2 (DCT)")
subplot(2, 3, 6)
imshow(squeeze(brain_slice_recon(:,:,3)))
title("Recon. 3 (DCT)")

%% (c) Using coupled compressive sensing - 2D Haar Wavelet basis - 3 slices

brain_slice_recon = reconstruct_three_slices(@haart2_custom, ...
    @ihaart2_custom, image_size, random_angles, projections);

rrmse = sqrt(sum((brain_slice - brain_slice_recon).^2, 'all')) / ...
    sqrt(sum((brain_slice).^2, 'all'))

figure
subplot(2, 3, 1)
imshow(squeeze(brain_slice(:,:,1)))
title("Orig. 1 ")
subplot(2, 3, 2)
imshow(squeeze(brain_slice(:,:,2)))
title("Orig. 2 ")
subplot(2, 3, 3)
imshow(squeeze(brain_slice(:,:,3)))
title("Orig. 3 ")
subplot(2, 3, 4)
imshow(squeeze(brain_slice_recon(:,:,1)))
title("Recon. 1 (DCT)")
subplot(2, 3, 5)
imshow(squeeze(brain_slice_recon(:,:,2)))
title("Recon. 2 (Haar)")
subplot(2, 3, 6)
imshow(squeeze(brain_slice_recon(:,:,3)))
title("Recon. 3 (Haar)")
