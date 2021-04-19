clear;
close all;

figure (1);
I = imread('cell.tif');
imagesc(I);
colormap(gray);
title('Initial Image');

figure (2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,threshold] = edge(I,'sobel');
factor = 0.5;
BW = edge(I,'sobel', threshold*factor);
subplot(2,3,1);
imagesc(BW);
colormap(gray);
title('Binary Gradient Mask');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sqr = strel('square', 3);
BWdilate = imdilate(BW, sqr);

subplot(2,3,2);
imagesc(BWdilate);
colormap(gray);
title('Dilated Gradient Mask');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BWfill = imfill(BWdilate,'holes');

subplot(2,3,3);
imagesc(BWfill);
colormap(gray);
title('Binary Image with Filled Holes');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BWclear = imclearborder(BWfill, 4);

subplot(2,3,4);
imagesc(BWclear);
colormap(gray);
title('Cleared Border Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dia = strel('diamond', 1);
BWfinal = imerode(BWclear, dia);
BWfinal = imerode(BWfinal, dia);

subplot(2,3,5);
imagesc(BWfinal);
colormap(gray);
title('Smoothed Border Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BWoutline = bwperim(BWfinal);
Iout = I; 
Iout(BWoutline) = 0; 

subplot(2,3,6);
imagesc(Iout);
colormap(gray);
title('Outlined Image')

