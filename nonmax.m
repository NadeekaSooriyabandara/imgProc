clear;
close all;

max_hysteresis_thresh = 0.01;
min_hysteresis_thresh = 0.03;
sigma = 1;


row=640;  col=480;%not working when changed to 160*120 in arduino code unger VGA mode
fin=fopen('VGAP0.RAW','r');
I=fread(fin,row*col,'uint8=>uint8'); 
Z=reshape(I,row,col);
Z=Z';
Z = imrotate(Z, 90);
% Increase image size by 3x
my_image = imresize(imcrop(Z, [65 290 150 120]), 1);



%%Convert to double:
ORIGINAL_IMAGE=im2double(my_image);    

%%Save height and width
[H,W]=size(my_image);          

%%Derivatives in x and y
derivative_x=zeros(H,W);              
derivative_y=zeros(H,W);    

%%Gaussian kernel
size_of_kernel = 6*sigma+1;         
adjust= ceil(size_of_kernel/2);
Y_GAUSSIAN=zeros(size_of_kernel,size_of_kernel);
X_GAUSSIAN=zeros(size_of_kernel,size_of_kernel);

%%Create gaussian kernels for both x and y directions based on the sigma

%%that was given.

 

for i=1:size_of_kernel

    for iiii=1:size_of_kernel

        Y_GAUSSIAN(i,iiii) = -( (i-((size_of_kernel-1)/2)-1)/( 2* pi * sigma^3 ) ) * exp ( - ( (i-((size_of_kernel-1)/2)-1)^2 + (iiii-((size_of_kernel-1)/2)-1)^2 )/ (2*sigma^2) );

    end

end

 

for i=1:size_of_kernel

    for iiii=1:size_of_kernel

        X_GAUSSIAN(i,iiii) = -( (iiii-((size_of_kernel-1)/2)-1)/( 2* pi * sigma^3 ) ) * exp ( - ( (i-((size_of_kernel-1)/2)-1)^2 + (iiii-((size_of_kernel-1)/2)-1)^2 )/ (2*sigma^2) );

    end

end

 

 

GRADIENT =  zeros(H,W);       

non_max = zeros(H,W);     

 

post_hysteresis = zeros(H,W); 

 

 

 

 

%%Image Derivatives:

 

for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2)  

    for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  

        reference_row=  r-ceil(size_of_kernel/2); 

        reference_colum=  c-ceil(size_of_kernel/2); 

        for yyy=1:size_of_kernel  

            for yyy_col=1:size_of_kernel  

                derivative_x(r,c) = derivative_x(r,c) + ORIGINAL_IMAGE(reference_row+yyy-1, reference_colum+yyy_col-1)*X_GAUSSIAN(yyy,yyy_col);

            end

        end

    end

end

 

 

for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2)  

    for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2) 

        reference_row=  r-ceil(size_of_kernel/2); 

        reference_colum=  c-ceil(size_of_kernel/2); 

        for yyy=1:size_of_kernel  

            for yyy_col=1:size_of_kernel 

                derivative_y(r,c) = derivative_y(r,c) + ORIGINAL_IMAGE(reference_row+yyy-1, reference_colum+yyy_col-1)*Y_GAUSSIAN(yyy,yyy_col);

            end

        end

    end

end

 

 

%%Compute the gradient magnitufde based on derivatives in x and y:

 

for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2)  

    for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  

        GRADIENT(r,c) = sqrt (derivative_x(r,c)^2 + derivative_y(r,c)^2 );

    end

end

 

%%Perform Non maximum suppression:

 

non_max = GRADIENT;

for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2) 

    for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  

       

        %%quantize:

        if (derivative_x(r,c) == 0) tangent = 5;       

        else tangent = (derivative_y(r,c)/derivative_x(r,c));   

        end

        if (-0.4142<tangent && tangent<=0.4142)

            if(GRADIENT(r,c)<GRADIENT(r,c+1) || GRADIENT(r,c)<GRADIENT(r,c-1))

                non_max(r,c)=0;

            end

        end

        if (0.4142<tangent && tangent<=2.4142)

            if(GRADIENT(r,c)<GRADIENT(r-1,c+1) || GRADIENT(r,c)<GRADIENT(r+1,c-1))

                non_max(r,c)=0;

            end

        end

        if ( abs(tangent) >2.4142)

            if(GRADIENT(r,c)<GRADIENT(r-1,c) || GRADIENT(r,c)<GRADIENT(r+1,c))

                non_max(r,c)=0;

            end

        end

        if (-2.4142<tangent && tangent<= -0.4142)

            if(GRADIENT(r,c)<GRADIENT(r-1,c-1) || GRADIENT(r,c)<GRADIENT(r+1,c+1))

                non_max(r,c)=0;

            end

        end

    end

end

 

 

 

 

post_hysteresis = non_max;

 

for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2)  

    for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  

        if(post_hysteresis(r,c)>=max_hysteresis_thresh) post_hysteresis(r,c)=1;

        end

        if(post_hysteresis(r,c)<max_hysteresis_thresh && post_hysteresis(r,c)>=min_hysteresis_thresh) post_hysteresis(r,c)=2;

        end

        if(post_hysteresis(r,c)<min_hysteresis_thresh) post_hysteresis(r,c)=0;

        end 

    end

end

 

 

 

vvvv = 1; 

 

while (vvvv == 1)

   

    vvvv = 0;

   

    for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2)  

        for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  

            if (post_hysteresis(r,c)>0)      

                if(post_hysteresis(r,c)==2) 

                   

                   

                    if( post_hysteresis(r-1,c-1)==1 || post_hysteresis(r-1,c)==1 || post_hysteresis(r-1,c+1)==1 || post_hysteresis(r,c-1)==1 ||  post_hysteresis(r,c+1)==1 || post_hysteresis(r+1,c-1)==1 || post_hysteresis(r+1,c)==1 || post_hysteresis(r+1,c+1)==1 ) post_hysteresis(r,c)=1;

                        vvvv = 1;

                    end

                end

            end

        end

    end

   

end

 

 

 

for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2) 

    for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  

        if(post_hysteresis(r,c)==2) 

            post_hysteresis(r,c)=0;

        end   

    end

end


figure; imshow(Z), figure; imshow(derivative_x);figure;imshow(derivative_y);figure;imshow(GRADIENT);figure;imshow(non_max);figure;imshow(post_hysteresis);
