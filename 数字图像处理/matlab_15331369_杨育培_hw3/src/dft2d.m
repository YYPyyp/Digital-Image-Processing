function [temp3] = dft2d(I,flag)
%读取原图像
if isstr(I)
    img = imread(I);
end
[M,N] = size(img); %取出图像高度和宽度
temp1=double(img);%将矩阵转为浮点型便于计算
temp=temp1;
s = 0;
%中心化
if (flag == 0) 
    for x=1:M
        for y=1:N
            if rem(x+y,2)
                temp1(x,y) = -temp1(x,y);
            end
        end
    end
end
%傅里叶变换，采用的是将二维DFT转为两个一维DFT
%变换的第一部分，temp2为中间变量矩阵
for x=1:M
    for v=1:N
        for y=1:N
            s = s + temp1(x,y) * exp((-1i) * 2 * pi * v * y / N);
        end
        temp2(x,v) = s;
        s = 0;
    end
end
%变换的第二部分，temp为未进行中心化的生成矩阵，temp3为中心化后并通过傅里叶变换产生的频谱图
for u=1:M
    for v=1:N
        for x=1:M
            s = s + temp2(x,v) * exp((-1i) * 2 * pi * u * x / M);
        end
        temp(u,v) = s;
        temp3(u,v) = log(abs(s));
        s = 0;
    end
end
%对频谱图标定
if (flag == 0)
    max = 0;
    for u=1:M
        for v=1:N
            if (temp3(u,v) > max)
                max = temp3(u,v);
            end
        end
    end
    scale = 256/max;
    for u=1:M
        for v=1:N
            temp3(u,v) = temp3(u,v) * scale;
        end
    end
    figure
    subplot(221)
    imshow(img)%显示原图像
    axis on
    title(['原图像']);
    subplot(222)
    %imshow(temp3,[])
    imshow(uint8(temp3))
    axis on
    title(['傅里叶变换']);
end
%作傅里叶反变换，方法跟傅里叶正变换一样，都是采用二维转一维
if (flag == 1)
for u=1:M
    for y=1:N
        for v=1:N
            s = s + temp(u,v) * exp((1i) * 2 * pi * v * y / N);
        end
        temp4(u,y) = s;
        s = 0;
    end
end

for x=1:M
    for y=1:N
        for u=1:M
            s = s + temp4(u,y) * exp((1i) * 2 * pi * u * x / M) / M;
        end
        temp5(x,y) = real(s); %temp5为反变换后的矩阵
        s = 0;
    end
end
%标定
max = 0;
for u=1:M
    for v=1:N
        if (temp5(u,v) > max)
            max = temp5(u,v);
        end
    end
end
scale = 256/max;
for u=1:M
    for v=1:N
        temp5(u,v) = temp5(u,v) * scale;
    end
end
figure
subplot(221)
imshow(img)%显示原图像
axis on
title(['原图像']);
subplot(222)
%imshow(temp5,[])%显示反变换图像
imshow(uint8(temp5))
axis on
title(['反变换图像']);
end