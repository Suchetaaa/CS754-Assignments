function [noisy_coded_snapshot,code_pattern] = ...
    create_noisy_coded_snapshot(video,noise)

    % random code pattern 
    prob = 0.5;
    code_pattern = rand(size(video)) < prob;

    % coded snapshot before adding noise
    clean_coded_snapshot = sum(video .* code_pattern, 3);

    % adding noise to coded snapshot
    noisy_coded_snapshot = clean_coded_snapshot + ...
        normrnd(0, noise, size(clean_coded_snapshot));

end

