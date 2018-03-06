function [output] = scale1(I, Width, Height)
img = imread(I);
[row,col] = size(img);
%确定缩放比例
ratioH = Height/row;
ratioW = Width/col;
output = zeros(Height,Width);
%拓宽矩阵，赋值，处理边界
temp = zeros(row+2,col+2);
%拷贝原矩阵
for x = 1:row
    for y = 1:col
        temp(x+1,y+1) = img(x,y);
    end
end
%边界处理
for y = 1:col
    temp(1,y+1) = img(1,y);
    temp(row+2,y+1) = img(row,y);
end
for x = 1:row
    temp(x+1,1) = img(x,1);
    temp(x+1,col+2) = img(x,col);
end
temp(1,1) = img(1,1);
temp(1,col+2) = img(1,col);
temp(row+2,1) = img(row,1);
temp(row+2,col+2) = img(row,col);
%双线性内插值算法
for j = 1:Width
    for i = 1:Height
        jj = (j-1)/ratioW;
        ii = (i-1)/ratioH;
        pj = floor(jj);
        pi = floor(ii);
        u = ii - pi;
        v = jj - pj;
        pi = pi + 1;
        pj = pj + 1;
        output(i,j) = (1-u)*(1-v)*temp(pi,pj) +(1-u)*v*temp(pi,pj+1)...
                    + u*(1-v)*temp(pi+1,pj) +u*v*temp(pi+1,pj+1);
    end
end
output = uint8(output);
figure
imshow(output)
end