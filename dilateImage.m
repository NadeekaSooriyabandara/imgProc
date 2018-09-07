function [dilatedImage] = dilateImage(binaryImage, SE)
    [p, q]=size(SE);
    [m, n]=size(binaryImage);
    dilatedImage= zeros(m,n);
       for i=1:m
           for j=1:n
               if (binaryImage(i,j)==1)
                 for k=1:p
                   for l=1:q
                      if(SE(k,l)==1)
                       c=i+k;
                       d=j+l;
                       dilatedImage(c,d)=1;

                      end
                   end
                 end
               end
           end
       end
end
