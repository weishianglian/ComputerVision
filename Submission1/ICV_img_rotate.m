function rotated_img = ICV_img_rotate(img, degree)
    %% Adjusting origianl image
    % height and width of the image
    [height, width, ~] = size(img);
    % diagonal of the image
    diagonal = ceil(sqrt(height^2 + width^2));
    
    % expanding the original image size by diagonal and putting it on the middle position
    pad_img = uint8(zeros(diagonal, diagonal, 3));
    start_x = ceil((diagonal-height)/2);
    start_y = ceil((diagonal-width)/2);
    for x = 1:height
        for y = 1:width
            pad_img(x + start_x, y + start_y, :) = img(x, y, :);
        end
    end
    
    %% Creating new image
    % creating the new matrix by diagonal to store the rotated image
    rotated_img = uint8(zeros(diagonal, diagonal, 3));
    [new_h, new_w, ~] = size(rotated_img);
    
    % finding out the center of the image
    new_midx = ceil((new_h+1)/2);
    new_midy = ceil((new_w+1)/2);
    
    % adding translation amounts to the coordinates of the point
    tx = new_midx;
    ty = new_midy;
    new_tx = new_midx;
    new_ty = new_midy;
    
    %% Translating and rotating the image
    % trasnformation matrix for translating and rotating
    Mtranslate1 = [1 0 -tx; 0 1 -ty; 0 0 1];
    Mtranslate2 = [1 0 new_tx; 0 1 new_ty; 0 0 1];
    Mrotate = [cosd(degree) -sind(degree) 0; sind(degree) cosd(degree) 0; 0 0 1];
    
    % translating and rotating the image, using mapping
    for row = 1:new_h
        for col = 1:new_w
            % translating image to rotataion center and rotating the image,
            % and translating image to the original position after rotating
            pos = Mtranslate2*Mrotate*Mtranslate1*[row, col, 1]';
            new_row = ceil(pos(1));
            new_col = ceil(pos(2));
            
            % fill rotated image using original image pixel colors
            if row>=1 && col>=1 && row<=new_h && col<=new_w && new_row>=1 && new_col>=1 && new_row<=new_h && new_col<=new_w
                rotated_img(row, col, :) = pad_img(new_row, new_col, :);
            end
        end
    end

end