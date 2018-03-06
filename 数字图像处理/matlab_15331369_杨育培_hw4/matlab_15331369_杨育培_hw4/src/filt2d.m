function filt2d(I,n,Q)
%读取原图像
if isstr(I)
    img = imread(I);
end
[IH,IW] = size(img); %取出图像高度和宽度
temp1=double(img);%将矩阵转为浮点型便于计算
%边界处理，没有被赋值的边界元素全部取原值
temp2=temp1;
for i=1:IH-n+1
    for j=1:IW-n+1
        c=temp1(i:i+(n-1),j:j+(n-1));
        temp2(i+(n-1)/2,j+(n-1)/2) = sum(c(:).^(Q+1))/sum(c(:).^(Q));
    end
end
new=uint8(temp2);
figure
subplot(221)
imshow(img)%显示原图像
axis on
title(['原图像']);
subplot(222)
imshow(new)%显示平滑或锐化后的图像
axis on
title(['滤波后图像']);
end
