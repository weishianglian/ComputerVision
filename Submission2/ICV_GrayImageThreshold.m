function [grayImg, grayHist, threshold] = ICV_GrayImageThreshold(img)
%ICV_GRAYIMAGETHRESHOLD Convert a RGB image to a grayscale image and
% generate its histogram and threshold by Otsu's method
%
% [grayImg, grayHist, threshold] = ICV_GRAYIMAGETHRESHOLD(img)
% img: the source image
% 
% grayImg: the image converted to grayscale
% grayHist: calculate the histogram about the grayscale image
% threshold: the threshold of the grayscale image
    %% convert image from rgb to grayscale
    grayWeight = [0.2989, 0.5870, 0.1140];
    grayImg = zeros(size(img(:,:,1)));
    for c = 1:3
        grayImg = grayImg + double(img(:, :, c))*grayWeight(c);
    end
    grayImg = uint8(grayImg);

    %% generate histogram from grayscale image
    grayHist = zeros(1, 256);
    for b = 0:255
        grayHist(b+1) = length(grayImg(grayImg == b));
    end

    %% find the threshold from bimodal by Otsu's method
    % maxmising the variance between groups can find the threshold
    varBetween = zeros(1,256);
    p = grayHist/sum(grayHist); % probability of each element
    for t = 1:256
        w1 = sum(p(1:t)); % the weight of group1
        w2 = sum(p(t+1:end)); % the weight of group2
        mu = sum((1:256) * p(1:end)'); % overall mean
        mu1 = sum((1:t) * p(1:t)')/w1; % group1 mean
        mu2 = sum((t+1:256) * p(t+1:256)')/w2; % group2 mean
        varBetween(t) = w1*(mu1-mu)^2+w2*(mu2-mu)^2; % variance between two groups
    end
    [~, threshold] = max(varBetween);
end