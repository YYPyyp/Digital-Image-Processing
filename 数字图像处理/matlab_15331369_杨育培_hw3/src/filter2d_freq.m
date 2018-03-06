function filter2d_freq(I,filter)
%��ȡԭͼ��
if isstr(I)
    img = imread(I);
end
[M,N] = size(img); %ȡ��ͼ��߶ȺͿ��
[m,n] = size(filter); %ȡ���˲����߶ȺͿ��
ori = double(img);
% 0���ͼ�������˲���
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
f1 = double(f); %תΪdouble���ͱ��ڼ���
h1 = double(h);
s = 0;
h = 0;
%���Ļ�ͼ����˲���
for x=1:P
    for y=1:Q
        if rem(x+y,2)
           f1(x,y) = -f1(x,y);
           h1(x,y) = -h1(x,y);
        end
    end
end
%��ͼ����˲����ĸ���Ҷ�仯
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
%��Ƶ����˻�
for u=1:P
    for v=1:Q
        G(u,v) = H(u,v) * F(u,v);
    end
end
%��ͼ����˲����ĸ���Ҷ���任
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
        g2(x,y) = real(s); %ȡʵ��
        s = 0;
    end
end
%�ٴ����Ļ�
for x=1:P
    for y=1:Q
        if rem(x+y,2)
           g2(x,y) = -g2(x,y);
        end
    end
end
%��ȡM*N��С����
for x=1:M
    for y=1:N
        g(x,y) = g2(x,y);
    end
end
%������
figure
subplot(221)
imshow(img)%��ʾԭͼ��
axis on
title(['ԭͼ��']);
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
%g = ori - g; ������˹����ʹ�øù�ʽ����������м�����Ϊ��������ѡ�-���䡮+��;
subplot(222)
imshow(uint8(g))%��ʾ�˲���ͼ��;
axis on
title(['�˲���ͼ��']);