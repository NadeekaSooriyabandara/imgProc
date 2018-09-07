clear
close all
height =120;
width = 160;
resolution = height * width;
A = zeros(height,width);
b=0;
[num,txt] = xlsread('img.xlsx');
inputxl=transpose(num);
x=1;
y=width;
for i=1:height
        
    A(i,1:width) = inputxl(1,x:y); 
    x=x+width;
    y=y+width;
    
end 
% I = mat2gray(A,[0 255]);
I = uint8(mat2gray(A)*255);
figure
imshow(I);

%fid=fopen('JP0.RAW','w+');
%cnt=fwrite(fid,I,'uint8');
%fclose(fid);