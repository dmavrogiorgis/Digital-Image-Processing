clear;
close all;
clc;

K = 1/16*[1 2 1; 2 4 2; 1 2 1];

im_input = imread('lena_gray_512.tif');

im_output_zero = convolution2D(im_input, K, 'zero');

f1 = figure (1);

subplot(2, 2, 1)
imshow(im_input);
title('Input Image');

subplot(2, 2, 2)
imshow(im_output_zero);
title('Output Image - Zero Padding');
suptitle('For loop function');

mse_zero = immse(im_output_zero, im_input);
psnr_zero = psnr(im_output_zero, im_input);

%------------------------------------------------------------------
im_output_replicate = convolution2D(im_input, K, 'replicate');

subplot(2, 2, 3)
imshow(im_input);
title('Input Image');

subplot(2, 2, 4)
imshow(im_output_replicate);
title('Output Image - Replicate');

mse_replicate = immse(im_output_replicate, im_input);
psnr_replicate = psnr(im_output_replicate, im_input);

%saveas(f1, sprintf('for_loop_conv.png'));

%% Conv2 function

im_output_zero = conv2(im_input, K, 'same');

f2 = figure(2);

subplot(2, 2, 1)
imshow(im_input);
title('Input Image');

subplot(2, 2, 2)
imshow(uint8(im_output_zero));
title('Output Image - Zero Padding');
suptitle('Conv2 function');

mse_zero_conv2 = immse(uint8(im_output_zero), im_input);
psnr_zero_conv2 = psnr(uint8(im_output_zero), im_input);

%------------------------------------------------------------------
im_input_replicate = padarray(im_input, [1 1], 'replicate');

im_output_replicate = conv2(im_input_replicate, K, 'valid');

subplot(2, 2, 3)
imshow(im_input);
title('Input Image');

subplot(2, 2, 4)
imshow(uint8(im_output_replicate));
title('Output Image - Replicate');

mse_replicate_conv2 = immse(uint8(im_output_replicate), im_input);
psnr_replicate_conv2 = psnr(uint8(im_output_replicate), im_input);

%saveas(f2, sprintf('conv2_func.png'));

%% Imfilter function

im_output_zero = imfilter(im_input, K, 'same');

f3 = figure(3);

subplot(2, 2, 1)
imshow(im_input);
title('Input Image');

subplot(2, 2, 2)
imshow(uint8(im_output_zero));
title('Output Image - Zero Padding');
suptitle('Imfilter function');

mse_zero_imfilter = immse(im_output_zero, im_input);
psnr_zero_imfilter = psnr(im_output_zero, im_input);
%------------------------------------------------------------------

im_output_replicate = imfilter(im_input, K, 'same', 'replicate');

subplot(2, 2, 3)
imshow(im_input);
title('Input Image');

subplot(2, 2, 4)
imshow(uint8(im_output_replicate));
title('Output Image - Replicate');

mse_replicate_imfilter = immse(im_output_replicate, im_input);
psnr_replicate_imfilter = psnr(im_output_replicate, im_input);

%saveas(f3, sprintf('imfiler_func.png'));

%% Display

methods = ['Zero      ' 'Replicate'];
disp('----------MSE Results----------');
disp('-------------------------------');
disp(['Method: ' methods]);
disp(['For Loop: ' num2str([mse_zero mse_replicate])]);
disp(['Conv2: ' num2str([mse_zero_conv2 mse_replicate_conv2])]);
disp(['Imfilter: ' num2str([mse_zero_imfilter mse_replicate_imfilter])]);
disp('-------------------------------');
disp(' ');

disp('----------PSNR Results---------');
disp('-------------------------------');
disp(['Method: ' methods]);
disp(['For Loop: ' num2str([psnr_zero psnr_replicate])]);
disp(['Conv2: ' num2str([psnr_zero_conv2 psnr_replicate_conv2])]);
disp(['Imfilter: ' num2str([psnr_zero_imfilter psnr_replicate_imfilter])]);
disp('-------------------------------');
disp(' ');