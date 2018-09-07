colorImage = imread('new.jpg');
I = rgb2gray(colorImage);

Icorrected = imtophat(I, strel('disk', 10));
se = ones(3,3);

%Icorrected = imdilate(Icorrected, se);
%BW = imbinarize(Icorrected,'adaptive','ForegroundPolarity','dark','Sensitivity',0.6);
threshold = graythresh(Icorrected);
BW=im2bw(Icorrected,threshold);

imshow(BW)
title('Binary Version of Image')

%results = ocr(BW);

%word = results.Words{1};
