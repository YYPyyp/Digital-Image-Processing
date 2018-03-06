function denoising(I,flag)
%¶ÁÈ¡Ô­Í¼Ïñ
if isstr(I)
    img = imread(I);
end
img = rgb2gray(img);
[M,N] = size(img);
if flag == 1
    img1 = double(img);
    mean = 0;
    std = 40;
    g_noise = zeros(M,N);
    gaussian = mean + std .* randn(M,N);
    for i = 1:M
        for j = 1:N
            g_noise(i,j) = img1(i,j) + gaussian(i,j);
        end
    end
    g_noise = uint8(g_noise);
    figure
    subplot(221)
    imshow(g_noise)
    axis on
    title(['¸ßË¹ÔëÉùÍ¼Ïñ']);
    Q=0;
    n=3;
    temp1=double(g_noise);
    temp2=temp1;
    temp3=temp1;
    temp4=temp1;
    for i=1:M-n+1
        for j=1:N-n+1
            c=temp1(i:i+(n-1),j:j+(n-1));
            temp2(i+(n-1)/2,j+(n-1)/2) = sum(c(:).^(Q+1))/sum(c(:).^(Q));
            temp3(i+(n-1)/2,j+(n-1)/2) = prod(c(:).^(1/numel(c)));
            temp = sort(c(:));
            temp4(i+(n-1)/2,j+(n-1)/2) = temp((numel(temp)+1)/2);
        end
    end
    denoising1=uint8(temp2);
    denoising2=uint8(temp3);
    denoising3=uint8(temp4);
    subplot(222)
    imshow(denoising1)
    axis on
    title(['ËãÊý¾ùÖµÂË²¨Í¼Ïñ']);
    subplot(223)
    imshow(denoising2)
    axis on
    title(['¼¸ºÎ¾ùÖµÂË²¨Í¼Ïñ']);
    subplot(224)
    imshow(denoising3)
    axis on
    title(['ÖÐÖµÂË²¨Í¼Ïñ']);
end
if flag == 2
    a = 0; 
    b = 0.2; 
    x = rand(M,N); 
    salt_noise = img; 
    salt_noise(find(x<a)) = 0; 
    salt_noise(find(x > a & x<(a+b))) = 1;
    salt_noise = uint8(salt_noise);
    figure
    subplot(221)
    imshow(salt_noise);
    axis on
    title(['½·ÑÎÔëÉùÍ¼Ïñ']);
    Q1=-1;
    Q2=1.5;
    Q3=-1.5;
    n=3;
    temp1=double(salt_noise);
    temp2=temp1;
    temp3=temp1;
    temp4=temp1;
    for i=1:M-n+1
        for j=1:N-n+1
            c=temp1(i:i+(n-1),j:j+(n-1));
            temp2(i+(n-1)/2,j+(n-1)/2) = sum(c(:).^(Q1+1))/sum(c(:).^(Q1));
            temp3(i+(n-1)/2,j+(n-1)/2) = sum(c(:).^(Q2+1))/sum(c(:).^(Q2));
            temp4(i+(n-1)/2,j+(n-1)/2) = sum(c(:).^(Q3+1))/sum(c(:).^(Q3));
        end
    end
    denoising1=uint8(temp2);
    denoising2=uint8(temp3);
    denoising3=uint8(temp4);
    subplot(222)
    imshow(denoising1)
    axis on
    title(['µ÷ºÍ¾ùÖµÂË²¨Í¼Ïñ']);
    subplot(223)
    imshow(denoising2)
    axis on
    title(['ÄæÐ³²¨¾ùÖµÂË²¨Í¼Ïñ£¬Q=1.5']);
    subplot(224)
    imshow(denoising3)
    axis on
    title(['ÄæÐ³²¨¾ùÖµÂË²¨Í¼Ïñ£¬Q=-1.5']);
end
if flag == 3
    a = 0.2; 
    b = 0.2; 
    x = rand(M,N); 
    pepper_salt = img; 
    pepper_salt(find(x<a)) = 0; 
    pepper_salt(find(x > a & x<(a+b))) = 1;
    pepper_salt = uint8(pepper_salt);
    figure
    subplot(231)
    imshow(pepper_salt);
    axis on
    title(['½·ÑÎÔëÉùÍ¼Ïñ']);
    Q=0;
    n=3;
    temp1=double(pepper_salt);
    temp2=temp1;
    temp3=temp1;
    temp4=temp1;
    temp5=temp1;
    temp6=temp1;
    for i=1:M-n+1
        for j=1:N-n+1
            c=temp1(i:i+(n-1),j:j+(n-1));
            temp2(i+(n-1)/2,j+(n-1)/2) = sum(c(:).^(Q+1))/sum(c(:).^(Q));
            temp3(i+(n-1)/2,j+(n-1)/2) = prod(c(:).^(1/numel(c)));
            temp4(i+(n-1)/2,j+(n-1)/2) = max(c(:));
            temp5(i+(n-1)/2,j+(n-1)/2) = min(c(:));
            temp = sort(c(:));
            temp6(i+(n-1)/2,j+(n-1)/2) = temp((numel(temp)+1)/2);
        end
    end
    denoising1=uint8(temp2);
    denoising2=uint8(temp3);
    denoising3=uint8(temp4);
    denoising4=uint8(temp5);
    denoising5=uint8(temp6);
    subplot(232)
    imshow(denoising1)
    axis on
    title(['ËãÊý¾ùÖµÂË²¨Í¼Ïñ']);
    subplot(233)
    imshow(denoising2)
    axis on
    title(['¼¸ºÎ¾ùÖµÂË²¨Í¼Ïñ']);
    subplot(234)
    imshow(denoising3)
    axis on
    title(['×î´óÖµÂË²¨Í¼Ïñ']);
    subplot(235)
    imshow(denoising4)
    axis on
    title(['×îÐ¡ÖµÂË²¨Í¼Ïñ']);
    subplot(236)
    imshow(denoising5)
    axis on
    title(['ÖÐÖµÂË²¨Í¼Ïñ']);
end