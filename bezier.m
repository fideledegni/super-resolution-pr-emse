function [R] = bezier(P0, P1, P2, P3, x)
% bezier(P0, P1, P2, P3, x) Uses the four control points P0, P1, P2 and P3 to
% compute cubic Bezier interpolation at x
% x is a a column vector with values in [0,1]

    % R = ((1-x)^3)*P0 + (3*x*(1-x)^2)*P1 + (3*x^2*(1-x))*P2 + (x^3)*P3;
    % We use Kronecker tensor product for ease
    R = kron((1-x).^3,P0) + kron(3*x.*(1-x).^2,P1) + kron(3*x.^2.*(1-x),P2) + kron(x.^3,P3);
    