function [ranage, mr, mg, mb] = ICV_img_histogram(img)
    %% Analysing image information
    % height and width of the image
    [height,  width, ~] = size(img);
    
    % dividing image into three colour channels
    imgR = img(:,:,1);
    imgG = img(:,:,2);
    imgB = img(:,:,3);
    
    % making the channel to one row matrix for statistic
    rs = imgR(1:end);
    gs = imgG(1:end);
    bs = imgB(1:end);
    
    % RGB values ranage
    ranage = (0:255)';
    
    % martices for calculating RGB value times
    mr = zeros(256,1);
    mg = zeros(256,1);
    mb = zeros(256,1);
    
    % calculating RGB value times from three colour channels
    for x=1:height*width
        for y = 1:256
            if (rs(x) == y-1) 
                mr(y) = mr(y)+1;
            end
            if (gs(x) == y-1) 
                mg(y) = mg(y)+1;
            end
            if (bs(x) == y-1) 
                mb(y) = mb(y)+1;
            end
        end
    end
end