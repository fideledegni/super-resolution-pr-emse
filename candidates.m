function [C] = candidates(EP, CD, delta)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% candidates(EP, CD, delta) Computes edge pixels candidates from EP for
% edge correction using the critical data points in CD
% EP and CD are 13*13 matrices and the reference critical data point is
% located at position (7,7) in CD
% delta  controls the tolerate distance for validating edge pixels

    C = [];
    for i=1:13
        for j=1:13
            if EP(i,j) ~= 0
                d_curr = sqrt((i-7)^2 + (j-7)^2);
                for k=1:13
                    for l=1:13
                        if CD(k,l)
                            d_new = sqrt((i-k)^2 + (j-l)^2);
                            if d_new <= d_curr
                                d_curr = d_new;
                            end
                        end
                    end
                end
                if sqrt((i-7)^2 + (j-7)^2) <= d_curr + delta
                    C = [C; i, j];
                end
            end
        end
    end
                            
                            
                            
                            