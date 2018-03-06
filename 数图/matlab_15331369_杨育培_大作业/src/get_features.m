function [lr_feature,hr_feature] = get_features(lr_patch,hr_patch,lrpatch_size,hrpatch_center_size)
mean_lr_patch = mean(lr_patch);
mean_mat_hr = repmat(mean_lr_patch, [hrpatch_center_size^2, 1]);
mean_mat_lr = repmat(mean_lr_patch, [lrpatch_size^2 - 4, 1]);
hr_feature = hr_patch - mean_mat_hr;
lr_feature = lr_patch - mean_mat_lr;
end