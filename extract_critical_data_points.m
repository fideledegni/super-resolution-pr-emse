function [CDP, Boundaries] = extract_critical_data_points(I, B)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% extract_critical_data_points(I, B) Extracts critical data points from the
% boundary image I; B is the completed (closed) boundaries of objects in I
% The input image I must be the boundary of an already enlarged by a factor
% of 3 image
% We divide the image into three by three, non-overlapped patch
% Each 3x3 image patch can only take one of the 15 patterns (P1 to P15) defined 
% bellow
%
% - Some patterns contain 3 boundary pixels (one side of the pattern is boundary)
% - Some contain 5 boundary pixels (represent a corner)
% - Some contain 6 boundary pixels (part of an object of a single pixel width in the
% original image, the one enlarged by a factor of 3 to get the input image)
% - Some contain 7 boundary pixels (a stick-out pixel in the original image)
% - Some contain 8 boundary pixels (represent an isolated single pixel in the original image)
%
% Only one critical data point is selected for patterns containing 3 or 5 boundary pixels
% For the patterns that contain 6 or 7 boundary pixels, 2 or 3 critical data
% points are selected respectively, so as to represent its details more accurately
% Finally, 4 critical data points are selected for patterns of eight boundary pixels
% See S1 to S15 bellow
%
% B will be transformed into Boundaries which will contain only critical data points

    persistent P1 P2 P3 P4 P5 P6 P7 P8 P9 P10 P11 P12 P13 P14 P15
    persistent S1 S2 S3 S4 S5678 S9 S10 S11 S12 S13 S14 S15
    P1 = [
        1 1 1;
        0 0 0;
        0 0 0]; % Pattern 1
    S1 = [
        0 1 0;
        0 0 0;
        0 0 0];
    
    P2 = [
        0 0 0;
        0 0 0;
        1 1 1]; % Pattern 2
    S2 = [
        0 0 0;
        0 0 0;
        0 1 0];
    
    P3 = [
        1 0 0;
        1 0 0;
        1 0 0]; % Pattern 3
    S3 = [
        0 0 0;
        1 0 0;
        0 0 0];
    
    P4 = [
        0 0 1;
        0 0 1;
        0 0 1]; % Pattern 4
    S4 = [
        0 0 0;
        0 0 1;
        0 0 0];
    
    P5 = [
        1 1 1;
        1 0 0;
        1 0 0]; % Pattern 5
    P6 = [
        1 1 1;
        0 0 1;
        0 0 1]; % Pattern 6
    P7 = [
        1 0 0;
        1 0 0;
        1 1 1]; % Pattern 7
    P8 = [
        0 0 1;
        0 0 1;
        1 1 1]; % Pattern 8
    S5678 = [
        0 0 0;
        0 1 0;
        0 0 0];
    
    P9 = [
        1 0 1;
        1 0 1;
        1 0 1]; % Pattern 9
    S9 = [
        0 0 0;
        1 0 1;
        0 0 0];
    
    P10 = [
        1 1 1;
        0 0 0;
        1 1 1]; % Pattern 10
    S10 = [
        0 1 0;
        0 0 0;
        0 1 0];
    
    P11 = [
        1 1 1;
        1 0 1;
        1 0 1]; % Pattern 11
    S11 = [
        0 1 0;
        1 0 1;
        0 0 0];
    
    P12 = [
        1 0 1;
        1 0 1;
        1 1 1]; % Pattern 12
    S12 = [
        0 0 0;
        1 0 1;
        0 1 0];
    
    P13 = [
        1 1 1;
        1 0 0;
        1 1 1]; % Pattern 13
    S13 = [
        0 1 0;
        1 0 0;
        0 1 0];
    
    P14 = [
        1 1 1;
        0 0 1;
        1 1 1]; % Pattern 14
    S14 = [
        0 1 0;
        0 0 1;
        0 1 0];
    
    P15 = [
        1 1 1;
        1 0 1;
        1 1 1]; % Pattern 15
    S15 = [
        0 1 0;
        1 0 1;
        0 1 0];

    [m,n] = size(I);
    CDP = zeros(m, n); % Critical data points
    vide = zeros(3,3);
    for i=1:m/3
        for j=1:n/3
            % Current patch
            CP = I(3*(i-1)+1:3*i, 3*(j-1)+1:3*j);
            if ~isequal(CP, vide)
                if CP == P1
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S1;
                elseif CP == P2
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S2;
                elseif CP == P3
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S3;
                elseif CP == P4
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S4;
                elseif CP == P5
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S5678;
                elseif CP == P6
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S5678;
                elseif CP == P7
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S5678;
                elseif CP == P8
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S5678;
                elseif CP == P9
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S9;
                elseif CP == P10
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S10;
                elseif CP == P11
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S11;
                elseif CP == P12
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S12;
                elseif CP == P13
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S13;
                elseif CP == P14
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S14;
                elseif CP == P15
                    CDP(3*(i-1)+1:3*i, 3*(j-1)+1:3*j) = S15;
                end
            end
        end
    end
    
    % Now we need to transform B into Boundaries
    Boundaries = B;
    nb = length(Boundaries); % number of closed boundaries
    for k=1:nb
        BD = Boundaries{k};
        nbp = length(BD); % number of points in boundary
        for x=1:nbp
            i = BD(x,1); j = BD(x,2);
            if CDP(i, j) == 0
                BD(x,:) = nan; % replace non critical data points with "nan"
            end
        end
        % But we have deleted too much critical data points, those which
        % represent corners; so we have to add them back
        % First, let's pay attention to the beginning of the boundary
        % Note: The coordinates in BD are ordered in a clockwise direction.
        if (isnan(BD(1,1)) && isnan(BD(2,1)) && isnan(BD(3,1)))
            consec = 3; % number of consecutive "nan"
        elseif (~isnan(BD(1,1)) && isnan(BD(2,1)) && isnan(BD(3,1)))
            consec = 2;
        elseif (isnan(BD(1,1)) && ~isnan(BD(2,1)) && isnan(BD(3,1)))
            consec = 1;
        else
            consec = 0;
        end
        x = 4; % index to scan the boundary
        while x < nbp
            if ~isnan(BD(x,1)) % if not empty, move on
                x = x+1; consec = 0;
            else
                % Check if the three previous and the three next are nan
                if (x+3<=nbp && isnan(BD(x-3,1)) && isnan(BD(x-2,1)) && isnan(BD(x-1,1)) && isnan(BD(x+1,1)) && isnan(BD(x+2,1)) && isnan(BD(x+3,1)))
                    % this means we have 7 consecutive "nan" values
                    BD(x,:) = Boundaries{k}(x-1,:) - Boundaries{k}(x,:) + Boundaries{k}(x+1,:);
                    x = x+4; consec = 0;
                    if (x+2<=nbp && isnan(BD(x,1))) % this means means we have 12 consecutive "nan" values
                        BD(x+1,:) = Boundaries{k}(x,:) - Boundaries{k}(x+1,:) + Boundaries{k}(x+2,:);
                        x = x+5; consec = 0;
                    end
                else
                    consec = consec+1;
                    if ( consec == 5 && (x<=nbp && isnan(BD(x,1))) )
                        % this means we have 5 consecutive "nan" values
                        BD(x-2,:) = Boundaries{k}(x-2,:);
                        x = x+1; consec = 0;
                    end
                    x = x+1;
                end
            end
        end
        
        BD = reshape(BD(~isnan(BD)), [], 2); % delete nan values
        Boundaries{k} = [BD; BD(1,:)]; % Close the boundary!
    end
        
        
        
    