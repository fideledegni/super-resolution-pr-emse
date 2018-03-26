function [R] = rec(n)
    if n^2 < 10
        R = 1;
    else
        R = rec(n-1) + rec(n-2);
    end