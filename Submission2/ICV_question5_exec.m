close all; clear all;
%% Coursework 5) a)
% load the video and the consecutive frames
video = VideoReader('DatasetC.mpg');
ref = read(video, 1);
img = read(video, 10);

% use the first frame as reference frame and generate difference with threshold
[originDiff, thresDiff] = ICV_Objects(ref, img, true);
imwrite(ref, 'results/q5/ReferenceFrame1.png');
imwrite(img, 'results/q5/TargetFrame1.png');
imwrite(originDiff, 'results/q5/FrameDiffer1.png');
imwrite(thresDiff, 'results/q5/FrameDifferThreshold1.png');

img = read(video, 20);
[originDiff, thresDiff] = ICV_Objects(ref, img, true);
imwrite(ref, 'results/q5/ReferenceFrame2.png');
imwrite(img, 'results/q5/TargetFrame2.png');
imwrite(originDiff, 'results/q5/FrameDiffer2.png');
imwrite(thresDiff, 'results/q5/FrameDifferThreshold2.png');

%% Coursework 5) b)
% use the previous frame as reference frame and generate difference with threshold
ref = read(video, 6);
img = read(video, 7);
[originDiff, thresDiff] = ICV_Objects(ref, img, true);
imwrite(ref, 'results/q5/ReferenceFrame3.png');
imwrite(img, 'results/q5/TargetFrame3.png');
imwrite(originDiff, 'results/q5/FrameDiffer3.png');
imwrite(thresDiff, 'results/q5/FrameDifferThreshold3.png');

ref = read(video, 26);
img = read(video, 27);
[originDiff, thresDiff] = ICV_Objects(ref, img, true);
imwrite(ref, 'results/q5/ReferenceFrame4.png');
imwrite(img, 'results/q5/TargetFrame4.png');
imwrite(originDiff, 'results/q5/FrameDiffer4.png');
imwrite(thresDiff, 'results/q5/FrameDifferThreshold4.png');

%% Coursework 5) c)
% generate a reference frame (background) for the sequence using averaging algorithm.
background = ICV_ReferenceFrame(video, true);
imwrite(background, 'results/q5/BackgroundFrame.png');

%% Coursework 5) d)
% count objects from every frame and draw a histogram recording them
[objCounter] = ICV_CountObjects(video);
saveas(gcf, 'results/q5/CountObjectsHistogram.png');