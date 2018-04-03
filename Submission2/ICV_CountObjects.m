function [objCounter] = ICV_CountObjects(video)
%ICV_COUNTOBJECTS Count objects from every frame and draw a histogram
%
% [objCounter] = ICV_COUNTOBJECTS(video)
% video: The video sequence source
% 
% objCounter: The histogram generated from every frame from the video
    
    % get the background from a sequence video by copmuting averaging RGB values
    background = ICV_ReferenceFrame(video, false);
    
    % get all frames number and initialise the histogram matrix 
    maxFrame = video.NumberOfFrame;
    objCounter = zeros(1, maxFrame);
    
    % search range for counting object, number and the object threshold of pixel number
    searchRange = 8;
    objThreshold = 40;
    
    % loop for every frame
    for fn = 1:maxFrame
        % load every frame and get its data
        frame = read(video, fn);
        [h, w, ~] = size(frame);
        
        % get the threshold difference between background and current frame
        [~, thresDiff] = ICV_Objects(background, frame, false);

        % initialise the mark matrix for recording object order
        markM = zeros(h, w);
        
        % find the objects by threshold difference and mark the number depending on the near group
        objNum = 1;
        for imH = 1:h
            for imW = 1:w
                if thresDiff(imH, imW) == 255
                    % make sure that search range (start and end point) are inside the image pixel boundary
                    startH = max(imH - searchRange, 1);
                    endH = min(imH + searchRange, h);
                    startW = max(imW - searchRange, 1);
                    endW = min(imW + searchRange, w);

                    % create or find the marking number of the search range
                    maxNeighbour = max(max(markM(startH:endH, startW:endW)));
                    if maxNeighbour == 0
                        markM(imH, imW) = objNum;
                        objNum = objNum+1;
                    else
                        markM(imH, imW) = maxNeighbour;
                    end
                end
            end
        end
        
        % filter out those mark numbers don't over threshold
        thresObjNum = 0;
        uniNum = unique(markM); % e.g. [0, 1, 2, 3, 4, ...]
        for objI = 2:length(uniNum) % start with 2 for excluding 0
            if length(markM(markM == uniNum(objI))) > objThreshold
               thresObjNum = thresObjNum+1; 
            end
        end
        objCounter(fn) = thresObjNum;
    end
    
    % draw the objects counter histogram 
    figure; bar(objCounter);
    title('Video Objects Counter'); xlabel('Video Frames'); ylabel('Objects Count');
    
end