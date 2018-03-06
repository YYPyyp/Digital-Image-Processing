function A = sw(w1)
w=abs(w1);
if (w >= 0 && w < 1)
   A = 1.5 * w^3 - 2.5 * w^2 + 1;
elseif (w >= 1 && w < 2)
        A = -0.5 * w^3 + 2.5 * w^2 - 4 * w + 2;
    else
        A = 0;
end
end
