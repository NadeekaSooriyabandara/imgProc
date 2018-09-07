function [digit, ratio1, ratio2, ratio3, ratio4, ratio5, ratio6, ratio7] = checkImage(image, roi1, roi2, roi3, roi4, roi5, roi6, roi7)
    digit = 10;
    [isFilled1, noOfOnes1, noOfZeros1, ratio1] = checkROI(image, roi1);
    [isFilled2, noOfOnes2, noOfZeros2, ratio2] = checkROI(image, roi2);
    [isFilled3, noOfOnes3, noOfZeros3, ratio3] = checkROI(image, roi3);
    [isFilled4, noOfOnes4, noOfZeros4, ratio4] = checkROI(image, roi4);
    [isFilled5, noOfOnes5, noOfZeros5, ratio5] = checkROI(image, roi5);
    [isFilled6, noOfOnes6, noOfZeros6, ratio6] = checkROI(image, roi6);
    [isFilled7, noOfOnes7, noOfZeros7, ratio7] = checkROI(image, roi7);
    
    if (isFilled1 && isFilled2 && isFilled3 && ~isFilled4 && isFilled5 && isFilled6 && isFilled7)
        digit = 0;
    end
    if (~isFilled1 && ~isFilled2 && ~isFilled3 && isFilled4 && isFilled5 && isFilled6 && isFilled7)
        digit = 6;
    end
    if (isFilled1 && ~isFilled2 && isFilled3 && ~isFilled4 && isFilled5 && ~isFilled6 && isFilled7)
        digit = 2;
    end
    if (isFilled1 && isFilled2 && ~isFilled3 && isFilled4 && ~isFilled5 && isFilled6)
        digit = 5;
    end
    if (isFilled1 && isFilled2 && isFilled3 && isFilled4 && isFilled5 && isFilled6 && isFilled7)
        digit = 8;
    end
    if (isFilled1 && isFilled2 && isFilled3 && isFilled4 && ~isFilled5 && isFilled6 && isFilled7)
        digit = 9;
    end
end