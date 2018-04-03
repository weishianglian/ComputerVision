function frameDiff=ZICV_frameDiff(video,refFrameNum,curFrameNum)
frame0=im2double(read(video,refFrameNum));
frame=im2double(read(video,curFrameNum));
[row,col,~]=size(frame0);
frameDiff=abs(ICV_rgb2gray(frame0)-ICV_rgb2gray(frame));
frameDiff=im2uint8(frameDiff);
thr=ICV_grayThresh(frameDiff);
for i=1:row
    for j=1:col
        if frameDiff(i,j)>thr
            frameDiff(i,j)=255;
        else
            frameDiff(i,j)=0;
        end
    end
end
end
