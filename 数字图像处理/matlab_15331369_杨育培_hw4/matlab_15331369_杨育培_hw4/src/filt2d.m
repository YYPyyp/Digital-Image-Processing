function filt2d(I,n,Q)
%��ȡԭͼ��
if isstr(I)
    img = imread(I);
end
[IH,IW] = size(img); %ȡ��ͼ��߶ȺͿ��
temp1=double(img);%������תΪ�����ͱ��ڼ���
%�߽紦��û�б���ֵ�ı߽�Ԫ��ȫ��ȡԭֵ
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
imshow(img)%��ʾԭͼ��
axis on
title(['ԭͼ��']);
subplot(222)
imshow(new)%��ʾƽ�����񻯺��ͼ��
axis on
title(['�˲���ͼ��']);
end
