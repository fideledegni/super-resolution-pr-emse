function [ls] = least_square(P, Q)
% least_square(P, Q) Computes least square error between original data P and
% approximated (fitted) data Q

    S = (P - Q).^2;
    ls = sum(S(:));
    