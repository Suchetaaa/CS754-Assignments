function image = get_slice(slice_number)
%GET_SLICE Summary of this function goes here
%   Detailed explanation goes here
    brain_slice = imread(sprintf('slice_%d.png', slice_number));
    brain_slice = padarray(brain_slice, [19, 0], 0, 'pre');
    brain_slice = padarray(brain_slice, [18, 0], 0, 'post');
    brain_slice = padarray(brain_slice, [0, 1], 0, 'pre');
    brain_slice = double(brain_slice*1.0)/255;
    image = brain_slice;
end

