function [RMSE] = compute_rmse(imA, imT)
% imA is the approximated image
% imT is the ground truth image

    if size(imA, 3) == 3
%         imA = rgb2ycbcr(imA);
%         imA = imA(:, :, 1); % Luma
        % or
        imA = rgb2hsv(imA);
        imA = imA(:, :, 3); % Luminance
    end
    
    if size(imT, 3) == 3
%         imT = rgb2ycbcr(imT);
%         imT = imT(:, :, 1);
        % or
        imT = rgb2hsv(imT);
        imT = imT(:, :, 3); % Luminance
    end
    
    S = (double(imA) - double(imT)).^2;
    NUM = sum(S(:));
    
    TS = imT.^2;
    DENOM = sum(TS(:));
    RMSE = sqrt(NUM/DENOM);
