function [lr_clustercenter,C] = cluster(lr_features,hr_features,K)
inv_lr_features = lr_features';
[N1,P1] = size(inv_lr_features);
num_iteration = 400;
num_cluster = K;
opts = statset('Display','iter','MaxIter',num_iteration,'UseParallel',1);
[IDX, lr_C] = kmeans(inv_lr_features,num_cluster,'options',opts);
lr_clustercenter = lr_C;
%save('lr_clustercenter.mat','lr_clustercenter');
%{
lr_clustercenter = lr_clustercenter';
[~,col] = size(select_lr_patch_Cmatrix);
[~,lr_clustercenter_col] = size(lr_clustercenter);
new_IDX = zeros(col,1);
for i = 1:col
    temp = lr_clustercenter;
    for j = 1:lr_clustercenter_col
        temp(:,j) = temp(:,j)-select_lr_patch_Cmatrix(:,i);
    end
    temp = temp.^2;
    distance(1:lr_clustercenter_col) = sum(temp(:,1:lr_clustercenter_col));
    [~,min_col] = min(distance);
    new_IDX(i) = min_col;
end
%}
for i = 1:K
    %C(:,:,i) = select_hr_patch_Cmatrix(:,new_IDX == i) / select_lr_patch_Cmatrix(:,new_IDX == i);
    C(:,:,i) = hr_features(:,IDX == i) / lr_features(:,IDX == i);
end
end