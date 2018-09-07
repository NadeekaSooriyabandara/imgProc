function non_max = getNonMax(my_image, GRADIENT,derivative_x, derivative_y, sigma)

%%Perform Non maximum suppression:
non_max = GRADIENT;
size_of_kernel = 6*sigma+1;
[H,W]=size(my_image);   

for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2) 
    for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  
        %%quantize:
        if (derivative_x(r,c) == 0) 
            tangent = 5;       
        else
            tangent = (derivative_y(r,c)/derivative_x(r,c));

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
end
