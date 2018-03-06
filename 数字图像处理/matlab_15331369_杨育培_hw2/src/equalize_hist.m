function [new] = equalize_hist(I)  
if isstr(I)
    img = imread(I);
end  
[height,width] = size(img);
new = zeros(height,width); %% ������ͼ��
figure  
subplot(221)  
imshow(img)%��ʾԭʼͼ��
axis on
title(['ԭͼ��']);
  
%ͳ�����ػҶ�  
NumPixel = zeros(1,256);%�ó���Ϊ256��һά����ͳ�Ƹ��Ҷ�ֵ����Ŀ
for i = 1:height  
    for j = 1: width  
        NumPixel(img(i,j) + 1) = NumPixel(img(i,j) + 1) + 1;  
    end  
end  
subplot(222)
bar(NumPixel)%��ʾԭʼͼ��ֱ��ͼ
axis on
title(['ԭͼ��ֱ��ͼ']);
%����PDA 
PDA = zeros(1,256);  
for i = 1:256  
    PDA(i) = NumPixel(i) / (height * width * 1.0);  
end  
%����CDA 
CDA = zeros(1,256);  
for i = 1:256  
    if i == 1  
        CDA(i) = PDA(i);  
    else  
        CDA(i) = CDA(i - 1) + PDA(i);  
    end  
end  
%��CDA�������Ҷ�255��������ȡ��  
CDA = uint8(255 .* CDA + 0.5);  
%��ԭͼ�����λ�ûҶ�ֵӳ�䵽��ֵ  
for i = 1:height  
    for j = 1: width  
        new(i,j) = CDA(img(i,j)+1);  
    end  
end  
new = uint8(new);
subplot(223)  
imshow(new)%��ʾ���⻯ͼ��
axis on
title(['���⻯ͼ��']);
NewNumPixel = zeros(1,256); 
for i = 1:height  
    for j = 1: width  
        NewNumPixel(new(i,j) + 1) = NewNumPixel(new(i,j) + 1) + 1;  
    end  
end
subplot(224)
bar(NewNumPixel)%��ʾ���⻯ͼ��ֱ��ͼ
axis on
title(['���⻯ͼ��ֱ��ͼ']);
