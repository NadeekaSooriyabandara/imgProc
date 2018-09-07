clear
close all

row=640;  col=480;%not working when changed to 160*120 in arduino code unger VGA mode
fin=fopen('VGAP02.RAW','r');
I=fread(fin,row*col,'uint8=>uint8'); 
Z=reshape(I,row,col);
Z=Z';

B = mat2gray(Z);
B = medfilt2(B);
B = imgaussfilt(B,0.1);
Icorrected = imtophat(B, strel('disk', 15));
threshold = graythresh(Icorrected);
BW=im2bw(Icorrected,threshold);
imm = imcomplement(BW);

results = ocr(imcrop(imm, [400,130,180,90]));
results.Text

figure,imshow(B), figure, imshow(Icorrected), figure, imshow(BW), 
figure, imshow(imcrop(imm, [400,130,180,90]))
hold on;

rectangle('Position',[400,130,180,90],...
          'Curvature',[0,0],...
         'LineWidth',2,'LineStyle','-')