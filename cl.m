clc
clear
close all

row=640;  col=480;%not working when changed to 160*120 in arduino code unger VGA mode
fin=fopen('VGAP02.RAW','r');
I=fread(fin,row*col,'uint8=>uint8'); 
Z=reshape(I,row,col);
Z=Z';
% Increase image size by 3x
my_image = imresize(imcrop(Z, [400 130 180 90]), 3);
%[E, Mx, My] = GSobel(my_image, 5);BB = binarizeImage(E);figure;imshow(my_image);figure; imshow(E);figure;imshow(BB);
%I = getSobel(my_image); figure; imshow(I);

% Binarize image
BW1 = binarizeImage(my_image);
BW = dilateImage(BW1,ones(8, 8));
%BW = imdilate(BW1,strel('disk', 5));


[height, width] = size(BW);
A = zeros(height, width);
%get images of digits
firstDigit = imcrop(BW, [15 67 90 170]);
secondDigit = imcrop(BW, [155 68 90 170]);
thirdDigit = imcrop(BW, [302 62 90 170]);
fourthDigit = imcrop(BW, [435 60 90 170]);

%ROIs
roi1 = [10,5,70,25];
roi2 = [10,14,20,67];
roi3 = [51,14,25,67];
roi4 = [20,60,50,25];
roi5 = [10,80,20,67];
roi6 = [57,80,20,67];
roi7 = [10,130,70,25];

%recognize digits
[digit1, p1, p2, p3, p4, p5, p6, p7] = checkImage(firstDigit, roi1, roi2, roi3, roi4, roi5, roi6, roi7);
[digit2, q1, q2, q3, q4, q5, q6, q7] = checkImage(secondDigit, roi1, roi2, roi3, roi4, roi5, roi6, roi7);
[digit3, r1, r2, r3, r4, r5, r6, r7] = checkImage(thirdDigit, roi1, roi2, roi3, roi4, roi5, roi6, roi7);
[digit4, s1, s2, s3, s4, s5, s6, s7] = checkImage(fourthDigit, roi1, roi2, roi3, roi4, roi5, roi6, roi7);

%show digits and ROIs
figure, imshow(Z), figure, imshow(my_image), figure, imshow(BW1), figure, imshow(BW);
showDigits(firstDigit, roi1, roi2, roi3, roi4, roi5, roi6, roi7);
showDigits(secondDigit, roi1, roi2, roi3, roi4, roi5, roi6, roi7);
showDigits(thirdDigit, roi1, roi2, roi3, roi4, roi5, roi6, roi7);
showDigits(fourthDigit, roi1, roi2, roi3, roi4, roi5, roi6, roi7);

%I = getSobel(imcrop(my_image, [15 67 90 170])); figure; imshow(I);


%H = nonMaximalSupp(Mx, My, I, 0.1, 0.7); figure;imshow(H);

%Define a threshold value
%Thresh=100;
%B=max(H,Thresh);
%B(B==round(Thresh))=0;

%B=imbinarize(B);
%figure,imshow(B);title('Edge detected Image');



     
     
     
     