%% Load images
P = imread('light.png');
L = imread('llg.JPG');
M = imread('poudre.jpg');
N = imread('bird.jpg');
R = imread('pet.jpg');
S = imread('colors.jpg');


%% Test 1, Result not too bad
f = 8; %f = 4;
Pf = imresize(P,1/f); % downsampling
PB = imresize(Pf, f); % upsampling with bicubic interpolation
tic
PP = super_resolution(Pf, f, 0.7);
toc
figure('units', 'normalized', 'outerposition', [0.05 0.05 0.9 0.9]);
subplot(221);
imshow(P); title('Ground truth');
subplot(222);
imshow(PP, []); title('SR image (factor = 8)');
subplot(223);
imshow(Pf, []); title('LR image');
subplot(224);
imshow(PB, []); title('Bicubic interpolation');

RMSE_PP = compute_rmse(PP, P); % root mean square
RMSE_PB = compute_rmse(PB, P);

%% Test 2, Color mismatch
f = 4;
Lf = imresize(L,1/f);
LB = imresize(Lf, f);
tic
LL = super_resolution(Lf, f, 0.7);
toc
figure('units', 'normalized', 'outerposition', [0.05 0.05 0.9 0.9]);
subplot(221);
imshow(L); title('Ground truth');
subplot(222);
imshow(LL, []); title('SR image (factor = 4)');
subplot(223);
imshow(Lf, []); title('LR image');
subplot(224);
imshow(LB, []); title('Bicubic interpolation');


%% Test 3, gray-scale image
f = 4; %f = 2;
Mf = imresize(M,1/f);
MB = imresize(Mf, f);
tic
MM = super_resolution(Mf, f, 0.7);
toc
figure('units', 'normalized', 'outerposition', [0.05 0.05 0.9 0.9]);
subplot(221);
imshow(M); title('Ground truth');
subplot(222);
imshow(MM, []); title('SR image (factor = 4)');
subplot(223);
imshow(Mf, []); title('LR image');
subplot(224);
imshow(MB, []); title('Bicubic interpolation');


%% Test 4,  Result not too bad
f = 8;
Nf = imresize(N,1/f);
NB = imresize(Nf, f);
tic
NN = super_resolution(Nf, f, 0.7);
toc
figure('units', 'normalized', 'outerposition', [0.05 0.05 0.9 0.9]);
subplot(221);
imshow(N); title('Ground truth');
subplot(222);
imshow(NN, []); title('SR image (factor = 8)');
subplot(223);
imshow(Nf, []); title('LR image');
subplot(224);
imshow(NB, []); title('Bicubic interpolation');


%% Test 5, Result not good
f = 4;
Rf = imresize(R,1/f);
RB = imresize(Rf, f);
tic
RR = super_resolution(Rf, f, 0.7);
toc
figure('units', 'normalized', 'outerposition', [0.05 0.05 0.9 0.9]);
subplot(221);
imshow(R); title('Ground truth');
subplot(222);
imshow(RR, []); title('SR image (factor = 4)');
subplot(223);
imshow(Rf, []); title('LR image');
subplot(224);
imshow(RB, []); title('Bicubic interpolation');


%% Test 6, Result not too bad
f = 8;
Sf = imresize(S,1/f);
SB = imresize(Sf, f);
tic
SS = super_resolution(Sf, f, 0.7);
toc
figure('units', 'normalized', 'outerposition', [0.05 0.05 0.9 0.9]);
subplot(221);
imshow(S); title('Ground truth');
subplot(222);
imshow(SS, []); title('SR image (factor = 8)');
subplot(223);
imshow(Sf, []); title('LR image');
subplot(224);
imshow(SB, []); title('Bicubic interpolation');

