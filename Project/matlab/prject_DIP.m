%% PART A
close all;
clear;
clc;

x_in = -255:1:255;
R = 0:1:8;
img_mse = zeros(1,length(R));

img_in = double(imread('lena_gray_512.tif'));
% 1-2) Plot the characteristic functions of the uniform quantizer for R = 0, … ,8.
figure (1);
for i=1:length(R)/2
   x_out = uni_scalar(x_in,R(i));
   
   subplot(1,4,i);
   plot(x_in, x_out);
   grid on;
   title(sprintf('R = %d', R(i)));
   axis([x_in(1) x_in(end) x_out(1) x_out(end)]);
end

figure (2);
for i=5:length(R)
   x_out = uni_scalar(x_in,R(i));
   
   subplot(1,5,i-4);
   plot(x_in, x_out);
   grid on;
   title(sprintf('R = %d', R(i)));
   axis([x_in(1) x_in(end) x_out(1) x_out(end)]);
end

% 3-4) Quantize the lena_gray_512.tif and measure the distortion D
img_vect = img_in(:).'; 

figure (3);
for i=1:length(R)/2
   img_out = uni_scalar(img_vect,R(i));
   img_out = reshape(img_out, size(img_in,1), size(img_in,2));
   img_mse(i) = immse(img_in,img_out);
   
   subplot(1,4,i);
   imagesc(img_out);
   colormap(gray);
   title(sprintf('R = %d', R(i)));
end

figure (4);
for i=5:length(R)
   img_out = uni_scalar(img_vect,R(i));
   img_out = reshape(img_out, size(img_in,1), size(img_in,2));
   img_mse(i) = immse(img_in,img_out);
   
   subplot(1,5,i-4);
   imagesc(img_out);
   colormap(gray);
   title(sprintf('R = %d', R(i)));
end

% 5) Plot the rate-distortion curve D(R)
figure (5);
plot(R,img_mse);
grid on;
title('Rate-Distortion curve D(R)');
xlabel('Rate R');
ylabel('Distortion D (MSE)'); 

%% PART B
close all;
clear;
clc;

% 1) Load the video
video_in = VideoReader('xylophone.mp4');

% 2-3) Number of frames, framerate, resolution and total duration/ Extraction
% of the 50th frame of the video

frameRate = video_in.framerate;
width = video_in.Width;
height = video_in.Height;
duration = video_in.Duration;

totalFrames = 1;
while hasFrame(video_in)
    if totalFrames == 50
        videoFrame = readFrame(video_in);
        pause(1/frameRate);
        imwrite(videoFrame,'../report/output_images/frame_50.tif');
    end 
    videoFrame = readFrame(video_in);
    imshow(videoFrame);
    pause(1/frameRate);
    totalFrames = totalFrames + 1;
end
 
% 4) After extraction, convert from RGB to gray scale
img_frame = imread('../report/output_images/frame_50.tif');

gray_img = rgb2gray(img_frame);

figure (1);
subplot(1,2,1);
imagesc(img_frame);
title('50th frame of video in RGB');

subplot(1,2,2);
imagesc(gray_img);
colormap(gray);
title('50th frame of video in gray scale');
%% PART C
close all;
clear;
clc;

% 1) Read the image
img_frame = imread('../report/output_images/frame_50.tif');
img_gray_in = rgb2gray(img_frame);

% 2) Rescale the image
img_gray_in = double(imresize(img_gray_in, [256 256]));

% 3) Calculation of Haar transform
img_haart = zeros(size(img_gray_in,1), size(img_gray_in,2));
for i=1:size(img_haart,1)
   img_haart(i,:) = haar_transform(img_gray_in(i,:));
end

for i=1:size(img_haart,2)
   img_haart(:,i) = haar_transform(img_haart(:,i).');
end

for i=1:size(img_haart,1)/2
   img_haart(i,1:128) = haar_transform(img_haart(i,1:128));
end

for i=1:size(img_haart,2)/2
   img_haart(1:128,i) = haar_transform(img_haart(1:128,i).');
end

figure (1);
subplot(1,2,1);
imagesc(img_haart);
colormap(gray);
title('Haar  Tranform');

% 4-5) Quantization of subbands with R=4 and entropy calculation
figure (2);

H1 = imcrop(img_haart, [129 0 128 128]);
subplot(2,3,1);
imagesc(H1);
colormap(gray);
title('Haar H1');

H1_q = uni_scalar(H1(:).',4);
H1_q = reshape(H1_q, size(H1,1), size(H1,2));
subplot(2,3,4);
imagesc(H1_q);
colormap(gray);
title('Haar H1_q');

H2 = imcrop(img_haart, [129 129 128 128]);
subplot(2,3,2);
imagesc(H2);
colormap(gray);
title('Haar H2');

H2_q = uni_scalar(H2(:).',4);
H2_q = reshape(H2_q, size(H2,1), size(H2,2));
subplot(2,3,5);
imagesc(H2_q);
colormap(gray);
title('Haar H2_q');

H3 = imcrop(img_haart, [0 129 128 128]);
subplot(2,3,3);
imagesc(H3);
colormap(gray);
title('Haar H3');

H3_q = uni_scalar(H3(:).',4);
H3_q = reshape(H3_q, size(H3,1), size(H3,2));
subplot(2,3,6);
imagesc(H3_q);
colormap(gray);
title('Haar H3_q');
suptitle('Haar Tranform - Level 1');

figure (3);

H4 = imcrop(img_haart, [65 0 63 64]);
subplot(2,3,1);
imagesc(H4);
colormap(gray);
title('Haar H4');

H4_q = uni_scalar(H4(:).',4);
H4_q = reshape(H4_q, size(H4,1), size(H4,2));
subplot(2,3,4);
imagesc(H4_q);
colormap(gray);
title('Haar H4_q');

H5 = imcrop(img_haart, [65 65 63 63]);
subplot(2,3,2);
imagesc(H5);
colormap(gray);
title('Haar H5');

H5_q = uni_scalar(H5(:).',4);
H5_q = reshape(H5_q, size(H5,1), size(H5,2));
subplot(2,3,5);
imagesc(H5_q);
colormap(gray);
title('Haar H5_q');

H6 = imcrop(img_haart, [0 65 64 63]);
subplot(2,3,3);
imagesc(H6);
colormap(gray);
title('Haar H6');

H6_q = uni_scalar(H6(:).',4);
H6_q = reshape(H6_q, size(H6,1), size(H6,2));
subplot(2,3,6);
imagesc(H6_q);
colormap(gray);
title('Haar H6_q');
suptitle('Haar Tranform - Level 2');

figure (4);

subplot(1,3,1);
hist1 = histogram(uint8(H1_q), 'Normalization', 'probability');
prob1 = hist1.Values;
prob1 = prob1(prob1~=0);
title('Haar H1_q');

subplot(1,3,2);
hist2 = histogram(uint8(H2_q), 'Normalization', 'probability');
prob2 = hist2.Values;
prob2 = prob2(prob2~=0);
title('Haar H2_q');

subplot(1,3,3);
hist3 = histogram(uint8(H3_q), 'Normalization', 'probability');
prob3 = hist3.Values;
prob3 = prob3(prob3~=0);
title('Haar H3_q');
suptitle('Histograms - Level 1');

figure (5);

subplot(1,4,1);
hist4 = histogram(uint8(H4_q), 'Normalization', 'probability');
prob4 = hist4.Values;
prob4 = prob4(prob4~=0);
title('Haar H4_q');

subplot(1,4,2);
hist5 = histogram(uint8(H5_q), 'Normalization', 'probability');
prob5 = hist5.Values;
prob5 = prob5(prob5~=0);
title('Haar H5_q');

subplot(1,4,3);
hist6 = histogram(uint8(H6_q), 'Normalization', 'probability');
prob6 = hist6.Values;
prob6 = prob6(prob6~=0);
title('Haar H6_q');

subplot(1,4,4);
H7 = imcrop(img_haart, [0 0 64 64]);
hist7 = histogram(H7, 'Normalization', 'probability');
prob7 = hist7.Values;
prob7 = prob7(prob7~=0);
title('Haar H7');
suptitle('Histograms - Level 2');

H1_sum = -sum(prob1.*log2(prob1));
H2_sum = -sum(prob2.*log2(prob2));
H3_sum = -sum(prob3.*log2(prob3));
H4_sum = -sum(prob4.*log2(prob4));
H5_sum = -sum(prob5.*log2(prob5));
H6_sum = -sum(prob6.*log2(prob6));
% H7_sum = -sum(prob7.*log2(prob7));

E1 = H1_sum + H2_sum + H3_sum + H4_sum + H5_sum + H6_sum;

% 6) Calculation of Inverse Haar Transform
img_haart_q = img_haart;
img_haart_q(1:128,129:256) = H1_q;
img_haart_q(129:256,129:256) = H2_q;
img_haart_q(129:256,1:128) = H3_q;
img_haart_q(1:64,65:128) = H4_q;
img_haart_q(65:128,65:128) = H5_q;
img_haart_q(65:128,1:64) = H6_q;

figure (1);
subplot(1,2,2);
imagesc(img_haart_q);
colormap(gray);
title('Haar transform - Quantized (Except Low frequencies)');

img_gray_out = img_haart_q;
for i=1:size(img_gray_out,2)/2
   img_gray_out(1:128,i) = inverse_haar_transform(img_gray_out(1:128,i).');
end

for i=1:size(img_gray_out,1)/2
   img_gray_out(i,1:128) = inverse_haar_transform(img_gray_out(i,1:128));
end

for i=1:size(img_gray_out,2)
   img_gray_out(:,i) = inverse_haar_transform(img_gray_out(:,i).');
end

for i=1:size(img_gray_out,1)
   img_gray_out(i,:) = inverse_haar_transform(img_gray_out(i,:));
end

figure (6);
subplot(1,2,1);
imagesc(img_gray_out);
colormap(gray);
[r4r4_peaksnr, r4r4_snr]=psnr(img_gray_out, img_gray_in);

% 7-9
figure (7);

subplot(2,3,1);
imagesc(H1);
colormap(gray);
title('Haar H1');

H1_q = uni_scalar(H1(:).',3);
H1_q = reshape(H1_q, size(H1,1), size(H1,2));
subplot(2,3,4);
imagesc(H1_q);
colormap(gray);
title('Haar H1_q');

subplot(2,3,2);
imagesc(H2);
colormap(gray);
title('Haar H2');

H2_q = uni_scalar(H2(:).',3);
H2_q = reshape(H2_q, size(H2,1), size(H2,2));
subplot(2,3,5);
imagesc(H2_q);
colormap(gray);
title('Haar H2_q');

subplot(2,3,3);
imagesc(H3);
colormap(gray);
title('Haar H3');

H3_q = uni_scalar(H3(:).',3);
H3_q = reshape(H3_q, size(H3,1), size(H3,2));
subplot(2,3,6);
imagesc(H3_q);
colormap(gray);
title('Haar H3_q');
suptitle('Haar Tranform - Level 1');

figure (8);

subplot(2,3,1);
imagesc(H4);
colormap(gray);
title('Haar H4');

H4_q = uni_scalar(H4(:).',5);
H4_q = reshape(H4_q, size(H4,1), size(H4,2));
subplot(2,3,4);
imagesc(H4_q);
colormap(gray);
title('Haar H4_q');

subplot(2,3,2);
imagesc(H5);
colormap(gray);
title('Haar H5');

H5_q = uni_scalar(H5(:).',5);
H5_q = reshape(H5_q, size(H5,1), size(H5,2));
subplot(2,3,5);
imagesc(H5_q);
colormap(gray);
title('Haar H5_q');

subplot(2,3,3);
imagesc(H6);
colormap(gray);
title('Haar H6');

H6_q = uni_scalar(H6(:).',5);
H6_q = reshape(H6_q, size(H6,1), size(H6,2));
subplot(2,3,6);
imagesc(H6_q);
colormap(gray);
title('Haar H6_q');
suptitle('Haar Tranform - Level 2');

figure (9);

subplot(1,3,1);
hist1 = histogram(uint8(H1_q), 'Normalization', 'probability');
prob1 = hist1.Values;
prob1 = prob1(prob1~=0);
title('Haar H1_q');

subplot(1,3,2);
hist2 = histogram(uint8(H2_q), 'Normalization', 'probability');
prob2 = hist2.Values;
prob2 = prob2(prob2~=0);
title('Haar H2_q');

subplot(1,3,3);
hist3 = histogram(uint8(H3_q), 'Normalization', 'probability');
prob3 = hist3.Values;
prob3 = prob3(prob3~=0);
title('Haar H3_q');
suptitle('Histograms - Level 1');

figure (10);

subplot(1,4,1);
hist4 = histogram(uint8(H4_q), 'Normalization', 'probability');
prob4 = hist4.Values;
prob4 = prob4(prob4~=0);
title('Haar H4_q');

subplot(1,4,2);
hist5 = histogram(uint8(H5_q), 'Normalization', 'probability');
prob5 = hist5.Values;
prob5 = prob5(prob5~=0);
title('Haar H5_q');

subplot(1,4,3);
hist6 = histogram(uint8(H6_q), 'Normalization', 'probability');
prob6 = hist6.Values;
prob6 = prob6(prob6~=0);
title('Haar H6_q');

subplot(1,4,4);
hist7 = histogram(H7, 'Normalization', 'probability');
prob7 = hist7.Values;
prob7 = prob7(prob7~=0);
title('Haar H7');
suptitle('Histograms - Level 2');

H1_sum = -sum(prob1.*log2(prob1));
H2_sum = -sum(prob2.*log2(prob2));
H3_sum = -sum(prob3.*log2(prob3));
H4_sum = -sum(prob4.*log2(prob4));
H5_sum = -sum(prob5.*log2(prob5));
H6_sum = -sum(prob6.*log2(prob6));
% H7_sum = -sum(prob7.*log2(prob7));

E2 = H1_sum + H2_sum + H3_sum + H4_sum + H5_sum + H6_sum;

% 6) Calculation of Inverse Haar Transform
img_haart_q = img_haart;
img_haart_q(1:128,129:256) = H1_q;
img_haart_q(129:256,129:256) = H2_q;
img_haart_q(129:256,1:128) = H3_q;
img_haart_q(1:64,65:128) = H4_q;
img_haart_q(65:128,65:128) = H5_q;
img_haart_q(65:128,1:64) = H6_q;

figure (11);
subplot(1,2,1);
imagesc(img_haart);
colormap(gray);
title('Haar  Tranform');

subplot(1,2,2);
imagesc(img_haart_q);
colormap(gray);
title('Haar transform - Quantized (Except Low frequencies)');

img_gray_out = img_haart_q;
for i=1:size(img_gray_out,2)/2
   img_gray_out(1:128,i) = inverse_haar_transform(img_gray_out(1:128,i).');
end

for i=1:size(img_gray_out,1)/2
   img_gray_out(i,1:128) = inverse_haar_transform(img_gray_out(i,1:128));
end

for i=1:size(img_gray_out,2)
   img_gray_out(:,i) = inverse_haar_transform(img_gray_out(:,i).');
end

for i=1:size(img_gray_out,1)
   img_gray_out(i,:) = inverse_haar_transform(img_gray_out(i,:));
end

figure (6);
subplot(1,2,2);
imagesc(img_gray_out);
colormap(gray);
[r3r5_peaksnr, r3r5_snr]=psnr(img_gray_out, img_gray_in);


