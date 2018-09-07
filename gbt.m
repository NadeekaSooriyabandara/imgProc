function T=gbt(img) 

[height, width] = size(img);
    for R=1:height
        for C=1:width
            if (R == 1 && C ==1)
                x = img(R, C);
            else
                x = [x, img(R, C)];
            end
        end
    end

p=length(x);
T=x(randi(p-1));
T0=0;

t1=x<=T;
t2=x>T;
mean1=sum(x(t1))/sum(t1);
mean2=sum(x(t2))/sum(t2);

while abs(T-T0)>10^-8
    T0=T;
    T=(mean1+mean2)/2;
    t1=x<T;
    t2=x>T;
    mean1=sum(x(t1))/sum(t1);
    mean2=sum(x(t2))/sum(t2);
end