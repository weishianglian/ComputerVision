function [] = ICV_FaceCarClassfication(imgList, blockSize, faceImg, carImg)
%ICV_FACECARCLASSFICATION Implement a classification process (simple histogram similarities) 
% to classify the images using the global descriptor,
% which is categorised into two categories: face images and car images.
% 
% []=ICV_FaceCarClassfication(imgList, blockSize, faceImg, carImg)
% imgList: the image list (4-D matrix)
% blocksize: the block square length 
% faceImg: the reference face image
% carImg: the reference car image

    % get face and car histogram from the reference source
    [faceImg, ~, faceHisotgram] = ICV_WholeTexture(faceImg, blockSize, false);
    [carImg, ~, carHisotgram] = ICV_WholeTexture(carImg, blockSize, false);
    
    % show the reference images (face, car)
    figure('Name', ['Block Size: ', num2str(blockSize)]);
    subplot(2,4,1:2); imshow(uint8(faceImg)); title('Reference Face Image');
    subplot(2,4,3:4); imshow(uint8(carImg)); title('Reference Car Image');
    
    % loop for comparing each images from the list with the reference images
    [~, ~, ~, imgNum] = size(imgList);
    for n = 1:imgNum
        img = imgList(:,:,:,n);
        [wholeImg, ~, wholeHisotgram] = ICV_WholeTexture(uint8(img), blockSize, false);
        subplot(2,4,n+4); imshow(uint8(wholeImg));
        % accroding to simple histogram similarities, choose which object is more similar
        if sum(abs(wholeHisotgram - faceHisotgram)) <= sum(abs(wholeHisotgram - carHisotgram))
            title('This is a face');
        else
            title('This is a car');
        end
    end
end