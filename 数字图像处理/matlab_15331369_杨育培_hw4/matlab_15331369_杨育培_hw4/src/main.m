function main
    %disp('����1ִ�е�һ����Ŀ������2ִ�еڶ�����Ŀ������3ִ�е�������Ŀ');
    a = input('����1ִ�е�һ����Ŀ������2ִ�еڶ�����Ŀ������3ִ�е�������Ŀ\n');
    flag = a;
    if flag == 1
        disp('�����˲�����С3��9��');
        n = input('');
        disp('������г��Qֵ��0Ϊ������ֵ��-1Ϊ���;�ֵ��-1.5Ϊ��г����ֵ');
        Q = input('');
        filt2d('..\hw4_input\task_1.png',n,Q);
    end
    if flag == 2
        disp('����1ִ�еڶ������һС�⣬����2ִ�еڶ�����ڶ�С�⣬����3ִ�еڶ��������С��');
        a = input('');
        denoising('..\hw4_input\task_2.png',a);
    end
    if flag == 3
        equalize_hist('..\hw4_input\task_3\69.png');
    end
end