function K = ICV_hist_intersection(A, B)
    %% Calculating histogram intersection
    % accroding to matrices columns, deciding how many values should be returned
    a = size(A, 2); b = size(B, 2);
    % creating return matrix
    K = zeros(a, b);
    
    for i = 1:a
        % repeat copies of matrices to agree dimensions
        Va = repmat(A(:, i), 1, b);
        % finding out the minimum values and storing it in return matrix
        K(i,:) = sum(min(Va, B));
    end
end