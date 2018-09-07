% Load an image 
I = imread('new.JPG');

% Perform OCR
results = ocr(I);

word = results.Words{1};

% Location of the word in I
wordBBox = results.WordBoundingBoxes(1,:);

% Show the location of the word in the original image
figure;
Iname = insertObjectAnnotation(I, 'rectangle', wordBBox, word);
imshow(Iname);
