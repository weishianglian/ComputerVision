# Computer Vision
## Transformation
* Rotation, translation and skew are useful operations for matching and tracking.  

## Filtering and Convolution
* Image filtering allows you to apply various effects on images.  

## Histogram
* A colour histogram is a representation of the distribution of colours in an image.  

## Motion estimation
* Block matching is a commonly used motion estimation approach. Block matching compares each block of a frame with blocks in a past or future frame in order to find the corresponding block (i.e. the block minimising an error measure, such as the Mean Square Error or the Mean Absolute Error). The search is usually restricted to a window centred on the position of the target block in the current frame. The search window defines an upper limit on how fast objects can move between frames (maximum displacement), if they are to be coded effectively.  

## Objects
* Moving objects captured by fixed cameras are of great importance in several computer vision applications.  

## Texture
* Local binary pattern (LBP) is a feature used for texture representation and classification. The LBP operator describes the surroundings of a pixel by generating a bit-code from the binary derivatives of a pixel. The operator is usually applied to greyscale images and the derivative of the intensities. An example of how the LBP in its simplest form works is illustrated in the figure below. Note how a pixel with a value > C is assigned ‘1’ and a pixel with a value < C is assigned ‘0’.  
![LBP](iamges/LBP.png)