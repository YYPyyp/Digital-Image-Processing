function main
    %disp('输入1执行第一道题目，输入2执行第二道题目，输入3执行第三道题目');
    a = input('输入1执行第一道题目，输入2执行第二道题目，输入3执行第三道题目\n');
    flag = a;
    if flag == 1
        disp('输入滤波器大小3或9；');
        n = input('');
        disp('输入逆谐波Q值：0为算数均值，-1为调和均值，-1.5为逆谐波均值');
        Q = input('');
        filt2d('..\hw4_input\task_1.png',n,Q);
    end
    if flag == 2
        disp('输入1执行第二道题第一小题，输入2执行第二道题第二小题，输入3执行第二道题第三小题');
        a = input('');
        denoising('..\hw4_input\task_2.png',a);
    end
    if flag == 3
        equalize_hist('..\hw4_input\task_3\69.png');
    end
end