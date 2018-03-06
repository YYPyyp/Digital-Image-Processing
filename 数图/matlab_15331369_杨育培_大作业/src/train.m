function train
K = 512;
s = 3;
sigma = 1.2;
file_path = '..\.\Train\';  %图像文件夹路径
img_path_list = dir(strcat(file_path,'*.jpg'));%获取该文件夹中所有jpg格式的图像
img_num = length(img_path_list);%获取图像总数量
all_lr_patch = [];
all_hr_patch = [];
disp(img_num);
if img_num > 0 %有满足条件的图像
   for j = 1:img_num %逐一读取图像
       image_name = img_path_list(j).name;% 图像名
       HR_img = imread(strcat(file_path,image_name));
       HR_img = rgb2ycbcr(HR_img);
       HR_img_y = HR_img(:,:,1);
       [lr_patch, hr_patch] = get_patch_from_HR(HR_img_y,s,sigma,7,9);
       [lr_feature,hr_feature] = get_features(lr_patch,hr_patch,7,9);
       all_lr_patch = cat(2,all_lr_patch,lr_feature);
       all_hr_patch = cat(2,all_hr_patch,hr_feature);
       [all_lr_patch_size,all_lr_patch_num] = size(all_lr_patch);
       if (all_lr_patch_num > 200000)
           break;
       end
   end
end
select_lr_patch = all_lr_patch(:,1:200000);
select_hr_patch = all_hr_patch(:,1:200000);
%select_lr_patch_Cmatrix = all_lr_patch(:,2000001:400000);
%select_hr_patch_Cmatrix = all_hr_patch(:,2000001:400000);
%save('lr_patch.mat','select_lr_patch');
%save('hr_patch.mat','select_hr_patch');
%[lr_clustercenter,C] = cluster(select_lr_patch,select_hr_patch,K,select_lr_patch_Cmatrix,select_hr_patch_Cmatrix);
[lr_clustercenter,C] = cluster(select_lr_patch,select_hr_patch,K);
save('lr_clustercenter.mat','lr_clustercenter');
save('matrix_C.mat','C');
end



