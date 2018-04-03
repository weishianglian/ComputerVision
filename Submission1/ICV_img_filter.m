function filtered_img = ICV_img_filter(img, kernel)
    %% Filtering the input image by given kernel
    % height, width and dimension of the image
    [height, width, dimen] = size(img);
    
    % loading the kernel and it's height and width
    Ma = kernel;
    [kh, kw] = size(Ma);
    sr = round((kh+1)/2);
    sc = round((kw+1)/2);
    
    % Adding up the sum of each value in kernel
    total = sum(sum(Ma,1));
    if (total == 0) 
        total = 1; % make sure that denominator is not zero
    end

    % create the border pad from the image by the size of the kernel
    new_img = double(zeros(height+2*(sr-1), width+2*(sc-1), dimen));
    filtered_img = double(size(new_img));
    
    % put the original image into the middle of new image
    for i = sr:height+(sr-1)
        for j = sc:width+(sc-1)
            new_img(i, j, :) = img(i-(sr-1), j-(sc-1), :);
        end
    end
    
    % calcaulating the value for each pixel with the kernel
    summary = 0;
    x = 0;
    y = 0;
    for i = 1:height
        for j = 1:width
            for rgb = 1:3 % for RGB Channel
                for k = 1:kh
                    for l = 1:kw
                        summary = summary+new_img(i+x, j+y, rgb)*Ma(k,l);
                        y=y+1;
                    end
                    y=0;
                    x=x+1;
                end
                x=0;
                filtered_img(i, j, rgb) = (1/(total))*(summary);
                summary=0;
            end
        end
    end
    filtered_img = uint8(filtered_img);
end