function [new] = equalize_hist(I)  
if isstr(I)
    img = imread(I);
end  
[height,width] = size(img);
new = zeros(height,width); %% 创建新图像
figure  
subplot(221)  
imshow(img)%显示原始图像
axis on
title(['原图像']);
  
%统计像素灰度  
NumPixel = zeros(1,256);%用长度为256的一维数组统计各灰度值的数目
for i = 1:height  
    for j = 1: width  
        NumPixel(img(i,j) + 1) = NumPixel(img(i,j) + 1) + 1;  
    end  
end  
subplot(222)
bar(NumPixel)%显示原始图像直方图
axis on
title(['原图像直方图']);
%计算PDA 
PDA = zeros(1,256);  
for i = 1:256  
    PDA(i) = NumPixel(i) / (height * width * 1.0);  
end  
%计算CDA 
CDA = zeros(1,256);  
for i = 1:256  
    if i == 1  
        CDA(i) = PDA(i);  
    else  
        CDA(i) = CDA(i - 1) + PDA(i);  
    end  
end  
%将CDA乘上最大灰度255并且向上取整  
CDA = uint8(255 .* CDA + 0.5);  
%将原图像各个位置灰度值映射到新值  
for i = 1:height  
    for j = 1: width  
        new(i,j) = CDA(img(i,j)+1);  
    end  
end  
new = uint8(new);
subplot(223)  
imshow(new)%显示均衡化图像
axis on
title(['均衡化图像']);
NewNumPixel = zeros(1,256); 
for i = 1:height  
    for j = 1: width  
        NewNumPixel(new(i,j) + 1) = NewNumPixel(new(i,j) + 1) + 1;  
    end  
end
subplot(224)
bar(NewNumPixel)%显示均衡化图像直方图
axis on
title(['均衡化图像直方图']);
