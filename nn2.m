clear
close all

row=640;  col=480;%not working when changed to 160*120 in arduino code unger VGA mode
fin=fopen('VGAP02.RAW','r');
I=fread(fin,row*col,'uint8=>uint8'); 
Z=reshape(I,row,col);
Z=Z';
% Increase image size by 3x
my_image = imresize(imcrop(Z, [400,130,180,90]), 3);

% Localize words
BW = im2bw(mat2gray(my_image));
BW1 = imdilate(BW,strel('disk',3));

% Pre-process image to make letters thicker
BW = imdilate(BW,strel('disk',5));
% Call OCR and pass in location of words. Also, set TextLayout to 'word'
X = [15 67 90 170;155 68 90 170;302 62 90 170;435 60 90 170];
ocrResults = ocr(BW, X,'CharacterSet','0123456789','TextLayout','word');
words = {ocrResults(:).Text}';
words = deblank(words)

%results = ocr(BW, [302,62,90,170], 'CharacterSet','0123456789','TextLayout','word');
%results.Text
figure, imshow(Z), figure, imshow(my_image), figure, imshow(BW1), figure, imshow(BW)
hold on;

rectangle('Position',[15,67,90,170],...
          'Curvature',[0,0],...
         'LineWidth',2,'LineStyle','-')
rectangle('Position',[155,68,90,170],...
          'Curvature',[0,0],...
         'LineWidth',2,'LineStyle','-')
rectangle('Position',[302,62,90,170],...
          'Curvature',[0,0],...
         'LineWidth',2,'LineStyle','-')     
rectangle('Position',[435,60,90,170],...
          'Curvature',[0,0],...
         'LineWidth',2,'LineStyle','-') 