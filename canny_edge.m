function [E] = canny_edge(I)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% canny_edge(I) Passes I to the Canny-edge detector for nine times. The
% threshold of detector is set at 0.1 in the first pass and increased by
% 0.1 in each following pass. The output of each pass is a binary image,
% and all nine binary images are added to produce the edge image E(i,j) in
% {0, ..., 9} in which non-zero pixels are identified as edge pixels and
% large value represents a strong edge pixel

    [m, n] = size(I);
    E = double(zeros(m,n));
    for t=0.1:0.1:0.9
        E = E + double(edge(I, 'canny', t));
    end
    % Normalization to [0,1]
    % If E(i,j) == 0, E(i,j) = 0
    % Else E(i,j) = (E(i,j)+1)/10
    EE = E ~= 0;
    E = (E + EE)/10;