function [lr_patch, hr_patch] = get_patch_from_HR(hr_img,s,sigma,lrpatch_size,hrpatch_center_size)
[hr_img, lr_img] = generate_LR_image(hr_img,s,sigma);
[lr_row, lr_col] = size(lr_img);
num_of_lrpatch = (lr_row - lrpatch_size + 1) * (lr_col - lrpatch_size + 1);%计算lrpatch的数目
pixels_of_lrpatch = lrpatch_size^2 - 4;%每个lrpatch为45*1的列向量
lr_patch = zeros(pixels_of_lrpatch, num_of_lrpatch);
lr_patchsizeh = (lrpatch_size-1)/2;
lr_num = 1;
num_of_hrpatch = num_of_lrpatch;%lr_patch,hr_patch，数目一样
pixels_of_hrpatch = hrpatch_center_size^2;  %每个hrpatch为81*1的列向量
hr_patch = zeros(pixels_of_hrpatch, num_of_hrpatch);
select_pixels_exclude_corner = [2:6 8:42 44:48];
%注意lr_patch,hr_patch一一对应
for i = lr_patchsizeh+1:lr_row-lr_patchsizeh
    for j = lr_patchsizeh+1:lr_col-lr_patchsizeh
        temp1 = lr_img(i-lr_patchsizeh:i+lr_patchsizeh,j-lr_patchsizeh:j+lr_patchsizeh);
        lr_patch(:, lr_num) = temp1(select_pixels_exclude_corner);
        hr_leftup = (i-2) * s + 1;hr_rightup = (i+1) * s;
        hr_leftdown = (j-2) * s + 1;hr_rightdown = (j+1) * s;
        temp2 = hr_img(hr_leftup:hr_rightup,hr_leftdown:hr_rightdown);
        hr_patch(:,lr_num) = temp2(:);
        lr_num = lr_num+1;
    end
end
end

%{
mean_inten = mean(lr_patch);
mean_mat_hr = repmat(mean_inten, [hrpatch_center_size^2, 1]);
mean_mat_lr = repmat(mean_inten, [lrpatch_size^2 - 4, 1]);
hr_patch = hr_patch - mean_mat_hr;
lr_patch = lr_patch - mean_mat_lr;
%}
%hr_patch = hr_patch';
%lr_patch = lr_patch';