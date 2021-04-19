clear;
close all;
clc;

down_scale = 1/2;
up_scale = 2;

K = fspecial('gaussian' , [5 5], 1);

G0 = imread('cameraman.tif');
G0_filter = conv2(G0, K, 'same');

G1 = imresize(G0_filter, down_scale, 'bicubic', 'Antialiasing', false);
G1_filter = conv2(G1, K, 'same');

G2 = imresize(G1_filter, down_scale, 'bicubic', 'Antialiasing', false);
G2_filter = conv2(G2, K, 'same');

G3 = imresize(G2_filter, down_scale, 'bicubic', 'Antialiasing', false);
G3_filter = conv2(G3, K, 'same');

G4 = imresize(G3_filter, down_scale, 'bicubic', 'Antialiasing', false);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L4 = G4;

L3 = G3 - imresize(G4, up_scale, 'bicubic');

L2 = G2 - imresize(G3, up_scale, 'bicubic');

L1 = G1 - imresize(G2, up_scale, 'bicubic'); 

L0 = double(G0) - imresize(G1, up_scale, 'bicubic');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

G4_comb = L4;

G3_comb = L3 + imresize(G4_comb, up_scale, 'bicubic');

G2_comb = L2 +  imresize(G3_comb, up_scale, 'bicubic');

G1_comb = L1 +  imresize(G2_comb, up_scale, 'bicubic');

G0_comb = L0 +  imresize(G1_comb, up_scale, 'bicubic');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure (1);

subplot(1,3,1)
imagesc(G4);
title('Gaussian');

subplot(1,3,2)
imagesc(L4);
title('Laplacian');

subplot(1,3,3)
imagesc(G4_comb);
title('Combined');
suptitle('Layer 5');

colormap(gray);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure (2);

subplot(1,3,1)
imagesc(G3);
title('Gaussian');

subplot(1,3,2)
imagesc(L3);
title('Laplacian');

subplot(1,3,3)
imagesc(G3_comb);
title('Combined');
suptitle('Layer 4');

colormap(gray);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure (3);

subplot(1,3,1)
imagesc(G2);
title('Gaussian');

subplot(1,3,2)
imagesc(L2);
title('Laplacian');

subplot(1,3,3)
imagesc(G2_comb);
title('Combined');
suptitle('Layer 3');

colormap(gray);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure (4);

subplot(1,3,1)
imagesc(G1);
title('Gaussian');

subplot(1,3,2)
imagesc(L1);
title('Laplacian');

subplot(1,3,3)
imagesc(G1_comb);
title('Combined');
suptitle('Layer 2');

colormap(gray);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure (5);

subplot(1,3,1)
imagesc(double(G0));
title('Gaussian');

subplot(1,3,2)
imagesc(L0);
title('Laplacian');

subplot(1,3,3)
imagesc(G0_comb);
title('Combined');
suptitle('Layer 1');

colormap(gray);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mse = immse(G0, uint8(G0_comb));

