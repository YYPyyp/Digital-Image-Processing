function filt2d(I,a)
%读取原图像
if isstr(I)
    img = imread(I);
end
[IH,IW] = size(img); %取出图像高度和宽度
[m,n] = size(a); %取滤波器维数，这里m，n相同
temp1=double(img);%将矩阵转为浮点型便于计算
temp2=temp1;
for i=1:IH-n+1
    for j=1:IW-n+1
        c=temp1(i:i+(n-1),j:j+(n-1)).*a;  %进行相关运算，取出temp1中从(i,j)开始的n行n列元素与模板矩阵a相乘
        s=sum(c(:)); %求模板c矩阵中各元素之和
        temp2(i+(n-1)/2,j+(n-1)/2)=s; %将模板各元素的均值赋给模板中心位置的元素
    end
end
%边界处理，没有被赋值的边界元素全部取原值
new=uint8(temp2);
figure
subplot(221)
imshow(img)%显示原图像
axis on
title(['原图像']);
subplot(222)
imshow(new)%显示平滑或锐化后的图像
axis on
title(['平滑后图像']);
%下面这部分是高提升滤波处理；
mask = img - new;
highboost = img + 3 * mask;%k值设为3
subplot(223)
imshow(highboost)%显示高提升滤波后的图像
axis on
title(['高提升滤波图像']);
