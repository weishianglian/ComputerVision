function skewed_img = ICV_img_skew(img, degree)
    %% Adjusting origianl image
    % height and width of the image
    [height, width, ~] = size(img);
    
    % expanding the original image size by skewing width and putting it on the middle position
    pad_img = uint8(zeros(height, width+ceil(height*tand(degree)), 3));
    start_x = 0;
    start_y = ceil(height*tand(degree));
    for x = 1:height
        for y = 1:width
            pad_img(x + start_x, y + start_y, :) = img(x, y, :);
        end
    end
    
    %% Creating new image
    % creating the new matrix by skewing width to store the skewed image
    skewed_img = uint8(zeros(height, width+ceil(height*tand(degree)), 3));
    [new_h, new_w, ~] = size(skewed_img);
    
    %% Translating and rotating the image
     % adding translation amounts to the coordinates of the point
    sx = 0;
    sy = tand(degree);
    
    % trasnformation matrix for skewing
    Mshear = [1 sx 0; sy 1 0; 0 0 1];
    
    % skewing the image, using mapping
    for row = 1:new_h
        for col = 1:new_w
            % skewing the image
            pos = Mshear*[row, col, 1]';
            new_row = ceil(pos(1));
            new_col = ceil(pos(2));
            
            % fill skewed image using original image pixel colors
            if row>=1 && col>=1 && row<=new_h && col<=new_w && new_row>=1 && new_col>=1 && new_row<=new_h && new_col<=new_w
                skewed_img(row, col, :) = pad_img(new_row, new_col, :);
            end
        end
    end

end
