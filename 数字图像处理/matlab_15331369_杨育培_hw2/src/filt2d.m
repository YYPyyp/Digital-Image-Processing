function filt2d(I,a)
%��ȡԭͼ��
if isstr(I)
    img = imread(I);
end
[IH,IW] = size(img); %ȡ��ͼ��߶ȺͿ��
[m,n] = size(a); %ȡ�˲���ά��������m��n��ͬ
temp1=double(img);%������תΪ�����ͱ��ڼ���
temp2=temp1;
for i=1:IH-n+1
    for j=1:IW-n+1
        c=temp1(i:i+(n-1),j:j+(n-1)).*a;  %����������㣬ȡ��temp1�д�(i,j)��ʼ��n��n��Ԫ����ģ�����a���
        s=sum(c(:)); %��ģ��c�����и�Ԫ��֮��
        temp2(i+(n-1)/2,j+(n-1)/2)=s; %��ģ���Ԫ�صľ�ֵ����ģ������λ�õ�Ԫ��
    end
end
%�߽紦��û�б���ֵ�ı߽�Ԫ��ȫ��ȡԭֵ
new=uint8(temp2);
figure
subplot(221)
imshow(img)%��ʾԭͼ��
axis on
title(['ԭͼ��']);
subplot(222)
imshow(new)%��ʾƽ�����񻯺��ͼ��
axis on
title(['ƽ����ͼ��']);
%�����ⲿ���Ǹ������˲�����
mask = img - new;
highboost = img + 3 * mask;%kֵ��Ϊ3
subplot(223)
imshow(highboost)%��ʾ�������˲����ͼ��
axis on
title(['�������˲�ͼ��']);
