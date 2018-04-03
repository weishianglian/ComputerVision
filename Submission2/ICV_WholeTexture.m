function [wholeImg, wholeLBP, wholeHisotgram] = ICV_WholeTexture(img, blockSize, showImg)
% ICV_WHOLETEXTURE combinie several local descriptions into a global description
%
% [wholeImg, wholeLBP, wholeHisotgram] = ICV_WHOLETEXTURE(img, blockSize, showImg)
% img: the source image
% blocksize: the block square length 
% showImg: The switch of showing the results in figure
% 
% wholeImg: the whole image
% wholeLBP: the LBP of the whole image
% wholeHisotgram: the histogram from LBP
    
    % initialise the containers to store whole image, LBP and histogram
    [h, w, ~] = size(img);
    wholeImg = zeros(h, w);
    wholeLBP = zeros(h, w);
    wholeHisotgram = zeros(1, 256);
    
    % the vertical and horizontal part of divdied image
    partH = h/blockSize;
    partW = w/blockSize;
    
    % loop for every block
    for blockH = 1:partH
        for blockW = 1:partW
            % handle it as block image and combine them into a whole image
            [blockImg, blockLBP, hisotgramLBP] = ICV_DivideTexture(img, blockSize, blockH, blockW, false);
            wholeImg((blockH-1)*blockSize+2:blockH*blockSize-1, (blockW-1)*blockSize+2:blockW*blockSize-1) = blockImg;
            wholeLBP((blockH-1)*blockSize+2:blockH*blockSize-1, (blockW-1)*blockSize+2:blockW*blockSize-1) = blockLBP;
            wholeHisotgram = wholeHisotgram + hisotgramLBP;
        end
    end
    wholeHisotgram = wholeHisotgram/(partH*partW); % divided by the number of the pars
    
    % show the generated results
    if showImg
        figure;
        subplot(2,2,1); imshow(uint8(wholeImg)); title('Input Image');
        subplot(2,2,2); imshow(uint8(wholeLBP)); title('LBP Image');
        subplot(2,2,3:4); bar(0:255, wholeHisotgram); title('LBP Histogram');
    end

end