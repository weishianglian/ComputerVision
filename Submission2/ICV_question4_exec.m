close all; clear all;
%% Coursework 4) a) b)
% load the video and the consecutive frames
video = VideoReader('DatasetC.mpg');
frame1 = read(video, 7);
frame2 = read(video, 8);

% show the results, contained superimposed and estimated frame, and save the images for report
[supFrame, estFrame] = ICV_MotionEstimation(frame1, frame2, 16, 20);
imwrite(frame1, 'results/q4/Frame t.png');
imwrite(frame2, 'results/q4/Frame t+1.png');
imwrite(supFrame, 'results/q4/Frame t+1 Superimposed.png');
imwrite(estFrame, 'results/q4/Frame t+2 Predicted.png');

%% Coursework 4) c)
% implement different block size with 16x16 search window and record the execution time
tic
[supFrame, estFrame] = ICV_MotionEstimation(frame1, frame2, 4, 16);
t1 = toc
imwrite(supFrame, 'results/q4/Frame t+1 Superimposed 4_16.png');
imwrite(estFrame, 'results/q4/Frame t+2 Predicted 4_16.png');

tic
[supFrame, estFrame] = ICV_MotionEstimation(frame1, frame2, 8, 16);
t2 = toc
imwrite(supFrame, 'results/q4/Frame t+1 Superimposed 8_16.png');
imwrite(estFrame, 'results/q4/Frame t+2 Predicted 8_16.png');

tic
[supFrame, estFrame] = ICV_MotionEstimation(frame1, frame2, 16, 16);
t3 = toc
imwrite(supFrame, 'results/q4/Frame t+1 Superimposed 16_16.png');
imwrite(estFrame, 'results/q4/Frame t+2 Predicted 16_16.png');

%% Coursework 4) d)
% implement different search window size with 8x8 block size and record the execution time
tic
[supFrame, estFrame] = ICV_MotionEstimation(frame1, frame2, 8, 8);
t4 = toc
imwrite(supFrame, 'results/q4/Frame t+1 Superimposed 8_8.png');
imwrite(estFrame, 'results/q4/Frame t+2 Predicted 8_8.png');

tic
[supFrame, estFrame] = ICV_MotionEstimation(frame1, frame2, 8, 16);
t5 = toc
imwrite(supFrame, 'results/q4/Frame t+1 Superimposed 8_16.png');
imwrite(estFrame, 'results/q4/Frame t+2 Predicted 8_16.png');

tic
[supFrame, estFrame] = ICV_MotionEstimation(frame1, frame2, 8, 32);
t6 = toc
imwrite(supFrame, 'results/q4/Frame t+1 Superimposed 8_32.png');
imwrite(estFrame, 'results/q4/Frame t+2 Predicted 8_32.png');

%% Coursework 4) e)
% plot the execution time 
fig1 = figure;
x1 = [4, 8, 16];
y1 = [t1, t2, t3];
plot(x1, y1);
title('Execution Time of 16x16 Search Window Size');
xlabel('Block Size'); ylabel('Computing Time');
saveas(fig1, 'results/q4/TimeVsBlockSize.png');

fig2 = figure;
x2 = [8, 16, 32];
y2 = [t4, t5, t6];
plot(x2, y2);
title('Execution Time of 8x8 Block Size');
xlabel('Search Window Size'); ylabel('Computing Time');
saveas(fig2, 'results/q4/TimeVsWindowSize.png');