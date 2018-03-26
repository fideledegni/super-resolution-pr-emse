function [EC, image] = edge_correction(I, B, C, f, delta)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% edge_correction(I, C, f, delta) Performs edge correction before multiplying critical data
% points coordinates in I by the desired factor f
% B is the completed (closed) boundaries (with critical data points only) of objects in I
% C is the Canny-edge image from the original gray-scale image
% f is the the factor of enlargement
%
% A window of size +-6 (13*13) is centered at the current critical data point, is
% formed to obtain a patch from the edge image C
% Raster scan is performed to locate the edge pixels in the patch. Same
% procedure is done on the critical data point image to locate it in the
% patch. If there are no edge pixels, the current critical data point is skipped.
% Otherwise, each edge pixel inside the patch has to be checked whether it is a
% candidate location for a coordinate correction. To do this, the Euclidean distances 
% between all critical data points and all edge pixels are measured. The criteria for 
% an edge pixel to be the valid candidate is that the distance from it to the current 
% critical data point is not bigger than the distance to any of other
% critical data points plus a pre-defined overshot delta
% When all edge pixels are checked, only valid edge pixels are kept in the
% canditate list. From the list of valid candidates, the closest one to the
% current critical data point is selected as the location for the
% coordinate correction. If all the edge pixels are not valid, no
% correction is done for that critical data point
% NB: delta is between 0 and 1
% If delta == -1, no edge correction is performed
%
% % B will be transformed into EC (enlargement by f)

    [m,n] = size(I);
    image = zeros(m*4/3, n*4/3); % m and n are multiples of 3
    nb = length(B); % number of closed boundaries
    %=====================================================
    % If no edge correction is required, i.e. delta == -1
    if delta == -1
        for k=1:nb
            BD = B{k};
            nbp = length(BD); % number of points in boundary
            for x=1:nbp
                i = BD(x,1); j = BD(x,2);
                image(round(i*f/3), round(j*f/3)) = 1;
                BD(x,:) = [round(i*f/3), round(j*f/3)];
            end
            B{k} = BD;
        end
        EC = B;
        return % Just terminate here
    end
    %-----------------------------------------------------   
    
    
    vide = zeros(13,13);
    for k=1:nb
        BD = B{k};
        nbp = length(BD); % number of points in boundary
        for x=1:nbp
            i = BD(x,1); j = BD(x,2);
            CPCD = vide; % Current patch containing critical data points
            CPEP = vide; % Current patch containing edge pixels from C
            % We need to prevent out of range indexes:
            i_m = max(1, i-6);
            i_M = min(m, i+6);
            j_m = max(1, j-6);
            j_M = min(n, j+6);
            % Note that the current critical data point is at position
            % (7,7) in CPCD
            CPCD(i_m+7-i:i_M+7-i, j_m+7-j:j_M+7-j) = I(i_m:i_M, j_m:j_M);
            CPEP(i_m+7-i:i_M+7-i, j_m+7-j:j_M+7-j) = C(i_m:i_M, j_m:j_M);

            %  If there are no edge pixels, the current critical data
            %  point is skipped and its coordinates are just multiplied
            %  by the factor f (and divided by 3)
            if isequal(CPEP, vide)
                image(round(i*f/3), round(j*f/3)) = 1;
                BD(x,:) = [round(i*f/3), round(j*f/3)];
            % If there are pixel edges, we compute the edge pixel
            % candidates
            else
                EPC = candidates(CPEP, CPCD, delta); % edge pixel candidates
                % If no edge pixel is valid candidate, the current
                % critical data point  is skipped and its coordinates
                % are just multiplied by the factor f (and divided by 3)
                if isempty(EPC)
                    image(round(i*f/3), round(j*f/3)) = 1;
                    BD(x,:) = [round(i*f/3), round(j*f/3)];
                % From the list of valid candidates, the closest one to
                % the current  critical data point is selected as the
                % location for the coordinate correction
                else
                    nb_candidates = size(EPC, 1);
                    i_corr = EPC(1,1);
                    j_corr = EPC(1,2);
                    d_curr = (i_corr-7)^2 + (j_corr-7)^2;
                    for nb=1:nb_candidates
                        d_new = (EPC(nb,1)-7)^2 + (EPC(nb,2)-7)^2;
                        if d_new <= d_curr
                            d_curr = d_new;
                            i_corr = EPC(nb,1);
                            j_corr = EPC(nb,2);
                        end
                    end
                    % We denote u the chosen valid edge pixel (i_u and j_u its coordinates)
                    i_u = i_corr + i - 7;
                    j_u = j_corr + j - 7;
                    f_corr = f*(C(i_u,j_u))^2;
                    if f_corr >= 1
                        i_final = round(i_u*f/3 - (((i_u-i)*f/3)/f_corr));
                        j_final = round(j_u*f/3 - (((j_u-j)*f/3)/f_corr));
                        image(i_final, j_final) = 1;
                        BD(x,:) = [i_final, j_final];
                    else
                        image(round(i*f/3), round(j*f/3)) = 1;
                        BD(x,:) = [round(i*f/3), round(j*f/3)];
                    end
                end
            end
        end
        B{k} = BD;
    end
    
    EC = B;
    
    