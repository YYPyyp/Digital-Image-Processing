function get_HR_img
tic
load('lr_clustercenter.mat'); %512 * 45
lr_clustercenter = lr_clustercenter';
load('matrix_C.mat'); %81 * 45
s = 3;
sigma = 1.2; %1.2 效果最好
lr_patchsize = 7;
HR_img = imread('..\.\Set14\pepper.bmp');
figure
imshow(HR_img);axis on
title('原图像');

%灰度图片直接生成lr图像
if (ndims(HR_img) ~= 3)
    gray = HR_img;
    [M,N] = size(HR_img);
    M_mod = mod(M,s);
    N_mod = mod(N,s);
    if (M_mod == 1)
        HR_img = padarray(HR_img,[0,1],'replicate');
    end
    if (M_mod == 2)
        HR_img = padarray(HR_img,[0,1],'replicate','post');
    end
    if (N_mod == 1)
        HR_img = padarray(HR_img,[1,0],'replicate');
    end
    if (N_mod == 2)
        HR_img = padarray(HR_img,[1,0],'replicate','post');
    end
    gray = HR_img;
    [~, lr_img] = generate_LR_image(gray,s,sigma);
end
%彩色图片转ycbcr,再取y通道生成lr图像
if (ndims(HR_img) == 3)
    ycbcr_img = rgb2ycbcr(HR_img);
    HR_img_y = ycbcr_img(:,:,1);
    [M,N] = size(HR_img_y);
    M_mod = mod(M,s);
    N_mod = mod(N,s);
    if (M_mod == 1)
        HR_img_y = padarray(HR_img_y,[0,1],'replicate');
    end
    if (M_mod == 2)
        HR_img_y = padarray(HR_img_y,[0,1],'replicate','post');
    end
    if (N_mod == 1)
        HR_img_y = padarray(HR_img_y,[1,0],'replicate');
    end
    if (N_mod == 2)
        HR_img_y = padarray(HR_img_y,[1,0],'replicate','post');
    end
    [~, lr_img] = generate_LR_image(HR_img_y,s,sigma);
end
%对lr图像作延拓
lr_img = padarray(lr_img,[2 2],'replicate');
[lr_height,lr_width] = size(lr_img);
%disp(lr_height);
%disp(lr_width);
lr_patchnum = (lr_height-lr_patchsize+1)*(lr_width-lr_patchsize+1);
lr_patchsize_half = (lr_patchsize-1)/2;
Num = 1;
lr_patch = zeros(lr_patchsize^2-4, lr_patchnum);
lr_patchcenter = zeros(2, lr_patchnum);
select_pixels_exclude_corner = [2:6 8:42 44:48];%去掉lr_patch四个角
for i = lr_patchsize_half+1 : lr_height-lr_patchsize_half
    for j = lr_patchsize_half+1 : lr_width-lr_patchsize_half
        lr_patchcenter(:,Num) = [i;j];  %记录每一个lr小块的中心点位置
        temp = lr_img(i-lr_patchsize_half:i+lr_patchsize_half,j-lr_patchsize_half:j+lr_patchsize_half);
        lr_patch(:,Num) = temp(select_pixels_exclude_corner);
        Num = Num+1;
    end
end
[~, lr_patchnum] = size(lr_patch);
lr_feature = zeros(45,lr_patchnum);
if (ndims(HR_img) == 3)
    [height,width] = size(HR_img_y);
end
if (ndims(HR_img) ~= 3)
    [height,width] = size(HR_img);
end
patch_overlap = zeros(height,width); %构造hr_img时重叠的像素取均值
hr_img = zeros(height,width); %输出的hr图像
[~,lr_clustercenter_col] = size(lr_clustercenter); %kmeans得到的各个类的质心矩阵
for i = 1:lr_patchnum
    temp = lr_patch(:,i);
    lr_patchmean = mean(temp);
    lr_feature(:,i) = temp-lr_patchmean;
    for j = 1:lr_clustercenter_col
        lr_clustercenter(:,j) = lr_clustercenter(:,j)-lr_feature(:,i);
    end
    lr_clustercenter = lr_clustercenter.^2;
    distance(1:lr_clustercenter_col) = sum(lr_clustercenter(:,1:lr_clustercenter_col));
    [~,min_col] = min(distance);
    hr_patch(:,i) = C(:,:,min_col) * lr_feature(:,i);
    hr_patch(:,i) = hr_patch(:,i) + lr_patchmean;
    row = lr_patchcenter(1,i)-2;
    col = lr_patchcenter(2,i)-2;
    %构造hr_img
    hr_leftup = (row-2)*s+1;
    hr_rightup = (row+1)*s;
    hr_leftdown = (col-2)*s+1;
    hr_rightdown = (col+1)*s;
    hr_img(hr_leftup:hr_rightup,hr_leftdown:hr_rightdown) = reshape(hr_patch(:,i),[9,9]) + hr_img(hr_leftup:hr_rightup,hr_leftdown:hr_rightdown);
    patch_overlap(hr_leftup:hr_rightup,hr_leftdown:hr_rightdown) = patch_overlap(hr_leftup:hr_rightup,hr_leftdown:hr_rightdown)+1;
end
%重叠像素求均值
hr_img = uint8(hr_img ./patch_overlap);
if (ndims(HR_img) == 3)
    hr_img = hr_img(1:M,1:N);
end
if (ndims(HR_img) == 3)
HR_img_cb = ycbcr_img(:,:,2);
HR_img_cr = ycbcr_img(:,:,3);
HR_img_cb_s = bicubic(HR_img_cb,floor(height/3),floor(width/3));
HR_img_cr_s = bicubic(HR_img_cr,floor(height/3),floor(width/3));
HR_img_cb_l = bicubic(HR_img_cb_s,floor(height),floor(width));
HR_img_cr_l = bicubic(HR_img_cr_s,floor(height),floor(width));
HR_img_cb_l = HR_img_cb_l(1:M,1:N);
HR_img_cr_l = HR_img_cr_l(1:M,1:N);
result = cat(3,hr_img,HR_img_cb_l,HR_img_cr_l);
result = ycbcr2rgb(result);
figure
imshow(result);
(psnr(HR_img, result));
(ssim(HR_img, result));
end
if (ndims(HR_img) ~= 3)
    result = hr_img;
    figure
    imshow(result);
    (psnr(HR_img, result));
    (ssim(HR_img, result));
end
toc
end