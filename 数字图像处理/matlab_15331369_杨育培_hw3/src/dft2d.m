function [temp3] = dft2d(I,flag)
%��ȡԭͼ��
if isstr(I)
    img = imread(I);
end
[M,N] = size(img); %ȡ��ͼ��߶ȺͿ��
temp1=double(img);%������תΪ�����ͱ��ڼ���
temp=temp1;
s = 0;
%���Ļ�
if (flag == 0) 
    for x=1:M
        for y=1:N
            if rem(x+y,2)
                temp1(x,y) = -temp1(x,y);
            end
        end
    end
end
%����Ҷ�任�����õ��ǽ���άDFTתΪ����һάDFT
%�任�ĵ�һ���֣�temp2Ϊ�м��������
for x=1:M
    for v=1:N
        for y=1:N
            s = s + temp1(x,y) * exp((-1i) * 2 * pi * v * y / N);
        end
        temp2(x,v) = s;
        s = 0;
    end
end
%�任�ĵڶ����֣�tempΪδ�������Ļ������ɾ���temp3Ϊ���Ļ���ͨ������Ҷ�任������Ƶ��ͼ
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
%��Ƶ��ͼ�궨
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
    imshow(img)%��ʾԭͼ��
    axis on
    title(['ԭͼ��']);
    subplot(222)
    %imshow(temp3,[])
    imshow(uint8(temp3))
    axis on
    title(['����Ҷ�任']);
end
%������Ҷ���任������������Ҷ���任һ�������ǲ��ö�άתһά
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
        temp5(x,y) = real(s); %temp5Ϊ���任��ľ���
        s = 0;
    end
end
%�궨
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
imshow(img)%��ʾԭͼ��
axis on
title(['ԭͼ��']);
subplot(222)
%imshow(temp5,[])%��ʾ���任ͼ��
imshow(uint8(temp5))
axis on
title(['���任ͼ��']);
end