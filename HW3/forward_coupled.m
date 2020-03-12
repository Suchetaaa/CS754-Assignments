classdef forward_coupled
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
        function obj = forward_coupled(transform_function, image_size, ...
                random_angles, projection_size)
            %FORWARD_COUPLED Construct an instance of this class
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
            w_len = size(w,1);
            w1 = w(1:w_len/2);
            w2 = w(w_len/2+1:end);
            
            w1_sparse = reshape(w1, A.image_size, A.image_size); 
            w2_sparse = reshape(w2, A.image_size, A.image_size);
            
            w1_dense = A.transform_function(w1_sparse);
            w2_dense = A.transform_function(w2_sparse);
            
            w1_radon1 = radon(w1_dense, A.random_angles(:,:,1)); 
            w1_radon2 = radon(w1_dense, A.random_angles(:,:,2)); 
            w2_radon2 = radon(w2_dense, A.random_angles(:,:,2)); 
            
            product = [w1_radon1(:); w1_radon2(:) + w2_radon2(:)];
        end
    end
end

