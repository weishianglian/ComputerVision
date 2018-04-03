function threshold = ZICV_grayThresh(img)
[m,n]=size(img);
number=zeros(1,256);
for i=1:m
    for j=1:n
        for rank=0:255
            if img(i,j)==rank
                number(rank+1)=number(rank+1)+1;                          
            end
        end
    end
end

if img==0
    threshold=101;
else
    mean=sum(sum(img))/(m*n);
    sigma=zeros(1,256);
    for thr=1:256
        c1=number(1:thr);
        c2=number(thr+1:256);
        n1=(0:thr-1);
        n2=(thr:255);
        mean1=sum(c1.*n1)/sum(c1);
        mean2=sum(c2.*n2)/sum(c2);
        p1=sum(c1)/(m*n);
        p2=1-p1;
        sigma(thr)=p1*(mean1-mean)^2+p2*(mean2-mean)^2;
    end
    
    max=0;
    for j=1:256
        if sigma(j)>max
            max=sigma(j);
            threshold=j-1;
        end
    end
end
end
