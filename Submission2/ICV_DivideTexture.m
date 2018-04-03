function [blockImg, blockLBP, hisotgramLBP] = ICV_DivideTexture(img, blockSize, blockH, blockW, showImg)
%ICV_DIVIDETEXTURE divide the input (greyscale) image into equally sized non-overlapping windows
% and returns the feature descriptor for each window as distribution of LBP codes. 
% For each pixel in the window, compare the pixel to each of its 8 neighbours 
% (on its left-top, left-middle, left-bottom, right-top, etc.). 
% Follow the pixels in a counter-clockwise manner. 
% Compute the histogram over the window - as the frequency of each "number" occurring. 
% Normalize the histogram. The histogram is now a feature descriptor representing the window at hand
% 
% [blockImg, blockLBP, hisotgramLBP] = ICV_DIVIDETEXTURE(img, blockSize, blockH, blockW, showImg)
% img: the source image
% blocksize: the block square length 
% blockH: the vertical index of divdied image
% blockW: the horizontal index of divdied image
% showImg: The switch of showing the results in figure
% 
% blockImg: the image divided by block
% blockLBP: the LBP of the divided image
% hisotgramLBP: the histogram from LBP

    % convert colourful image to gray image
    [grayImg, ~, ~] = ICV_GrayImageThreshold(img);
    
    % initialise the containers to store borderless block image and LBP
    pixelNum = (blockSize-2)^2;
    blockImg = zeros(blockSize-2);
    blockLBP = zeros(blockSize-2);
    
    % loop for finding LBP from block image and ignore the border pixels
    pixelCount = 0;
    for imW = (blockW-1)*blockSize+2:blockW*blockSize-1 
        for imH = (blockH-1)*blockSize+2:blockH*blockSize-1
            pixelCount = pixelCount+1;
            blockImg(pixelCount) = grayImg(imH, imW);

            % compute LBP from left-top and follow in counter-clockwise manner
            neighbourM = zeros(1, 9);
            neighbourCount = 0;
            for m = -1:1 % neighbour row index
                for n = -1:1 % neighbour column index
                    neighbourCount = neighbourCount+1;
                    if grayImg(imH+m, imW+n) > grayImg(imH, imW)
                        neighbourM(neighbourCount) = 1;
                    end
                end
            end
            neighbourM(5) = []; % remove the element which is compared to itself
            blockLBP(pixelCount) = sum(neighbourM.*(2.^(7:-1:0))); % convert binary to decimal
        end
    end
    
    % generate the LBP histogram
    hisotgramLBP = zeros(1, 256);
    for val = 0:255
        hisotgramLBP(val+1) = length(blockLBP(blockLBP == val));
    end
    hisotgramLBP = hisotgramLBP/pixelNum; % normailise the histogram
    
    % show the generated results
    if showImg
        figure;
        subplot(2,2,1); imshow(uint8(blockImg)); title('Input Image');
        subplot(2,2,2); imshow(uint8(blockLBP)); title('LBP Image');
        subplot(2,2,3:4); bar(0:255, hisotgramLBP); title('LBP Histogram');
    end

end