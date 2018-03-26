function [CS] = super_resolution_color(Ic, f, delta)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% super_resolution_color(I, f, delta) Performs super-resolution on RGB image I by a factor f
% NB: delta is between 0 and 1 ans is used for edge correction.
% If delta == -1, no edge correction is performed
%
% Note: The luminance is used to obtain the edge image since the Canny-edge
% detector is applied on gray-scale images only. Each RGB channel is
% processed independently, and a common edge image is used for all channels
% as edges must be consistent with each other

    [m, n, ~] = size(Ic);
    CS = uint8(zeros(f*m, f*n, 3));
    
%     II = rgb2ycbcr(Ic);
%     II = II(:, :, 1); % Luma
    % or
    II = rgb2hsv(Ic);
    II = II(:,:,3); % Luminance
    
    C = canny_edge(imresize(II,3)); % Edge image used for edge correction
    
    wb = waitbar(0, '0% completed', 'Name', 'Super resolving image...', 'CreateCancelBtn', 'setappdata(gcbf,''canceling'',1)');
    setappdata(wb, 'canceling', 0);
    for canal=1:3
        I = Ic(:,:,canal);
        I3 = enlarge_3_by_3(I);
        S = uint8(zeros(f*m, f*n));
        % If parfor is used...
        % TD = cell(1,255); % Will contain the threshold decomposition of 3*I
        
        for k=1:255
            % Check for clicked Cancel button
            if getappdata(wb, 'canceling')
                break
            end
            T = I3 >= k;
            if max(T(:)) == 0 % If completely black, i.e. == zeros
                % If parfor is used...
                % TD{k} = zeros(f*m, f*n);
                T = uint8(zeros(f*m, f*n));
            elseif min(T(:)) == 1 % If completely white, i.e. == ones
                % If parfor is used...
                % TD{k} = ones(f*m, f*n);
                T = uint8(ones(f*m, f*n));
            else
                [TB, boundaries] = extract_boundary(T);
                [TC, Cboundaries] = extract_critical_data_points(TB, boundaries);
                [E, ~] = edge_correction(TC,Cboundaries, C, f, delta); % Critical data points after enlargement
                BP = breaking_points(E); % breaking points
                fitted = curve_fitting(E, BP, f); % curve fitted with cubic Bezier
                CF = uint8(zeros(f*m, f*n)); % the BW image
                nb = length(fitted); % number of closed boundaries
                for q=1:nb
                    BD = fitted{q};
                    nbp = length(BD); % number of points in boundary
                    for x=1:nbp
                        i = round(BD(x,1)); j = round(BD(x,2));
                        % Some prudence just in case!
                        if i<1, i=1; end
                        if j<1, j=1; end
                        if i>f*m, i=f*m; end
                        if j>f*n, j=f*n; end
                        CF(i,j) = 1;
                    end
                end
                
                T = imfill(CF,'holes');
                % If parfor is used...
                % TD{k} = T;
            end
            
            S = S + T;
            waitbar((255*(canal-1)+k)/(3*255), wb, sprintf('%d%% completed', round(100*(255*(canal-1)+k)/(3*255))));
        end
          % If parfor is used...
%         % Add up all binary images
%         for i=1:255
%             S = S + TD{i};
%         end
        
        CS(:,:,canal) = S;
    end
    delete(wb);
      
    