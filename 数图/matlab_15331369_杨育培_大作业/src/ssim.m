function result = ssim(img1, img2)
if (ndims(img1) == 3)
    img1 = rgb2ycbcr(img1);
    img2 = rgb2ycbcr(img2);
    img1 = img1(:,:,1);
    img2 = img2(:,:,1);
end
[M,N] = size(img1);
img1 = double(img1);
img2 = double(img2);
f = max(1,round(min(M,N)/256));
if(f>1)
    temp1 = img1;
    temp2 = img2;
    lpf = ones(f,f);
    lpf = lpf/sum(lpf(:));
    for i=1:M-f+1
        for j=1:N-f+1
            c1=temp1(i:i+(f-1),j:j+(f-1));
            c2=temp2(i:i+(f-1),j:j+(f-1));
            img1(i+round((f-1)/2),j+round((f-1)/2)) = sum(sum(c1.*lpf));
            img2(i+round((f-1)/2),j+round((f-1)/2)) = sum(sum(c2.*lpf));
        end
    end
    img1 = img1(1:f:end,1:f:end);
    img2 = img2(1:f:end,1:f:end);
end
window = gaussion(11,1.5);
w_size = 11;
%disp(window);
window = window/sum(sum(window));
[M1,N1] = size(img1);
mu1 = zeros(M1-w_size+1,N1-w_size+1);
mu2 = zeros(M1-w_size+1,N1-w_size+1);
for i=1:M1-w_size+1
    for j=1:N1-w_size+1
        c1=img1(i:i+(w_size-1),j:j+(w_size-1)).*window;
        c2=img2(i:i+(w_size-1),j:j+(w_size-1)).*window;
        mu1(i,j) = sum(sum(c1));
        mu2(i,j) = sum(sum(c2));
    end
end
mu1_sq = mu1.*mu1;
mu2_sq = mu2.*mu2;
mu1_mu2 = mu1.*mu2;

temp_1 = img1.*img1;
temp_2 = img2.*img2;
temp_12 = img1.*img2;
for i=1:M1-w_size+1
    for j=1:N1-w_size+1
        c1=temp_1(i:i+(w_size-1),j:j+(w_size-1)).*window;
        c2=temp_2(i:i+(w_size-1),j:j+(w_size-1)).*window;
        c12=temp_12(i:i+(w_size-1),j:j+(w_size-1)).*window;
        mu_1(i,j) = sum(sum(c1));
        mu_2(i,j) = sum(sum(c2));
        mu_12(i,j) = sum(sum(c12));
    end
end
sigma1_sq = mu_1 - mu1_sq;
sigma2_sq = mu_2 - mu2_sq;
sigma12 = mu_12 - mu1_mu2;
C1 = (0.01*255)^2;
C2 = (0.03*255)^2;
ssim_map = ((2*mu1_mu2 + C1).*(2*sigma12 + C2))./((mu1_sq + mu2_sq + C1).*(sigma1_sq + sigma2_sq + C2));
mssim = mean2(ssim_map);
result = mssim;
disp(result);
end