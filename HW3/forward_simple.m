classdef forward_simple
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
        function obj = forward_simple(transform_function, image_size, ...
                random_angles, projection_size)
            %FORWARD_SIMPLE Construct an instance of this class
            %   Detailed explanation goes here
            obj.transform_function = transform_function;
            obj.image_size = image_size;
            obj.random_angles = random_angles;
            obj.num_angles = size(random_angles, 1);
            obj.projection_size = projection_size;
        end
        
        function product = mtimes(A, w)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            w_sparse = reshape(w, A.image_size, A.image_size); 
            w_dense = A.transform_function(w_sparse);
            w_radon = radon(w_dense, A.random_angles); 
            product = w_radon(:);
        end
    end
end

