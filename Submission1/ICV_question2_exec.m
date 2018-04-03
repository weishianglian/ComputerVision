clc;close all;clear all;

%% Filtering the image by 3x3 kernel
% loading image
img = imread('DatasetA/car-1.jpg');
figure(1);imshow(img); imwrite(img, 'results/q2/original.png');

% creating a convolution kernel that enables the computation of average intensity value in 3*3 region for each pixel
Ma = [1 1 1; 1 1 1; 1 1 1];
result1 = ICV_img_filter(img, Ma);
figure(2);imshow(result1); imwrite(result1, 'results/q2/averaged.png');

% using the kernel A and applying the filtering function
Ka = [1 2 1; 2 4 2; 1 2 1];
result2 = ICV_img_filter(img, Ka);
figure(3);imshow(result2); imwrite(result2, 'results/q2/kernelA.png');

% using the kernel B and applying the filtering function
Kb = [0 1 0; 1 -4 1; 0 1 0];
result3 = ICV_img_filter(img, Kb);
figure(4);imshow(result3); imwrite(result3, 'results/q2/kernelB.png');

% using the kernel A followed by kernel A and applying the filtering function
result4 = ICV_img_filter(ICV_img_filter(img, Ka), Ka);
figure(5);imshow(result4); imwrite(result4, 'results/q2/kernelAbyA.png');

% using the kernel A followed by kernel B and applying the filtering function
result5 = ICV_img_filter(ICV_img_filter(img, Ka), Kb);
figure(6);imshow(result5); imwrite(result5, 'results/q2/kernelAbyB.png');

% using the kernel B followed by kernel A and applying the filtering function
result6 = ICV_img_filter(ICV_img_filter(img, Kb), Ka);
figure(7);imshow(result6); imwrite(result6, 'results/q2/kernelBbyA.png');

%% Filtering the image by 5x5 kernel
% extending the kernel A to 5x5
Ka55 = zeros(5); Ka55(2:4,2:4) = Ka;
% extending the kernel B to 5x5
Kb55 = zeros(5); Kb55(2:4,2:4) = Kb;

% using the kernel A followed by kernel A and applying the filtering function
result7 = ICV_img_filter(ICV_img_filter(img, Ka55), Ka55);
figure(8);imshow(result7); imwrite(result7, 'results/q2/kernelAbyA5x5.png');

% using the kernel A followed by kernel B and applying the filtering function
result8 = ICV_img_filter(ICV_img_filter(img, Ka55), Kb55);
figure(9);imshow(result8); imwrite(result8, 'results/q2/kernelAbyB5x5.png');

% using the kernel B followed by kernel A and applying the filtering function
result9 = ICV_img_filter(ICV_img_filter(img, Kb55), Ka55);
figure(10);imshow(result9); imwrite(result9, 'results/q2/kernelBbyA5x5.png');

%% Filtering the image by 7x7 kernel
% extending the kernel A to 7x7
Ka77 = zeros(7); Ka77(3:5,3:5) = Ka;
% extending the kernel B to 7x7
Kb77 = zeros(7); Kb77(3:5,3:5) = Kb;

% using the kernel A followed by kernel A and applying the filtering function
result10 = ICV_img_filter(ICV_img_filter(img, Ka77), Ka77);
figure(11);imshow(result10); imwrite(result4, 'results/q2/kernelAbyA7x7.png');

% using the kernel A followed by kernel B and applying the filtering function
result11 = ICV_img_filter(ICV_img_filter(img, Ka77), Kb77);
figure(12);imshow(result11); imwrite(result5, 'results/q2/kernelAbyB7x7.png');

% using the kernel B followed by kernel A and applying the filtering function
result12 = ICV_img_filter(ICV_img_filter(img, Kb77), Ka77);
figure(13);imshow(result12); imwrite(result6, 'results/q2/kernelBbyA7x7.png');