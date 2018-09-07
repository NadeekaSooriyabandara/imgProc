function [hor_grad, ver_grad, GRADIENT] = getGradients(original, sigma)
    original=double(original);
    [H,W]=size(original);
    [x,y] = size(original);
    size_of_kernel = 6*sigma+1;
    GRADIENT =  zeros(H,W);           
    
    hor_grad = zeros(x,y);
    ver_grad = zeros(x,y);
    for i=1:x
       for j=2:y-1
    	hor_grad(i,j) = -1*original(i,j-1)+original(i,j+1);
       end
    end
    for i=2:x-1
       for j=1:y
    	ver_grad(i,j) = -1*original(i-1,j)+original(i+1,j);
       end
    end
    
    for r=1+ceil(size_of_kernel/2):H-ceil(size_of_kernel/2)  
        for c=1+ceil(size_of_kernel/2):W-ceil(size_of_kernel/2)  
            GRADIENT(r,c) = sqrt (hor_grad(r,c)^2 + ver_grad(r,c)^2 );
        end
    end
    
    
    figure;imshow(hor_grad,[])
    figure;imshow(ver_grad,[])
end