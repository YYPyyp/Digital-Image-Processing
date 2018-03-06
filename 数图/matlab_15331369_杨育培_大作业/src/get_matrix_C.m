function C = get_matrix_C(hr_matrix,lr_matrix,K)
%lr_matrix = lr_matrix';
%hr_matrix = hr_matrix';
for i = 1:K
    lr_matrix(:,:,i) = lr_matrix(:,:,i)';
    hr_matrix(:,:,i) = hr_matrix(:,:,i)';
    C(:,:,i) = hr_matrix(:,:,i) / lr_matrix(:,:,i);
end
end