clc;close all;clear all;

%% Rotating the image by degree
% loading image
img = imread('LIAN.png');
figure(1);imshow(img); imwrite(img, 'results/q1/myImg.png');

% Rotating the image by 30 degree
img1 = ICV_img_rotate(img, 30);
figure(2);imshow(img1); imwrite(img1, 'results/q1/30trans.png');

% Rotating the image by 60 degree
img2 = ICV_img_rotate(img, 60);
figure(3);imshow(img2); imwrite(img2, 'results/q1/60trans.png');

% Rotating the image by 120 degree
img3 = ICV_img_rotate(img, 120);
figure(4);imshow(img3); imwrite(img3, 'results/q1/120trans.png');

% Rotating the image by -50 degree
img4 = ICV_img_rotate(img, -50);
figure(5);imshow(img4); imwrite(img4, 'results/q1/m50trans.png');


%% Skewing the image by degree
% Skewing the image by 10 degree
img5 = ICV_img_skew(img, 10);
figure(6);imshow(img5); imwrite(img5, 'results/q1/10skew.png');

% Skewing the image by 40 degree
img6 = ICV_img_skew(img, 40);
figure(7);imshow(img6); imwrite(img6, 'results/q1/40skew.png');

% Skewing the image by 60 degree
img7 = ICV_img_skew(img, 60);
figure(8);imshow(img7); imwrite(img7, 'results/q1/60skew.png');

%% Rotating and skewing the image
% Rotating the image by 30 degree and skewing the image by 50 degree 
img_r = ICV_img_rotate(img, 20);
img_rs = ICV_img_skew(img_r, 50);
figure(9);imshow(img_rs); imwrite(img_rs, 'results/q1/rotate_skew.png');

% Skewing the image by 50 degree and rotating the image by 20 degree
img_s = ICV_img_skew(img, 50);
img_sr = ICV_img_rotate(img_s, 20);
figure(10);imshow(img_sr); imwrite(img_sr, 'results/q1/skew_rotate.png');