function task4
img=imread('..\.\Set14\pepper.bmp');
if (ndims(img) == 3)
    img1 = img(:,:,1);
    img2 = img(:,:,2);
    img3 = img(:,:,3);
    [m,n] = size(img1);
    figure
    imshow(img);axis on
    title(['原图像 (大小： ',num2str(m),'*',num2str(n),')']);
    height = floor(1/3 * m);
    width = floor(1/3 * n);
    r = bicubic(img1,height,width);
    g = bicubic(img2,height,width);
    b = bicubic(img3,height,width);
    rgb = cat(3,r,g,b);
    rgb=uint8(rgb);
    [H,W] = size(rgb(:,:,1));
    figure
    imshow(rgb);axis on
    title(['缩放后的图像（大小： ',num2str(H),'*',num2str(W),')']);
    %imwrite(rgb,'C:\Users\Administrator\Desktop\数图\matlab_15331369_杨育培_hw5\proj_2017\Set15\pepper.bmp');
    nr = bicubic(r,m,n);
    ng = bicubic(g,m,n);
    nb = bicubic(b,m,n);
    nrgb = cat(3,nr,ng,nb);
    output=uint8(nrgb); %将矩阵转换成8位无符号整数
    [nH,nW] = size(output(:,:,1));
    figure
    imshow(output);axis on
    title(['缩放后的图像（大小： ',num2str(nH),'*',num2str(nW),')']);
    %imwrite(output,'C:\Users\Administrator\Desktop\数图\matlab_15331369_杨育培_hw5\proj_2017\Set15\npepper.bmp');
    psnr(img,output);
    ssim(img,output);
else
    [M,N] = size(img);
    figure
    imshow(img);axis on
    title(['原图像 (大小： ',num2str(M),'*',num2str(N),')']);
    g_height = floor(1/3 * M);
    g_width = floor(1/3 * N);
    H = bicubic(img,g_height,g_width);
    [h,w] = size(H);
    H = uint8(H);
    figure
    imshow(H);axis on
    title(['缩放后的图像（大小： ',num2str(h),'*',num2str(w),')']);
    nH = bicubic(H,M,N);
    [nh,nw] = size(nH);
    nH = uint8(nH);
    figure
    imshow(nH);axis on
    title(['缩放后的图像（大小： ',num2str(nh),'*',num2str(nw),')']);
    %imwrite(nH,'C:\Users\Administrator\Desktop\数图\matlab_15331369_杨育培_hw5\proj_2017\Set15\npepper.bmp');
    psnr(img,nH);
    ssim(img,nH);
end
end



