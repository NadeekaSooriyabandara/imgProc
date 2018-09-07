function post_hysteresis = getHysteresis(my_image, non_max, sigma, min_hysteresis_thresh, max_hysteresis_thresh)

size_of_kernel = 6*sigma+1;
post_hysteresis = non_max;
[H,W]=size(my_image); 

for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2)  

    for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  

        if(post_hysteresis(r,c)>=max_hysteresis_thresh)
            post_hysteresis(r,c)=1;
        end

        if(post_hysteresis(r,c)<max_hysteresis_thresh && post_hysteresis(r,c)>=min_hysteresis_thresh) 
            post_hysteresis(r,c)=2;
        end

        if(post_hysteresis(r,c)<min_hysteresis_thresh)
            post_hysteresis(r,c)=0;
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
end