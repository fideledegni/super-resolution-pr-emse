function [A] = ang(pm, p, pp)
% ang(pm, p, pp) Computes the angle (pm, p, pp) between pm, p and pp at p
% using the cosine law. The resultt A is in degrees
    as = (p(1) - pp(1))^2 + (p(2) - pp(2))^2; % a squared
    bs = (p(1) - pm(1))^2 + (p(2) - pm(2))^2; % b squared
    cs = (pp(1) - pm(1))^2 + (pp(2) - pm(2))^2; % c squared
    
    A = (180/pi)*acos((as + bs - cs)/(2*sqrt(as*bs))); % A is in [0, 180]
    