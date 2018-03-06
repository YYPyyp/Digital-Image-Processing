function result = bicubic(img, height, width)
[M,N] = size(img);
k = height/M;
img = double(img);
%拓宽矩阵，赋值，处理边界
temp = zeros(M+4,N+4);
%拷贝原矩阵
for x = 1:M
    for y = 1:N
        temp(x+2,y+2) = img(x,y);
    end
end
%边界处理
for y = 1:N
    temp(1,y+2) = img(1,y);
    temp(2,y+2) = img(1,y);
    temp(M+3,y+2) = img(M,y);
    temp(M+4,y+2) = img(M,y);
end
for x = 1:M
    temp(x+2,1) = img(x,1);
    temp(x+2,2) = img(x,1);
    temp(x+2,N+3) = img(x,N);
    temp(x+2,N+4) = img(x,N);
end
%边界点处理
temp(1,1) = img(1,1);temp(1,2) = img(1,1);temp(2,1) = img(1,1);temp(2,2) = img(1,1);
temp(1,N+3) = img(1,N);temp(1,N+4) = img(1,N);temp(2,N+3) = img(1,N);temp(2,N+4) = img(1,N);
temp(M+3,1) = img(M,1);temp(M+4,1) = img(M,1);temp(M+3,2) = img(M,1);temp(M+4,2) = img(M,1);
temp(M+3,N+3) = img(M,N);temp(M+3,N+4) = img(M,N);temp(M+4,N+3) = img(M,N);temp(M+4,N+4) = img(M,N);
%temp = padarray(img,[2 2],'replicate');
%利用双三次插值公式对新图象所有像素赋值

for i = 1:height
    ii = i/k;
    pi = floor(ii);
    u = ii - pi;
    pi = pi + 2;
    for j = 1:width
        %jj = j/k;
        jj = j*M/height;
        pj = floor(jj);
        v = jj - pj;
        pj = pj + 2;
        if (pj > N+4)
            pj = N+2;
        end
        result(i,j) = temp(pi-1,pj-1)*sw(1+u)*sw(1+v)+temp(pi-1,pj)*sw(1+u)*sw(v)+temp(pi-1,pj+1)*sw(1+u)*sw(1-v)+temp(pi-1,pj+2)*sw(1+u)*sw(2-v)+...
            temp(pi,pj-1)*sw(u)*sw(1+v)+temp(pi,pj)*sw(u)*sw(v)+temp(pi,pj+1)*sw(u)*sw(1-v)+temp(pi,pj+2)*sw(u)*sw(2-v)+...
            temp(pi+1,pj-1)*sw(1-u)*sw(1+v)+temp(pi+1,pj)*sw(1-u)*sw(v)+temp(pi+1,pj+1)*sw(1-u)*sw(1-v)+temp(pi+1,pj+2)*sw(1-u)*sw(2-v)+...
            temp(pi+2,pj-1)*sw(2-u)*sw(1+v)+temp(pi+2,pj)*sw(2-u)*sw(v)+temp(pi+2,pj+1)*sw(2-u)*sw(1-v)+temp(pi+2,pj+2)*sw(2-u)*sw(2-v);
    end
end

end
