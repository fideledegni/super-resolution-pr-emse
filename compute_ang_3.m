function [A] = compute_ang_3(pmmm, pmm, pm, p, pp, ppp, pppp)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% compute_ang_3(pmmm, pmm, pm, p, pp, ppp, pppp) Computes the opening angle at pm using
% the cosine law. The resultt A is in degrees
% Every combination of a  3 critical data points before and after p are
% used to form a triangle so as to calculate an opening angle. The minimum
% angle computed is returned

    A1 = ang(pm, p, pp);
    A2 = ang(pmm, p, pp);
    A3 = ang(pmmm, p, pp);
    A4 = ang(pm, p, ppp);
    A5 = ang(pmm, p, ppp);
    A6 = ang(pmmm, p, ppp);
    A7 = ang(pm, p, pppp);
    A8 = ang(pmm, p, pppp);
    A9 = ang(pmmm, p, pppp);
    
    A = min([A1, A2, A3, A4, A5, A6, A7, A8, A9]); % A is in [0, 180]
    