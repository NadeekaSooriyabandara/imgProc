function [isFilled, noOfOnes, noOfZeros, ratio] = checkROI(image, roi)
    isFilled = false;
    imageROI = imcrop(image, roi);
    [height, width] = size(imageROI);
    noOfOnes = 0;
    noOfPixels = height*width;
    for R=1:height
        for C=1:width
            if (imageROI(R,C) == 1)
               noOfOnes = noOfOnes + 1; 
            end
        end
    end
    noOfZeros = noOfPixels - noOfOnes;
    ratio = noOfOnes/noOfZeros;
    if (ratio < 3.9)
        isFilled = true;
    end
    
end