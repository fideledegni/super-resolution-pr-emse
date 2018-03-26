function [C] = curve_fitting(EC, BP, f)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% curve_fitting(EC, BP, f) Performs a least square cubic Bezier fitting on the
% critical data points in EC (f is the enlargement factor)
% PB is a cell structure such that BP{k} is a vector with BP{k}(i) = 1 if
% EC{k}(i) is a breaking point and  BP{k}(i) = 0 otherwise

    nb = length(EC); % number of closed boundaries
    C = cell(nb, 1);
    for k=1:nb
        BD = EC{k}; % current boundary
        nbp = length(BD); % number of points in boundary
        CK = zeros((f^2)*(nbp-1)+1, 2); % multiply number of points by (f^2)
        CK(1,:) = BD(1,:);
        ind = 2; % CK indexes
        
        pos = find(BP{k}==1); % breaking points positions
        tot = length(pos);
        for i=1:(tot-1)
            debut = pos(i); fin = pos(i+1); % sector delimitation
            sect = BD(debut:fin,:); % the actual sector
            sect_bezier = bezier_lsf(sect, f); % bezier least square fitted sector
            nbp_sect = length(sect_bezier);
            CK(ind:(ind+nbp_sect-2),:) = sect_bezier(2:end,:);
            ind = ind + nbp_sect - 1;
        end
        
        C{k} = CK;
    end
