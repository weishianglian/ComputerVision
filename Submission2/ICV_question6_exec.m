close all; clear all;
%% Coursework 6) a)
% load all of images from dataset
faceImg1 = imread('DatasetA/face-1.jpg');
faceImg2 = imread('DatasetA/face-2.jpg');
faceImg3 = imread('DatasetA/face-3.jpg');
carImg1 = imread('DatasetA/car-1.jpg');
carImg2 = imread('DatasetA/car-2.jpg');
carImg3 = imread('DatasetA/car-3.jpg');

% divide input (greyscale) image into equally sized non-overlapping windows
% and return the feature descriptor for each window
[blockImg, blockLBP, hisotgramLBP] = ICV_DivideTexture(carImg1, 64, 1, 1, true);
imwrite(uint8(blockImg), 'results/q6/blockImg1.png');
imwrite(uint8(blockLBP), 'results/q6/blockLBP1.png');
figure('visible', 'off'); bar(0:255, hisotgramLBP); saveas(gcf, 'results/q6/hisotgramLBP1.png');
[blockImg, blockLBP, hisotgramLBP] = ICV_DivideTexture(carImg1, 64, 2, 2, true);
imwrite(uint8(blockImg), 'results/q6/blockImg2.png');
imwrite(uint8(blockLBP), 'results/q6/blockLBP2.png');
figure('visible', 'off'); bar(0:255, hisotgramLBP); saveas(gcf, 'results/q6/hisotgramLBP2.png');
[blockImg, blockLBP, hisotgramLBP] = ICV_DivideTexture(carImg1, 64, 3, 3, true);
imwrite(uint8(blockImg), 'results/q6/blockImg3.png');
imwrite(uint8(blockLBP), 'results/q6/blockLBP3.png');
figure('visible', 'off'); bar(0:255, hisotgramLBP); saveas(gcf, 'results/q6/hisotgramLBP3.png');

%% Coursework 6) b)
% combine several local descriptions into a global description
[wholeImg, wholeLBP, wholeHisotgram] = ICV_WholeTexture(carImg1, 64, true);
imwrite(uint8(wholeImg), 'results/q6/wholeImg1.png');
imwrite(uint8(wholeLBP), 'results/q6/wholeLBP1.png');
figure('visible', 'off'); bar(0:255, wholeHisotgram); saveas(gcf, 'results/q6/wholeHisotgram1.png');
[wholeImg, wholeLBP, wholeHisotgram] = ICV_WholeTexture(faceImg1, 64, true);
imwrite(uint8(wholeImg), 'results/q6/wholeImg2.png');
imwrite(uint8(wholeLBP), 'results/q6/wholeLBP2.png');
figure('visible', 'off'); bar(0:255, wholeHisotgram); saveas(gcf, 'results/q6/wholeHisotgram2.png');

%% Coursework 6) c)
% set the images into a list (4-D matrix) to be compared with the reference images
imgList = zeros(256, 256, 3, 4);
imgList(:,:,:,1) = faceImg2;
imgList(:,:,:,2) = faceImg3;
imgList(:,:,:,3) = carImg2;
imgList(:,:,:,4) = carImg3;

% classify the images using the global descriptor
ICV_FaceCarClassfication(imgList, 64, faceImg1, carImg1);
saveas(gcf, 'results/q6/FaceCarClassfication_64.png');
%% Coursework 6) d) e)
% adjust (invcrease or decrease) the window size and perform classification
ICV_FaceCarClassfication(imgList, 16, faceImg1, carImg1);
saveas(gcf, 'results/q6/FaceCarClassfication_16.png');
ICV_FaceCarClassfication(imgList, 32, faceImg1, carImg1);
saveas(gcf, 'results/q6/FaceCarClassfication_32.png');
ICV_FaceCarClassfication(imgList, 128, faceImg1, carImg1);
saveas(gcf, 'results/q6/FaceCarClassfication_128.png');
ICV_FaceCarClassfication(imgList, 256, faceImg1, carImg1);
saveas(gcf, 'results/q6/FaceCarClassfication_256.png');