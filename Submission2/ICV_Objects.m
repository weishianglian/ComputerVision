function [originDiff, thresDiff] = ICV_Objects(ref, img, showImg)
%ICV_OBJECTS Perform pixel-by-pixel frame differencing between reference
% and target frames. Furthermore, according to threshold to apply
% classification.
% 
% [originDiff, thresDiff] = ICV_OBJECTS(ref, img, threshold)
% ref: The reference frame.
% img: The target frame.
% showImg: The switch of showing the results in figure.
% 
% originDiff: The difference between reference and target frame.
% thresDiff: The difference filtered by classification threshold between reference and target frame.
    
    % get frame pixels difference by matrix subtraction
    diff = abs(double(ref)-double(img));
    originDiff = uint8(diff);
    
    % add up RGB values and filter every elemnet with threshold
    [thresDiff, ~, threshold] = ICV_GrayImageThreshold(originDiff);
    thresDiff(thresDiff > threshold) = 255;
    thresDiff(thresDiff < threshold) = 0;
    thresDiff = uint8(thresDiff);
    
    % show the results with reference, target, difference and threshold diiference frames
    if showImg
        figure;
        subplot(2, 2, 1); imshow(ref); title('Reference Frame');
        subplot(2, 2, 2); imshow(img); title('Target Frame');
        subplot(2, 2, 3); imshow(originDiff); title('Object');
        subplot(2, 2, 4); imshow(thresDiff); title('Threshold Object');
    end

end