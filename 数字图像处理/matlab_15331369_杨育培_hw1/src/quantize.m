function quantize( I, GreyNum)
if isstr(I)
    img = imread(I);
end
[row,col] = size(img);
new = zeros(row,col);
r = 256/GreyNum; %确定区间长度
r2 = 255/(GreyNum-1); %确定区间首尾
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
title(['量化后的图像（大小： ',num2str(col),'*',num2str(row),'*',...
    '， 灰度分辨率： ',num2str(GreyNum),'）']);
end
            