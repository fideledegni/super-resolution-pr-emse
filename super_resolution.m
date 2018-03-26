function [S] = super_resolution(I, f, delta)
% super_resolution_grey(I, f, delta) Performs super-resolution on I by a factor f
% NB: delta is between 0 and 1 ans is used for edge correction.
% If delta == -1, no edge correction is performed

    if size(I,3)==3
        S = super_resolution_color(I, f, delta);
    elseif size(I,3)==1
        S = super_resolution_grey(I, f, delta);
    else
        S = 0;
        disp('Bad image format!!!');
    end
    