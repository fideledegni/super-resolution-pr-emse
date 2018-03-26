function [B, Boundaries] = extract_boundary(I)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% extract_boundary(I) Extract binary image boudary
% A raster scan is performed on the binary image I
% If the scanned pixel is one and at least one of its 4- nearest neighbors (4NN) 
% is zero, it is defined as a boundary pixel –- a value of one is assigned to each 
% boundary pixel. NB: If the scanned pixel is on the border of the image and
% is one, it is defined as a boundary pixel

    [m, n] = size(I);
    B = zeros(m,n);
    for i=1:m
        for j=1:n
            if I(i,j) % if I(i,j)==1
                if (i==1 || i==m || j==1 || j==n) || I(i-1,j)==0 || I(i+1,j)==0 || I(i,j-1)==0 || I(i,j+1)==0
                        B(i,j)=1;
                end
            end
        end
    end
    
    Boundaries = bwboundaries(B,'noholes'); % Boundaries contains the completed (closed) boundaries of objects in B
    