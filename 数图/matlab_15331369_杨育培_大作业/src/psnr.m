function result = psnr(img1, img2)
if (ndims(img1) == 3)
    img1 = rgb2ycbcr(img1);
    img2 = rgb2ycbcr(img2);
    img1 = img1(:,:,1);
    img2 = img2(:,:,1);
end
[M,N] = size(img1);
img1 = double(img1);
img2 = double(img2);
sum = 0;
for i = 1:M
    for j = 1:N
        sum = sum + (img1(i,j) - img2(i,j))^2;
    end
end
MSE = sum / (M*N);
%disp(MSE);
psnr = 20 * log10(255/sqrt(MSE));
result = psnr;
disp(psnr);
end