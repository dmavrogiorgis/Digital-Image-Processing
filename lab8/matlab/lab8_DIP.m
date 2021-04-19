clear;
close all;

% 1) Read the image
figure (1);
I = double(imread('cameraman.tif'));
subplot(1,2,1);
imagesc(I);
colormap(gray);
title('Original Image');

% 2) Resize the image
I_new = imresize(I, [30 30]);
subplot(1,2,2);
imagesc(I_new);
colormap(gray);
title('Rescaled Image');

% 3) Compute FFT of the rescaled image
I_new_fft2 = fft2(I_new);
figure (2);
subplot(2,2,1);
imagesc(abs(I_new_fft2));
colormap(gray);
title('Fourier Transform');

subplot(2,2,3);
imagesc(abs(I_new_fft2)^2);
colormap(gray);
title('Spectrum');

subplot(2,2,2);
imagesc(log(1 + abs(I_new_fft2)));
colormap(gray);
title('Fourier Transform (log)');

subplot(2,2,4);
imagesc(log(1 + abs(I_new_fft2)^2));
colormap(gray);
title('Spectrum (log)');

% 4) Compute FFT SHIFT of the rescaled image
I_new_fft2_shift = fftshift(I_new_fft2);
figure (3);
subplot(2,2,1);
imagesc(abs(I_new_fft2_shift));
colormap(gray);
title('Centered Fourier Transform');

I_new_fft2_shift = fftshift(I_new_fft2);
subplot(2,2,3);
imagesc(abs(I_new_fft2_shift)^2);
colormap(gray);
title('Centered Spectrum');

subplot(2,2,2);
imagesc(log(1 + abs(I_new_fft2_shift)));
colormap(gray);
title('Centered Fourier Transform (log)');

I_new_fft2_shift = fftshift(I_new_fft2);
subplot(2,2,4);
imagesc(log(1 + abs(I_new_fft2_shift)^2));
colormap(gray);
title('Centered Spectrum (log)');

% 5) Construct and illustrate a 2D Gaussian Filter with sigma 0.8
sigma = 0.8;
[X,Y] = meshgrid(-4:4, -4:4);
G = 1/(2*pi*(sigma^2)) .* exp(-(X.^2 + Y.^2)/(2*sigma^2));
figure (4);
subplot(1,3,1);
mesh(X,Y,G);
title('Gaussian Filter');

% 6-7) Compute and illustrate the FFT and FFT SHIFT of the Gaussian filter 
% in space and in frequency
G_fft2 = (fft2(G));
subplot(1,3,2);
mesh(X,Y,abs(G_fft2));
title('Gaussian Filter - Fourier Tranform');

G_fft2_shift = fftshift(G_fft2);
subplot(1,3,3);
mesh(X,Y,abs(G_fft2_shift));
title('Gaussian Filter - Centered Fourier Transform');

% 8) Compute the convolution of the rescaled image and the Gaussian filter
I_new_conv = conv2(I_new, G, 'same');
figure (5);
subplot(1,3,1);
imagesc(I_new_conv);
colormap(gray);
title('Convolution I_{new} * G');

% 9-10) Compute the product of FFT of the image and FFT of the Gaussian and
% then the inverse FFT to reconstruct the rescaled image 
I_prod = fft2(I_new,38,38) .* fft2(G,38,38);
I_new_prod = ifft2(I_prod);
I_new_prod = imcrop(I_new_prod, [5 5 29 29]);
subplot(1,3,2);
imagesc(I_new_prod);
colormap(gray);
title('Inverse Product I_{new} x G');

% Compute the toeplitz matrix and its product with the rescaled vectorized 
% image. Then reshape the vector to matrix again and illustrate the result
I_new_row = size(I_new,1);
I_new_col = size(I_new,2);

G_row = size(G,1);
G_col = size(G,2);

I_out_row = I_new_row + G_row - 1;
I_out_col = I_new_col + G_col - 1;

G = padarray(G, I_out_row - G_row, 'pre');
G = padarray(G, [0 I_out_col - G_col], 'post');

toeplitz_matrices = zeros(I_out_col, I_out_col - G_col + 1, I_out_row);

%Compute all the toeplitz sub-matrices
for i=I_out_row:-1:1
    c = G(i,:);
    r = [c(1) zeros(1, I_out_col - G_col)];

    toeplitz_matrices(:,:,I_out_row - i + 1) = toeplitz(c,r);
end

% Concatenate all of them to calculate the first column
for j=1:size(toeplitz_matrices,3)
    if j == 1
        t_cat = toeplitz_matrices(:,:,1);
    else
        t_cat = cat(1, t_cat, toeplitz_matrices(:,:,j));
    end          
end

% Calculate the other columns
for i=1:I_new_col-1
    t_cat(:,:,i+1) = circshift(t_cat(:,:,i),I_out_col,1);
end

% Concatenate all the columns
for i=1:size(t_cat,3)
    if i == 1
        toeplitz_matrix = t_cat(:,:,1);
    else
        toeplitz_matrix = cat(2, toeplitz_matrix, t_cat(:,:,i));
    end   
end

% Vectorize from bottom-up the rescaled image 
I_new = flip(I_new);   
I_new_vect = zeros(1,I_new_row*I_new_col);  
for i=1:I_new_row
    for j=1:I_new_col
        I_new_vect((i-1)*I_new_col + j) = I_new(i,j);
    end
end

% Compute the convolution and illustrate the results
I_toeplitz = toeplitz_matrix * I_new_vect.';
I_new_toeplitz = reshape(I_toeplitz, I_out_col, I_out_row);
I_new_toeplitz = flip(I_new_toeplitz.');
I_new_toeplitz = imcrop(I_new_toeplitz, [5 5 29 29]);
subplot(1,3,3);
imagesc(I_new_toeplitz);
colormap(gray);
title('Toeplitz Convolution T x I_{new}');

mse_1_2 = immse(I_new_conv,I_new_prod);
mse_1_3 = immse(I_new_conv,I_new_toeplitz);
mse_2_3 = immse(I_new_prod,I_new_toeplitz);


