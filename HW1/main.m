%% CS 754 : Advanced Image Processing - Assignment 1
% Karan Taneja - 15D070022
%
% Sucheta Ravikanti- 1600401001
%

clear;
clc;
addpath(genpath('MMread'));

%% 2 (a) Loading 'cars' video

% A = mmread('./cars.avi');
time = 3; % number of frames
[complete_video, ~] = mmread('./cars.avi', 1:time, [], false, true);
[height, width, ~] = size(complete_video.frames(1).cdata);

cars_video = zeros(height, width, time);
for time_index = 1:time
    curr_frame = complete_video.frames(time_index).cdata;
    curr_frame = mean(curr_frame, 3);
    cars_video(:,:,time_index) = curr_frame;
end

height = 120; width = 240;
% clipping to a 120 x 240 part of video
cars_video = cars_video(end-height+1:end,end-width+1:end,:);
cars_video = cars_video/255;

%% 2 (b) Generating coded snapshot

% random code pattern 
prob = 0.5;
code_pattern = rand(size(cars_video)) < prob;
code_pattern = code_pattern;

% coded snapshot before adding noise
clean_coded_snapshot = sum(cars_video .* code_pattern, 3);

% adding noise to coded snapshot
noisy_coded_snapshot = clean_coded_snapshot + ...
    normrnd(0, 2/255, size(clean_coded_snapshot));

% showing coded snapshot
imshow(noisy_coded_snapshot/max(noisy_coded_snapshot, [], 'all'));
title("Noisy coded snapshot")
hold off

%% 2 (c) What are A, x, and b?

% x is the unknown original image of size H.W.T.
% b is the vector of measurements of size H.W (linearized)
% A is the measurement matrix of size (H.W) x (H.W.T)

%% 2 (d) (e)

patch_size = 8; patch_stride = patch_size/2;

% x is the unknown patch in image of size (patch_size.patch_size.T).
% b is the vector of measurements of size patch_size.patch_size
% (linearized)
% A is the measurement matrix of size (patch_size.patch_size) x ...
%                                     (patch_size.patch_size.T)

% padding noisy coded snapshot and code pattern
padded_height = height + 2 * patch_stride;
padded_width = width + 2 * patch_stride;
noisy_coded_snapshot_padded = zeros(padded_height, padded_width);
noisy_coded_snapshot_padded(patch_stride+1:end-patch_stride, ...
    patch_stride+1:end-patch_stride) = noisy_coded_snapshot(:,:);
code_pattern_padded = zeros(padded_height, padded_width, time, ...
    'like', code_pattern);
code_pattern_padded(patch_stride+1:end-patch_stride, ...
    patch_stride+1:end-patch_stride, :) = code_pattern(:,:,:);

% reconstruction holder
reconstruction_padded = zeros(padded_height, padded_width, time);

% loop patches over padded snapshot
for patch_idh = 1:patch_stride:padded_height-patch_stride
    for patch_idw = 1:patch_stride:padded_width-patch_stride
        fprintf("patch_idh = %d, patch_idw = %d \n", patch_idh, ...
            patch_idw);

        patch_code = code_pattern_padded(patch_idh:patch_idh+ ...
            patch_size-1, patch_idw:patch_idw+patch_size-1, :);
        patch_snapshot = noisy_coded_snapshot_padded(patch_idh: ...
            patch_idh+patch_size-1, patch_idw:patch_idw+patch_size-1);
        
        patch_recon = getPatchRecon(patch_code, patch_snapshot, 1e-7);
        reconstruction_padded(patch_idh:patch_idh+patch_size-1, ...
            patch_idw:patch_idw+patch_size-1, :) = ...
            reconstruction_padded(patch_idh:patch_idh+patch_size-1, ...
            patch_idw:patch_idw+patch_size-1, :) + patch_recon;
    end
end

%% averaging across overlapping pixels, and removing padding
reconstruction_padded = reconstruction_padded/4;
reconstruction = reconstruction_padded(patch_stride+1:end-patch_stride, ...
    patch_stride+1:end-patch_stride,:);

%% relative mean squared error (rmse)
mse = mean((cars_video - reconstruction).^2, 'all');
rmse = mse / mean(cars_video .^ 2, 'all');
fprintf("rmse = %0.4f \n", rmse);

%% plots
figure
imshow(reconstruction(:,:,1)/max(reconstruction, [], 'all'))
figure
imshow(reconstruction(:,:,2)/max(reconstruction, [], 'all'))
figure
imshow(reconstruction(:,:,3)/max(reconstruction, [], 'all'))



























