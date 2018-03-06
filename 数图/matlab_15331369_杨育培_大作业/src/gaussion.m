function window = gaussion(size,sigma)
n=floor((size+1)/2);%计算图象中心   
for i=1:size   
    for j=1:size   
      window(i,j) =exp(-((i-n)^2+(j-n)^2)/(2*sigma^2));
    end
end
end