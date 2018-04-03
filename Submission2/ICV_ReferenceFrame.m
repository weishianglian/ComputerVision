function [background] = ICV_ReferenceFrame(video, showImg)
%ICV_REFERENCEFRAME Copmute the averaging RGB values to get a background from a sequence video.
%
% [background] = ICV_REFERENCEFRAME(video)
% video: The video sequence source
% 
% background: The background computed by averaging RGB values of the video
% showImg: The switch of showing the results in figure.

    % get all frames number
    maxFrames = video.NumberOfFrame;
    
    % load the video as a 4 dimension matrix
    allFrames = video.read();
    
    % sum all frames up and divide them by all frames number
    background = uint8(sum(allFrames, 4)/maxFrames);
    
    % show the result
    if showImg
        figure; imshow(background); title('Reference Frame');
    end    

end