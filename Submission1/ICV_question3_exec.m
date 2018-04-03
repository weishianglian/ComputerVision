clc;clear all;close all;

%% Reading different frame images from the video and show the RGB histogram
% read and print the frame in the video in 3 seconds
v = VideoReader('DatasetB.avi');
v.CurrentTime = 3;
vf1 = readFrame(v);
figure; imshow(vf1); imwrite(vf1, 'results/q3/frameImg1.png');

% generate the RGB histogram of the image
[ranage1, mr1, mg1, mb1] = ICV_img_histogram(vf1);
figure; hist1 = plot(ranage1, mr1, 'Red', ranage1, mg1, 'Green', ranage1, mb1, 'Blue');
xlabel('RGB'); ylabel('Frequency'); title('RGB Histogram'); axis([0 256 0 1400]);
print('results/q3/Histogram1', '-dpng');

% read the frame in the video in 4 seconds
v.CurrentTime = 4;
vf2 = readFrame(v);
figure; imshow(vf2); imwrite(vf2, 'results/q3/frameImg2.png');

% generate the RGB histogram of the image
[ranage2, mr2, mg2, mb2] = ICV_img_histogram(vf2);
figure; hist2 = plot(ranage2', mr2, 'Red', ranage2', mg2, 'Green', ranage2', mb2, 'Blue');
xlabel('RGB'); ylabel('Frequency'); title('RGB Histogram'); axis([0 256 0 1400]);
print('results/q3/Histogram2', '-dpng');

%% Reading consecutive frame images from the video and show the RGB histogram
% read and print the frame in the video between 5 seconds and 6 seconds
v.CurrentTime = 5;
vf3 = readFrame(v);
figure; imshow(vf3); imwrite(vf3, 'results/q3/frameImg3.png');
[ranage3, mr3, mg3, mb3] = ICV_img_histogram(vf3);
figure; hist3 = plot(ranage3', mr3, 'Red', ranage3', mg3, 'Green', ranage3', mb3, 'Blue');
xlabel('RGB'); ylabel('Frequency'); title('RGB Histogram'); axis([0 256 0 1400]);
print('results/q3/Histogram3', '-dpng');

% show the changes of the intersection between 5 seconds and 6 seconds
index=1;
inter1 = zeros(30,1);
for t=5:1/30:6
    v.CurrentTime = t-1/30;
    f1 = readFrame(v);
    [ra1, r1, g1, b1]=ICV_img_histogram(f1);
    v.CurrentTime = t;
    f2 = readFrame(v);
    [ra2, r2, g2, b2]=ICV_img_histogram(f2);
    
    inter1(index) = ICV_hist_intersection(sum([r1,g1,b1],2), sum([r2,g2,b2],2));
    index = index+1;
end

figure; plot(5:1/30:6, inter1);
xlabel('time(s)'); ylabel('Intersection'); title('Histogram Intersection'); axis([5 6 195000 225000]);
print('results/q3/Intersection1', '-dpng');

% read and print the frame in the video between 6 seconds and 7 seconds
v.CurrentTime = 6;
vf5 = readFrame(v);
figure; imshow(vf5); imwrite(vf5, 'results/q3/frameImg4.png');
[ranage4, mr4, mg4, mb4] = ICV_img_histogram(vf5);
figure; hist4 = plot(ranage4', mr4, 'Red', ranage4', mg4, 'Green', ranage4', mb4, 'Blue'); 
xlabel('RGB'); ylabel('Frequency'); title('RGB Histogram'); axis([0 256 0 1400]);
print('results/q3/Histogram4', '-dpng');

% show the changes of the intersection between 5 seconds and 6 seconds
index=1;
inter2 = zeros(30,1);
for t=6:1/30:7
    v.CurrentTime = t-1/30;
    f1 = readFrame(v);
    [ra1, r1, g1, b1]=ICV_img_histogram(f1);
    
    v.CurrentTime = t;
    f2 = readFrame(v);
    [ra2, r2, g2, b2]=ICV_img_histogram(f2);
    
    inter2(index) = ICV_hist_intersection(sum([r1,g1,b1],2), sum([r2,g2,b2],2));
    index = index+1;
end

figure; plot(6:1/30:7, inter2);
xlabel('time(s)'); ylabel('Intersection'); title('Histogram Intersection'); axis([6 7 195000 225000]);
print('results/q3/Intersection2', '-dpng');

v.CurrentTime = 7;
vf5 = readFrame(v);
figure; imshow(vf5); imwrite(vf5, 'results/q3/frameImg5.png');
[ranage5, mr5, mg5, mb5] = ICV_img_histogram(vf5);
figure; hist5 = plot(ranage5', mr5, 'Red', ranage5', mg5, 'Green', ranage5', mb5, 'Blue');
xlabel('RGB'); ylabel('Frequency'); title('RGB Histogram');  axis([0 256 0 1400]);
print('results/q3/Histogram5', '-dpng');

%% Normalization
% normalize the histogram intersection from 5 to 6 seconds and 6 to 7 seconds
inter_min1=min(inter1);
inter_max1=max(inter1);
inter3=zeros(size(inter1));
for m=1:length(inter1)
	inter3(m) = (inter1(m) - inter_min1)/(inter_max1 - inter_min1);
end
figure; plot(5:1/30:6, inter3);
xlabel('time(s)'); ylabel('Intersection'); title('Histogram Intersection Normalization');
print('results/q3/IntersectionNormal1', '-dpng');

inter_min2=min(inter2);
inter_max2=max(inter2);
inter4=zeros(size(inter2));
for m=1:length(inter2)
	inter4(m) = (inter2(m) - inter_min2)/(inter_max2 - inter_min2);
end
figure; plot(6:1/30:7, inter4);
xlabel('time(s)'); ylabel('Intersection'); title('Histogram Intersection Normalization');
print('results/q3/IntersectionNormal2', '-dpng');

% normalize the histogram intersection for all video frames
vr = VideoReader('DatasetB.avi');
previous_frame = 0;
interAll = zeros(vr.NumberOfFrames-1, 1);
index = 1;
for m = 1:vr.NumberOfFrames
   frame = read(vr, m);
   if previous_frame == 0
       previous_frame = frame;
       continue;
   end
   [ra1, r1, g1, b1]=ICV_img_histogram(previous_frame);
   [ra2, r2, g2, b2]=ICV_img_histogram(frame);
    
   interAll(index) = ICV_hist_intersection(sum([r1,g1,b1],2), sum([r2,g2,b2],2));
   previous_frame = frame;
   index = index+1;
end
figure; plot(1:vr.NumberOfFrames-1, interAll);
xlabel('Frames'); ylabel('Intersection'); title('Histogram Intersection All');
print('results/q3/IntersectionAll', '-dpng');


inter_min3=min(interAll);
inter_max3=max(interAll);
interAllNormal=zeros(size(interAll));
for m = 1:length(interAll)
    interAllNormal(m) = (interAll(m) - inter_min3)/(inter_max3 - inter_min3);
end
figure; plot(1:length(interAllNormal), interAllNormal);
xlabel('Frames'); ylabel('Intersection'); title('Histogram Intersection All Normalization');
print('results/q3/IntersectionAllNormal', '-dpng');


