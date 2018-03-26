function [A] = compute_ang_2(pmm, pm, p, pp, ppp)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% compute_ang_2(pmm, pm, p, pp, ppp) Computes the opening angle at pm using
% the cosine law. The resultt A is in degrees
% Every combination of a  2 critical data points before and after p are
% used to form a triangle so as to calculate an opening angle. The minimum
% angle computed is returned

    A1 = ang(pm, p, pp);
    A2 = ang(pmm, p, pp);
    A3 = ang(pm, p, ppp);
    A4 = ang(pmm, p, ppp);
    
    A = min([A1, A2, A3, A4]); % A is in [0, 180]
    