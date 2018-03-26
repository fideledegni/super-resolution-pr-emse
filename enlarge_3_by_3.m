function [M] = enlarge_3_by_3(I)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% enlarge_3_by_3(I) Performs a 3-times duplication in both horizontal and
% vertical dimensions so that each single-pixel object in I now becomes  3*3 in size

    M = enlarge_x_by_x(I, 3);