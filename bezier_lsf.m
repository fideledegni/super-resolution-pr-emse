function [R] = bezier_lsf(S, f)
% See: M. Khan, Approximation of data using cubic Bezier curve  least  square  fitting
%
% bezier_lsf(S, f) Performs a least square cubic Bezier fitting on S
% f is an enlargement factor used to compute the maximum allowed square distance
% When the limit of error bound is violated, the sector is further split
% into two until the error is less than or equal to the limit

    nbp = length(S);
    d = f/4;
    % maxD = d;
    if nbp <= 4
        % maximum allowed square distance, i.e. the error between 
        % original and approximated (fitted) data
        maxD = 0.5*d;
    elseif nbp <= 8
        maxD = 0.75*d;
    elseif nbp <= 16
        maxD = d;
    else
        maxD = 2*d;
    end
    N = (f^2)*(nbp-1)+1; % number of points we want to generate after curve fitting
    T = linspace(0,1,N)'; % a column vector
    
    
    t = linspace(0,1,nbp)'; % a column vector
    P0 = S(1,:); P3 = S(end,:);
    % Let's compute the middle control points P1 and P2
    if nbp == 2
        P1 = P0; P2 = P3;
    elseif nbp == 3
        P1 = S(2,:); P2 = S(2,:);
    else
        A1 = 0;	A2 = 0; A12 = 0; C1 = [0 0]; C2 = [0 0];
        for i=2:(nbp-1) % because nul terms for i=1 and i=nbp
            B0 = (1-t(i))^3;
            B1 = 3*t(i)*(1-t(i))^2;
            B2 = 3*t(i)^2*(1-t(i));
            B3 = t(i)^3;
            
            A1 = A1 + B1^2;
            A2 = A2 + B2^2;
            A12 = A12 + B1*B2;
            
            C1 = C1 + B1*(S(i,:) - B0*P0 - B3*P3);
            C2 = C2 + B2*(S(i,:) - B0*P0 - B3*P3);
        end
        D = A1*A2 - A12*A12;
        if D == 0
            P1 = P0;
            P2 = P3;
        else
            P1 = (A2*C1 - A12*C2)/D;
            P2 = (A1*C2 - A12*C1)/D;
        end
    end
    Temp = bezier(P0, P1, P2, P3, t);
    LS = least_square(S, Temp); % least square value
    
    if LS <= maxD
        R = bezier(P0, P1, P2, P3, T);
    % Split into two until the error is less than or equal to the limit 
    else
        mid = round(nbp/2);
        haut = bezier_lsf(S(1:mid,:), f);
        bas = bezier_lsf(S(mid:end,:), f);
        R = [haut; bas(2:end,:)];
    end

    
    
    