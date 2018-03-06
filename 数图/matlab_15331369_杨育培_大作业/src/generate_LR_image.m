function [t_img, lr_img] = generate_LR_image(hr_img,s,sigma)
hr_img = double(hr_img);
[row,col] = size(hr_img);
mod_row = mod(row,s);
mod_col = mod(col,s);
t_row = row - mod_row;
t_col = col - mod_col;
t_img = hr_img(1:t_row, 1:t_col);
lr_row = t_row / s;
lr_col = t_col / s;
%高斯滤波
kernelsize = ceil(sigma * 3)*2+1;
n=floor((kernelsize+1)/2);%计算图象中心   
for i=1:kernelsize   
    for j=1:kernelsize
      window(i,j) =exp(-((i-n)^2+(j-n)^2)/(2*sigma^2));
    end
end
window = window/sum(sum(window));
temp = t_img;
for i=1:t_row-kernelsize+1
    for j=1:t_col-kernelsize+1
        c=t_img(i:i+(kernelsize-1),j:j+(kernelsize-1)).*window;
        temp(i+round((kernelsize-1)/2),j+round((kernelsize-1)/2)) = sum(sum(c));     
    end
end
lr_img = double(bicubic(temp,lr_row,lr_col));
end

