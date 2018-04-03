function ZICV_movObj(video)
frameNum=video.numberOfFrames;
frameDiffCell=cell(frameNum,1);
p=40;
countThr=50;
movObj=zeros(frameNum,1);
for curFrameNum=2:frameNum
    refFrameNum=curFrameNum-1;
    frameDiffCell{curFrameNum}=ICV_frameDiff(video,refFrameNum,curFrameNum);
end
for frame=1:frameNum
    img=frameDiffCell{frame};
    [row,col]=size(img);
    newimg=zeros(row+2*p,col+2*p);
    newimg(p+1:row+p,p+1:col+p)=img;
    [m,n]=size(newimg);
    labelM=zeros(m,n);
    label=1;
    for i= p+1:m-p
        for j=p+1:n-p
            if newimg(i,j)==255
                maxNeighbour=max(max(labelM(i-p:i+p,j-p:j+p)));
                if maxNeighbour==0
                    labelM(i,j)= label;
                    label=label+1;
                else
                    labelM(i,j)=maxNeighbour;
                end
            end
        end
    end
    objNum=0;
    uniqueNum=unique(labelM);
    for obj=2:length(uniqueNum)
        if length(labelM(labelM==uniqueNum(obj)))>countThr
            objNum=objNum+1;
        end
    end
    movObj(frame)=objNum;
end
figure;
bar(movObj);
title('Moving Objects')
xlabel('Frame');ylabel('Moving Objects');
end


                
            
            
            
            
            