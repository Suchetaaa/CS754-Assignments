function reconstruction = reconstruct_from_snapshot( ...
    noisy_coded_snapshot, code_pattern, patch_size, epsilon)

    [height,width,time] = size(code_pattern);
    patch_stride = patch_size/2;

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
%             fprintf("patch_idh = %d, patch_idw = %d \n", patch_idh, ...
%                 patch_idw);

            patch_code = code_pattern_padded(patch_idh:patch_idh+ ...
                patch_size-1, patch_idw:patch_idw+patch_size-1, :);
            patch_snapshot = noisy_coded_snapshot_padded(patch_idh: ...
                patch_idh+patch_size-1, patch_idw:patch_idw+patch_size-1);

            patch_recon = getPatchRecon(patch_code, patch_snapshot, epsilon);
            reconstruction_padded(patch_idh:patch_idh+patch_size-1, ...
                patch_idw:patch_idw+patch_size-1, :) = ...
                reconstruction_padded(patch_idh:patch_idh+patch_size-1, ...
                patch_idw:patch_idw+patch_size-1, :) + patch_recon;
        end
    end

    % averaging across overlapping pixels, and removing padding
    reconstruction_padded = reconstruction_padded/4;
    reconstruction = reconstruction_padded(patch_stride+1:end-patch_stride, ...
        patch_stride+1:end-patch_stride,:);
end

