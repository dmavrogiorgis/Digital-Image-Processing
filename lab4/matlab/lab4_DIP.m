clear;
close all;
clc

img_in_1 = imread('noisyimg.png');
img_in_2 = imread('noisyimg2.png');

kernel_size = [3 5 9];

figure (1);
subplot(2,2,1)
imagesc(img_in_1);
title('Initial Image');

figure (2);
subplot(2,2,1)
imagesc(img_in_2);
title('Initial Image');

for i=1:length(kernel_size)
    K = ones(kernel_size(i), kernel_size(i));
    
    img_out_1(:,:,i) = Compute_Min_Median_Max(img_in_1, K, 'median');
    
    figure (1);
    subplot(2,2,i+1);
    imagesc(img_out_1(:,:,i));
    colormap(gray);
    title(sprintf('Kernel size: %d', kernel_size(i)));
    suptitle('Compute Median Method');
    
    
    img_out_2(:,:,i) = Compute_Min_Median_Max(img_in_2, K, 'median');
    
    figure (2);
    subplot(2,2,i+1);
    imagesc(img_out_2(:,:,i)); 
    colormap(gray);
    title(sprintf('Kernel size: %d', kernel_size(i)));
    suptitle('Compute Median Method');
end

%% Compute Min
figure (3);
subplot(2,2,1)
imagesc(img_in_1);
colormap(gray);    
title('Initial Image');

figure (4);
subplot(2,2,1)
imagesc(img_in_2);
colormap(gray);
title('Initial Image');

for i=1:length(kernel_size)
    K = ones(kernel_size(i), kernel_size(i));
    
    img_out_1(:,:,i) = Compute_Min_Median_Max(img_in_1, K, 'min');
    
    figure (3);
    subplot(2,2,i+1);
    imagesc(img_out_1(:,:,i));
    colormap(gray);
    title(sprintf('Kernel size: %d', kernel_size(i)));
    suptitle('Compute Min Method');
    
    img_out_2(:,:,i) = Compute_Min_Median_Max(img_in_2, K, 'min');
    
    figure (4);
    subplot(2,2,i+1);
    imagesc(img_out_2(:,:,i));
    colormap(gray);
    title(sprintf('Kernel size: %d', kernel_size(i)));
    suptitle('Compute Min Method');
end


%% Compute Max
figure (5);
subplot(2,2,1)
imagesc(img_in_1);
colormap(gray);    
title('Initial Image');

figure (6);
subplot(2,2,1)
imagesc(img_in_2);
colormap(gray);
title('Initial Image');

for i=1:length(kernel_size)
    K = ones(kernel_size(i), kernel_size(i));
    
    img_out_1(:,:,i) = Compute_Min_Median_Max(img_in_1, K, 'max');
    
    figure (5);
    subplot(2,2,i+1);
    imagesc(img_out_1(:,:,i));
    colormap(gray);
    title(sprintf('Kernel size: %d', kernel_size(i)));
    suptitle('Compute Max Method');
    
    img_out_2(:,:,i) = Compute_Min_Median_Max(img_in_2, K, 'max');
    
    figure (6);
    subplot(2,2,i+1);
    imagesc(img_out_2(:,:,i));
    colormap(gray);
    title(sprintf('Kernel size: %d', kernel_size(i)));
    suptitle('Compute Max Method');
end

%% Bonus

img_in_3 = imread('peppers_gray.tif');

F = [-1 0 1];

img_out_3a = conv2(img_in_3(:,:,1), F, 'same');
img_out_3b = conv2(img_in_3(:,:,1), F.', 'same');
img_out_3c = img_out_3a + img_out_3b;

figure(7);

subplot(1,4,1);
imagesc(img_in_3(:,:,1));
title('Initial Image');

subplot(1,4,2);
imagesc(img_out_3a);
title('Convolution with F');

subplot(1,4,3);
imagesc(img_out_3b);
title('Convolution with F^T');

subplot(1,4,4);
imagesc(img_out_3c);
title('Sum of the two convolutions');
suptitle('Convolution with a differential filter');
colormap(gray);












