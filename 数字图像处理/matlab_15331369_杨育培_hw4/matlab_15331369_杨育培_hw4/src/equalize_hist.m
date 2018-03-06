function equalize_hist(I)  
if isstr(I)
    img = imread(I);
end
figure 
subplot(221) 
imshow(img)
axis on
title(['原图像']);
[M,N,D] = size(img);
new = zeros(M,N); %%创建新图像
temp1 = img(:,:,1);
  
%统计像素灰度  
rNumPixel = zeros(1,256);%用长度为256的一维数组统计各灰度值的数目
for i = 1:M  
    for j = 1: N  
        rNumPixel(temp1(i,j) + 1) = rNumPixel(temp1(i,j) + 1) + 1;  
    end  
end  
%计算PDA 
PDA = zeros(1,256);  
for i = 1:256  
    PDA(i) = rNumPixel(i) / (M * N * 1.0);  
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
for i = 1:M  
    for j = 1: N  
        new(i,j) = CDA(temp1(i,j)+1);  
    end  
end  
new = uint8(new);
r = new;

temp2 = img(:,:,2);
  
%统计像素灰度  
gNumPixel = zeros(1,256);%用长度为256的一维数组统计各灰度值的数目
for i = 1:M  
    for j = 1: N  
        gNumPixel(temp2(i,j) + 1) = gNumPixel(temp2(i,j) + 1) + 1;  
    end  
end  
%计算PDA 
PDA = zeros(1,256);  
for i = 1:256  
    PDA(i) = gNumPixel(i) / (M * N * 1.0);  
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
for i = 1:M  
    for j = 1: N  
        new(i,j) = CDA(temp2(i,j)+1);  
    end  
end  
new = uint8(new);
g = new;

temp3 = img(:,:,3);
  
%统计像素灰度  
bNumPixel = zeros(1,256);%用长度为256的一维数组统计各灰度值的数目
for i = 1:M  
    for j = 1: N  
        bNumPixel(temp3(i,j) + 1) = bNumPixel(temp3(i,j) + 1) + 1;  
    end  
end  
%计算PDA 
PDA = zeros(1,256);  
for i = 1:256  
    PDA(i) = bNumPixel(i) / (M * N * 1.0);  
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
for i = 1:M  
    for j = 1: N  
        new(i,j) = CDA(temp3(i,j)+1);  
    end  
end  
new = uint8(new);
b = new;

output1 = cat(3,r,g,b);
subplot(222)
imshow(output1)
axis on
title(['均衡化图像']);

averageNumPixel = zeros(1,256);
for i = 1:256
    averageNumPixel(i) = (rNumPixel(i) + gNumPixel(i) + bNumPixel(i))/3;
end
%计算PDA 
PDA = zeros(1,256);  
for i = 1:256  
    PDA(i) = averageNumPixel(i) / (M * N * 1.0);  
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
for i = 1:M
    for j = 1:N
        new1(i,j) = CDA(temp1(i,j)+1);  
    end
end
new1 = uint8(new1);
for i = 1:M
    for j = 1:N
        new2(i,j) = CDA(temp2(i,j)+1);  
    end
end
new2 = uint8(new2);
for i = 1:M
    for j = 1:N
        new3(i,j) = CDA(temp3(i,j)+1);  
    end
end
new3 = uint8(new3);
output2 = cat(3,new1,new2,new3);
figure
imshow(output2)

%提取单通道分量
img=double(img);
r=img(:,:,1);
g=img(:,:,2);
b=img(:,:,3);
%实现转换
angle=acos(0.5*((r-g)+(r-b))./(sqrt((r-g).^2+(r-b).*(g-b))));
if (b>g)
    H = 2*pi-angle;
else
    H = angle;
end
H=H/(2*pi);
S=1-3.*(min(min(r,g),b))./(r+g+b);
H(S==0)=0;
I=(r+g+b)/3;
I=uint8(I);
%统计像素灰度  
INumPixel = zeros(1,256);%用长度为256的一维数组统计各灰度值的数目
for i = 1:M  
    for j = 1: N  
        INumPixel(I(i,j) + 1) = INumPixel(I(i,j) + 1) + 1;  
    end  
end  
%计算PDA 
PDA = zeros(1,256);  
for i = 1:256  
    PDA(i) = INumPixel(i) / (M * N * 1.0);  
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
for i = 1:M  
    for j = 1: N  
        Inew(i,j) = CDA(I(i,j)+1);  
    end 
end

I=Inew;
H=H*2*pi;
I=double(I);
S=double(S);
H=double(H);
[m,n]=size(H);
%转换
for i = 1:m
    for j = 1:n
        if (0<=H(i,j))&(H(i,j)<2*pi/3)
            B(i,j)=I(i,j).*(1-S(i,j));
            R(i,j)=I(i,j).*(1+S(i,j).*cos(H(i,j))./cos(pi/3-H(i,j)));
            G(i,j)=3*I(i,j)-(R(i,j)+B(i,j));
        end
        if (2*pi/3<=H(i,j))&(H(i,j)<4*pi/3)
            H(i,j)=H(i,j)-2*pi/3;
            R(i,j)=I(i,j).*(1-S(i,j));
            G(i,j)=I(i,j).*(1+S(i,j).*cos(H(i,j)-2*pi/3)./cos(pi-H(i,j)));
            B(i,j)=3*I(i,j)-(R(i,j)+G(i,j));
        end
        if (4*pi/3<=H(i,j))& (H(i,j)<2*pi)
            H(i,j)=H(i,j)-4*pi/3;
            G(i,j)=I(i,j).*(1-S(i,j));
            B(i,j)=I(i,j).*(1+S(i,j).*cos(H(i,j)-4*pi/3)./cos(5*pi/3-H(i,j)));
            R(i,j)=3*I(i,j)-(G(i,j)+B(i,j));
        end
    end
end

output3=cat(3,R,G,B);
output3=uint8(output3);
figure
imshow(output3)

