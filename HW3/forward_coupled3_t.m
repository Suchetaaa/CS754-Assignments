classdef forward_coupled3_t
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
        function obj = forward_coupled3_t(transform_function, image_size, ...
                random_angles, projection_size)
            %FORWARD_COUPLED_T Construct an instance of this class
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
            w_len = size(w,1);
            w1 = w(1:w_len/3);
            w2 = w(w_len/3+1:2*w_len/3);
            w3 = w(2*w_len/3+1:end);
            
            w1_radon = reshape(w1, At.projection_size, At.num_angles);
            w2_radon = reshape(w2, At.projection_size, At.num_angles);
            w3_radon = reshape(w3, At.projection_size, At.num_angles);
            
            w1_dense = iradon(w1_radon, At.random_angles(:,:,1), ...
                'linear', 'Ram-Lak', 1, At.image_size);
            w2_dense = iradon(w2_radon, At.random_angles(:,:,2), ...
                'linear', 'Ram-Lak', 1, At.image_size);
            w3_dense = iradon(w3_radon, At.random_angles(:,:,3), ...
                'linear', 'Ram-Lak', 1, At.image_size);
            
            w1_sparse = At.transform_function(w1_dense);
            w2_sparse = At.transform_function(w2_dense);
            w3_sparse = At.transform_function(w3_dense);
            
            product = [w1_sparse(:)+w2_sparse(:)+w3_sparse(:); ...
                w2_sparse(:); w3_sparse(:)];
        end
    end
end

