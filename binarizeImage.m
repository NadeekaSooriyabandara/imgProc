function [image, thresh] = binarizeImage(img)
    [height, width] = size(img);
     %thresh = max([min(max(img,[],1))  min(max(img,[],2))]);
     thresh = gbt(img);
     image = zeros(height, width);
    for R=1:height
        for C=1:width
            if (img(R,C) > thresh)
                image(R, C) = 1;
            end
        end
    end
end