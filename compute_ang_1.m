function [A] = compute_ang_1(pm, p, pp)
% compute_ang_1(pm, p, pp) Computes the angle (pm, p, pp) between pm, p and pp at p
% using the cosine law. The resultt A is in degrees

    A = ang(pm, p, pp); % A is in [0, 180]