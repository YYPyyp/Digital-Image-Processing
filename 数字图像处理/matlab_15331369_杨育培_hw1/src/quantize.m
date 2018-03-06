function quantize( I, GreyNum)
if isstr(I)
    img = imread(I);
end
[row,col] = size(img);
new = zeros(row,col);
r = 256/GreyNum; %ȷ�����䳤��
r2 = 255/(GreyNum-1); %ȷ��������β
for j = 1:col 
    for i = 1:row
        for n = 1:GreyNum
            if (img(i,j) < n*r)
                new(i,j) = 0 + (n-1) * r2;
                break;
            end
        end
    end
end
new = uint8(new);
figure
imshow(new);
axis on
title(['�������ͼ�񣨴�С�� ',num2str(col),'*',num2str(row),'*',...
    '�� �Ҷȷֱ��ʣ� ',num2str(GreyNum),'��']);
end
            