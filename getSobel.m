function [I, Mx, My] = getSobel(digitImage)

%Preallocate the matrices with zeros
I=zeros(size(digitImage));
Mx=zeros(size(digitImage));
My=zeros(size(digitImage));


%Filter Masks
F1=[-1 0 1;-2 0 2; -1 0 1];
F2=[-1 -2 -1;0 0 0; 1 2 1];

digitImage=double(digitImage);


for i=1:size(digitImage,1)-2
    for j=1:size(digitImage,2)-2
        %Gradient operations
        Gx=sum(sum(F1.*digitImage(i:i+2,j:j+2)));
        Gy=sum(sum(F2.*digitImage(i:i+2,j:j+2)));
               
        %Magnitude of vector
         I(i+1,j+1)=sqrt(Gx.^2+Gy.^2);
         Mx(i+1, j+1)=Gx;
         My(i+1, j+1)=Gy;
    end
end


%I=uint8(I);
end

