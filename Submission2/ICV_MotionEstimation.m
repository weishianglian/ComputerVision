function [supFrame, estFrame] = ICV_MotionEstimation(frame1, frame2, blockSize, windowSize)
%ICV_MOTIONESTIMATION Calculate and display the motion vectors between two
% frames and predict the next frame based on the vectors.
% 
% [supFrame, estFrame] = ICV_MOTIONESTIMATION(frame1, frame2, blockSize, windowSize)
% frame1: The first of consecutive frames from a video sequence.
% frame2: The second of consecutive frames from a video sequence.
% blockSize: The matching block size.
% windowsSize: The searching window size.
% 
% supFrame: The frame superimposed by the motion vectors with arrows.
% estFrame: The next frame estimated by offered frames.
    
    % extract frame size, vertical and horizontal block number
    [h, w, c] = size(frame1);
    hBlocks = h/blockSize;
    wBlocks = w/blockSize;
    
    % initalise estimated frame, patch and motion vector matrix
    estFrame = -1*ones([h, w, c]);
    estPatch = ones([h, w, c]);
    vectorM = zeros(hBlocks, wBlocks, 4);
    
    % the move range of search window and the count of the image elements
    range = windowSize/2;
    pixelNum = numel(frame1);
    
    % hold on the figure for frame superimposed by motion vector arrows
    figure('Visible','off');
    imshow(frame2);
    hold on;
    
    % loop every block to caculate motion vector
    for sqH = 1:hBlocks
        for sqW = 1:wBlocks
            % initialise the sum store matrix and it's index
            sumStore = zeros(1, windowSize^2);
            storeIndex = 1;
            
            % block range start with left-top and end with right-bottom
            startH = (sqH-1)*blockSize+1;
            endH = sqH*blockSize;
            startW = (sqW-1)*blockSize+1;
            endW = sqW*blockSize;
            
            % the matching block from consecutive frames
            % set the target block same position as the anchor block at first
            anchorBlock = double(frame1(startH:endH, startW:endW, :));
            targetBlock = double(frame2(startH:endH, startW:endW, :));

            % similarity measure (Mean Absolute Error)
            subtBlock = abs(anchorBlock - targetBlock);
            sumStore(((windowSize+1)^2+1)/2) = sum(subtBlock(1:end));
            
            % initialsise motion vector values
            vectorH = 0;
            vectorW = 0;
            
            % window search start and end point (prevent out of boundary)
            winStartH = -min(range, startH-1);
            winEndH = min(range, h-endH);
            winStartW = -min(range, startW-1);
            winEndW = min(range, w-endW);
            
            % base on anchor block to compare every target block with summing subtraction matrix 
            for varyH = winStartH:winEndH
                for varyW = winStartW:winEndW
                    targetBlock = double(frame2(startH+varyH:endH+varyH, startW+varyW:endW+varyW, :));
                    subtBlock = abs(anchorBlock - targetBlock);
                    sumStore(storeIndex) = sum(subtBlock(1:end));
                    % find the minimum sum compared to the others and set it to vctor
                    if storeIndex>1 && sumStore(storeIndex)<min(sumStore(1:storeIndex-1))
                        vectorH = varyH;
                        vectorW = varyW;
                    end
                    storeIndex = storeIndex+1;
                end
            end
            
            % estimate the next frame based on the motion vector and second frame
            estFrame(startH+vectorH:endH+vectorH, startW+vectorW:endW+vectorW, :)...
                = frame2(startH:endH, startW:endW, :); 
            
            % fill the patch with a block form the diverse direction
            % use "try" to prevent that index is out of boundry
            try
                estPatch(startH:endH, startW:endW, :)...
                    = frame2(startH-vectorH:endH-vectorH, startW-vectorW:endW-vectorW, :);
            catch
                estPatch(startH:endH, startW:endW, :)...
                    = frame2(startH:endH, startW:endW, :);
            end

            % draw the vector arrow from center of block and set it to a matrix
            x = sqW*blockSize - range;
            y = sqH*blockSize - range;
            if vectorH ~= 0 || vectorW ~= 0
                vectorM(sqH, sqW, :) = [x, y, vectorW, vectorH];
            end
        end
    end
    % display the motion vector arrows and cover it on the second frame
    quiver(vectorM(:,:,1), vectorM(:,:,2), vectorM(:,:,3), vectorM(:,:,4), 'b');
    axis([0 w 0 h]);
    hold off;
    F = getframe;
    supFrame = F.cdata;
    
    % fill the empty pixels in estimated frame with patch frame
    background = ICV_ReferenceFrame(VideoReader('DatasetC.mpg'), false);
    for ind = 1:pixelNum
        if estFrame(ind) == -1
%             estFrame(ind) = estPatch(ind);
            estFrame(ind) = background(ind);
        end
    end
    estFrame = uint8(estFrame);
    
    % show the results with first frame, second frame, motion vector and estimated frame
    f2 = figure('NumberTitle','off');
    bsStr = num2str(blockSize); wsStr = num2str(windowSize);
    set(f2, 'Name', ['Motion Estimation [Block:',bsStr,'x', bsStr,', Window:',wsStr,'x',wsStr,']']);
    subplot(2,2,1); imshow(frame1); title('Frame t');
    subplot(2,2,2); imshow(frame2); title('Frame t+1');
    subplot(2,2,3); imshow(supFrame); title('Superimposed Frame t+1');
    subplot(2,2,4); imshow(estFrame); title('Predicted Frame t+2');
    figure('Visible','off'); imshow(estFrame);

end