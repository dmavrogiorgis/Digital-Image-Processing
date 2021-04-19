clear;
close all;

%STEP 1
[I,map] = imread('village.gif');
BW = im2bw(I,map,0.5);

figure (1);
imagesc(BW)
colormap(gray);

%STEP 2
figure
I = UrbanDetec('village.gif', '../report/output_images/out.tif', 3, 0.1);

%STEP 3.1
[I,map] = imread('village.gif');

se = strel('square',3);
TH = I - imdilate(imerode(I,se),se);
figure (5);
subplot(1,2,1);
imagesc(TH);
colormap(gray);
title('Top-Hat Filtering');

se = strel('square',3);
BH = imerode(imdilate(I,se),se) - I;
subplot(1,2,2);
imagesc(BH);
colormap(gray);
title('Bottom-Hat Filtering');

%STEP 3.2
TH = im2double(TH);
BH = im2double(BH);

%STEP 3.3
LEVEL_TH = graythresh(TH);
LEVEL_BH = graythresh(BH);

%STEP 3.4
BWTH = im2bw(TH,LEVEL_TH);
BWBH = im2bw(BH,LEVEL_BH);
figure (6);
subplot(1,2,1);
imagesc(BWTH);
colormap(gray);
title('BWTH');
subplot(1,2,2);
imagesc(BWBH);
colormap(gray);
title('BWBH');

%STEP 3.5
se = strel('square',2);
OBWTH = imopen(BWTH,se);
figure (7);
subplot(1,2,1);
imagesc(OBWTH);
title('OBWTH');

%STEP 3.6
se = strel('diamond',1);
OCBWBH = imopen(imclose(BWBH,se),se);
subplot(1,2,2);
imagesc(OCBWBH);
colormap(gray);
title('OCBWBH');

%STEP 3.7
FINAL = imfuse(OBWTH,OCBWBH,'diff');
figure (8);
imagesc(FINAL);
colormap(gray);
title('FINAL');
