function [BP] = breaking_points(EC)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% breaking_points(EC) Detects high-curvature location (breaking points) in
% components of EC in order to break them into multiple sectors
% PB is a cell structure such that BP{k} is a vector with BP{k}(i) = 1 if
% EC{k}(i) is a breaking point and  BP{k}(i) = 0 otherwise

    nb = length(EC); % number of closed boundaries
    BP = cell(nb, 1);
    alpha_max = 140;
    for k=1:nb
        BD = EC{k};
        nbp = length(BD); % number of points in boundary
        BPK = zeros(nbp, 1);
        BPK(1) = 1; BPK(nbp) = 1; % the first and the last point of the closed boundary 
        %(which are the same point) are breaking points
        
        if nbp <= 7
            for x=2:(nbp-1)
                A = compute_ang_1(BD(x-1,:), BD(x,:), BD(x+1,:));
                if A <= alpha_max
                    % Non-minima suppression is not performed on components
                    % containing less than 7 critical data points
                    BPK(x) = 1;
                end
            end
        elseif nbp <= 12
            for x=3:(nbp-2)
                A = compute_ang_2(BD(x-2,:), BD(x-1,:), BD(x,:), BD(x+1,:), BD(x+2,:));
                if A <= alpha_max
                    BPK(x) = A;
                end
            end
        else % if nbp >= 13
            for x=4:(nbp-3)
                A = compute_ang_3(BD(x-3,:), BD(x-2,:), BD(x-1,:), BD(x,:), BD(x+1,:), BD(x+2,:), BD(x+3,:));
                if A <= alpha_max
                    BPK(x) = A;
                end
            end
        end
        
        % We are now going to use non-minima suppression to select the
        % breaking points of the component : if a candidate breaking point
        % has an adjacent point with less opening angle, it is discarded
        % and the adjacent point is chosen ; we do this only for components
        % containing more than 7 critical data points
        if nbp > 7
            for x=3:(nbp-2) % note that nbp is always >= 5
                if BPK(x) ~= 0
                    if (BPK(x-1) == 0 && BPK(x+1) == 0) % if the two adjacent points are not candidate breaking points
                        BPK(x) = 1;
                    elseif BPK(x-1) == 0 % if only the next adjacent point is candidate breaking point
                        if BPK(x) <= BPK(x+1)
                            BPK(x) = 1; BPK(x+1) = 0;
                        else
                            BPK(x) = 0; BPK(x+1) = 1;
                        end
                    elseif BPK(x+1) == 0 % if only the previous adjacent point is candidate breaking point
                        if BPK(x-1) <= BPK(x)
                            BPK(x-1) = 1; BPK(x) = 0;
                        else
                            BPK(x-1) = 0; BPK(x) = 1;
                        end
                    else % if the two adjacent points are candidate breaking points
                        mini = min([BPK(x-1), BPK(x), BPK(x+1)]);
                        if mini == BPK(x-1)
                            BPK(x-1) = 1; BPK(x) = 0; BPK(x+1) = 0;
                        elseif mini == BPK(x)
                            BPK(x-1) = 0; BPK(x) = 1; BPK(x+1) = 0;
                        else
                            BPK(x-1) = 0; BPK(x) = 0; BPK(x+1) = 1;
                        end
                    end
                end
            end
        end
        
        BP{k} = BPK;
    end
    
    