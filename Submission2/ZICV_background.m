function bg=ZICV_background(video)
frameNum=video.numberOfFrames;
frameCell=cell(frameNum-1,1);
frameDiffCell=cell(frameNum-1,1);
bgCell=cell(frameNum-1,1);
for curFrame=2:frameNum
    frameCell{curFrame-1}=read(video,curFrame);
    refFrame=curFrame-1;
    frameDiffCell{curFrame-1}=ZICV_frameDiff(video,refFrame,curFrame);
end
for i=1:frameNum-1
    bgCell{i}=frameCell{i}-frameDiffCell{i};
end
bgresult=0;
for j=1:length(bgCell)
    bgresult=bgresult+im2double(bgCell{j});
end
bg=bgresult/length(bgCell);
bg=im2uint8(bg);
end