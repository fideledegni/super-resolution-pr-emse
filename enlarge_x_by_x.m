function [M] = enlarge_x_by_x(I, x)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% enlarge_x_by_x(I, x) Performs a x-times duplication in both horizontal and
% vertical dimensions so that each single-pixel object in I now becomes  x*x in size

    [m,n] = size(I);
    M = zeros(x*m, x*n);
    
    for i=1:m
        for j=1:n
            M(x*(i-1)+1:x*i, x*(j-1)+1:x*j) = I(i,j);
        end
    end