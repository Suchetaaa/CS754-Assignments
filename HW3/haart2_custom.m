function haart = haart2_custom(x)
%HAART2_CUSTOM Haar Tranform 2D 
%   Returns a 2D matrix which follows the usual haar wavelet representation
%   arrangement
    [a, h, v, d] = haart2(x);
    levels = numel(h);
    haart = a;
    for level = levels:-1:1
        haart = [haart,    v{level}; 
                 h{level}, d{level}];
    end
end

