classdef forward_simple_t
    %FORWARD_MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        transform_function
        image_size
        num_angles
        random_angles
        projection_size
    end
    
    methods
        function obj = forward_simple_t(transform_function, image_size, ...
                random_angles, projection_size)
            %FORWARD_SIMPLE_T Construct an instance of this class
            %   Detailed explanation goes here
            obj.transform_function = transform_function;
            obj.image_size = image_size;
            obj.random_angles = random_angles;
            obj.num_angles = size(random_angles, 1);
            obj.projection_size = projection_size;
        end
        
        function product = mtimes(At, w)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            w_radon = reshape(w, At.projection_size, At.num_angles);
            w_dense = iradon(w_radon, At.random_angles, 'linear', ...
                'Ram-Lak', 1, At.image_size);
            w_sparse = At.transform_function(w_dense);
            product = w_sparse(:);
        end
    end
end

