function filter2d_freq(I,filter)
%读取原图像
if isstr(I)
    img = imread(I);
end
[M,N] = size(img); %取出图像高度和宽度
[m,n] = size(filter); %取出滤波器高度和宽度
ori = double(img);
% 0填充图像矩阵和滤波器
P = 2*M;
Q = 2*N;
f = zeros(P,Q);
h = zeros(P,Q);
f(1:M,1:N) = img;
f(M+1:P,1:Q) = 0;
f(1:M,N+1:Q) = 0;
h(1:m,1:n) = filter;
h(m+1:P,1:Q) = 0;
h(1:m,n+1:Q) = 0;
f1 = double(f); %转为double类型便于计算
h1 = double(h);
s = 0;
h = 0;
%中心化图像和滤波器
for x=1:P
    for y=1:Q
        if rem(x+y,2)
           f1(x,y) = -f1(x,y);
           h1(x,y) = -h1(x,y);
        end
    end
end
%作图像和滤波器的傅里叶变化
for x=1:P
    for v=1:Q
        for y=1:Q
            s = s + f1(x,y) * exp((-1i) * 2 * pi * v * y / Q);
            h = h + h1(x,y) * exp((-1i) * 2 * pi * v * y / Q);
        end
        f2(x,v) = s;
        h2(x,v) = h;
        s = 0;
        h = 0;
    end
end
for u=1:P
    for v=1:Q
        for x=1:P
            s = s + f2(x,v) * exp((-1i) * 2 * pi * u * x / P);
            h = h + h2(x,v) * exp((-1i) * 2 * pi * u * x / P);
        end
        F(u,v) = s;
        H(u,v) = h;
        s = 0;
        h = 0;
    end
end
%作频率域乘积
for u=1:P
    for v=1:Q
        G(u,v) = H(u,v) * F(u,v);
    end
end
%作图像和滤波器的傅里叶反变换
for u=1:P
    for y=1:Q
        for v=1:Q
            s = s + G(u,v) * exp((1i) * 2 * pi * v * y / Q);
        end
        g1(u,y) = s;
        s = 0;
    end
end
for x=1:P
    for y=1:Q
        for u=1:P
            s = s + g1(u,y) * exp((1i) * 2 * pi * u * x / P) / P;
        end
        g2(x,y) = real(s); %取实部
        s = 0;
    end
end
%再次中心化
for x=1:P
    for y=1:Q
        if rem(x+y,2)
           g2(x,y) = -g2(x,y);
        end
    end
end
%截取M*N大小矩阵
for x=1:M
    for y=1:N
        g(x,y) = g2(x,y);
    end
end
%输出结果
figure
subplot(221)
imshow(img)%显示原图像
axis on
title(['原图像']);
max = 0;
for u=1:M
    for v=1:N
        if (g(u,v) > max)
            max = g(u,v);
        end
    end
end
scale = 256/max;
for u=1:M
    for v=1:N
        g(u,v) = g(u,v) * scale;
    end
end
%g = ori - g; 拉普拉斯算子使用该公式；如果算子中间像素为正数，请把‘-’变‘+’;
subplot(222)
imshow(uint8(g))%显示滤波后图像;
axis on
title(['滤波后图像']);