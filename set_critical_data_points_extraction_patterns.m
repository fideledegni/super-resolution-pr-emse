function set_critical_data_points_extraction_patterns()
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% set_critical_data_points_extraction_patterns Sets the patterns values used by 
% extract_critical_data_points()
    global P1 P2 P3 P4 P5 P6 P7 P8 P9 P10 P11 P12 P13 P14 P15
    global S1 S2 S3 S4 S5678 S9 S10 S11 S12 S13 S14 S15
    P1 = [
        1 1 1;
        0 0 0;
        0 0 0]; % Pattern 1
    S1 = [
        0 1 0;
        0 0 0;
        0 0 0];
    
    P2 = [
        0 0 0;
        0 0 0;
        1 1 1]; % Pattern 2
    S2 = [
        0 0 0;
        0 0 0;
        0 1 0];
    
    P3 = [
        1 0 0;
        1 0 0;
        1 0 0]; % Pattern 3
    S3 = [
        0 0 0;
        1 0 0;
        0 0 0];
    
    P4 = [
        0 0 1;
        0 0 1;
        0 0 1]; % Pattern 4
    S4 = [
        0 0 0;
        0 0 1;
        0 0 0];
    
    P5 = [
        1 1 1;
        1 0 0;
        1 0 0]; % Pattern 5
    P6 = [
        1 1 1;
        0 0 1;
        0 0 1]; % Pattern 6
    P7 = [
        1 0 0;
        1 0 0;
        1 1 1]; % Pattern 7
    P8 = [
        0 0 1;
        0 0 1;
        1 1 1]; % Pattern 8
    S5678 = [
        0 0 0;
        0 1 0;
        0 0 0];
    
    P9 = [
        1 0 1;
        1 0 1;
        1 0 1]; % Pattern 9
    S9 = [
        0 0 0;
        1 0 1;
        0 0 0];
    
    P10 = [
        1 1 1;
        0 0 0;
        1 1 1]; % Pattern 10
    S10 = [
        0 1 0;
        0 0 0;
        0 1 0];
    
    P11 = [
        1 1 1;
        1 0 1;
        1 0 1]; % Pattern 11
    S11 = [
        0 1 0;
        1 0 1;
        0 0 0];
    
    P12 = [
        1 0 1;
        1 0 1;
        1 1 1]; % Pattern 12
    S12 = [
        0 0 0;
        1 0 1;
        0 1 0];
    
    P13 = [
        1 1 1;
        1 0 0;
        1 1 1]; % Pattern 13
    S13 = [
        0 1 0;
        1 0 0;
        0 1 0];
    
    P14 = [
        1 1 1;
        0 0 1;
        1 1 1]; % Pattern 14
    S14 = [
        0 1 0;
        0 0 1;
        0 1 0];
    
    P15 = [
        1 1 1;
        1 0 1;
        1 1 1]; % Pattern 15
    S15 = [
        0 1 0;
        1 0 1;
        0 1 0];
    
     