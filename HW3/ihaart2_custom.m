function ihaart = ihaart2_custom(x)
%IHAART2_CUSTOM Haar Inverse Tranform 2D 
%   Returns a 2D matrix based on x that follows the usual haar wavelet 
%   representation arrangement  
    levels = floor(log2(min(size(x)/2)));
    h = {};
    v = {};
    d = {};
    a_curr = x;

    for level = 1:levels
        a_height = ceil(size(a_curr, 1)/2);
        a_width = ceil(size(a_curr, 2)/2);
        v{level} = a_curr(1:a_height, a_width+1:end);
        h{level} = a_curr(a_height+1:end, 1:a_width);
        d{level} = a_curr(a_height+1:end, a_width+1:end);
        a_curr = a_curr(1:a_height, 1:a_width);
    end
    ihaart = ihaart2(a_curr, h, v, d);
end

