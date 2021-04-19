clear;
close all;
clc

[im_data, map] = imread('cameraman.tif');

down_scale = [1/2 1/4 1/8];
up_scale = [2 4 8];
mse = zeros(1,3);

figure (1);
imshow(im_data);

%%  1) Anti-aliasing filter and nearest-neighbor interpolation

for i=1:length(down_scale)
    im_resize1 = imresize(im_data, down_scale(i), 'nearest', 'Antialiasing', true);
    f = figure (i);
    imshow(im_resize1);
    %saveas(f,sprintf('DOWN_anti-alias_nearest_scale_%f.png', down_scale(i)));
    
    im_resize2 = imresize(im_resize1, up_scale(i), 'nearest');
    f1 = figure (i+3);
    imshow(im_resize2);
    mse(i) = immse(im_data, im_resize2);
    %saveas(f1,sprintf('UP_anti-alias_nearest_scale_%f.png', down_scale(i)));
end

disp('Anti-aliasing Filter with Nearest-Neighbor Interpolation');
disp('-----------------------------------------------------------');
disp(['Scale: ' num2str(down_scale)]);
disp(['MSE : ' num2str(mse)]);
disp('-----------------------------------------------------------');
disp(' ');

%%  2) No anti-aliasing filter and nearest-neighbor interpolation

for i=1:length(down_scale)
    im_resize1 = imresize(im_data, down_scale(i), 'nearest', 'Antialiasing', false);
    f = figure (i);
    imshow(im_resize1);
    %saveas(f,sprintf('DOWN_no_anti-alias_nearest_scale_%f.png', down_scale(i)));
    
    im_resize2 = imresize(im_resize1, up_scale(i), 'nearest');
    f1 = figure (i+3);
    imshow(im_resize2);
    mse(i) = immse(im_data, im_resize2);
    %saveas(f1,sprintf('UP_no_anti-alias_nearest_scale_%f.png', down_scale(i)));
end

disp('No Anti-aliasing Filter with Nearest-Neighbor Interpolation');
disp('-----------------------------------------------------------');
disp(['Scale: ' num2str(down_scale)]);
disp(['MSE : ' num2str(mse)]);
disp('-----------------------------------------------------------');
disp(' ');

%%  3) Anti-aliasing filter and bilinear interpolation

for i=1:length(down_scale)
    im_resize1 = imresize(im_data, down_scale(i), 'bilinear', 'Antialiasing', true);
    f = figure (i);
    imshow(im_resize1);
    %saveas(f,sprintf('DOWN_anti-alias_bilinear_scale_%f.png', down_scale(i)));
    
    im_resize2 = imresize(im_resize1, up_scale(i), 'bilinear');
    f1 = figure (i+3);
    imshow(im_resize2);
    mse(i) = immse(im_data, im_resize2);
    %saveas(f1,sprintf('UP_anti-alias_bilinear_scale_%f.png', down_scale(i)));
end

disp('Anti-aliasing Filter with Bilinear Interpolation');
disp('------------------------------------------------');
disp(['Scale: ' num2str(down_scale)]);
disp(['MSE : ' num2str(mse)]);
disp('------------------------------------------------');
disp(' ');

%%  4) No anti-aliasing filter and bilinear interpolation

for i=1:length(down_scale)
    im_resize1 = imresize(im_data, down_scale(i), 'bilinear', 'Antialiasing', false);
    f = figure (i);
    imshow(im_resize1);
    %saveas(f,sprintf('DOWN_no_anti-alias_bilinear_scale_%f.png', down_scale(i)));
    
    im_resize2 = imresize(im_resize1, up_scale(i), 'bilinear');
    f1 = figure (i+3);
    imshow(im_resize2);
    mse(i) = immse(im_data, im_resize2);
    %saveas(f1,sprintf('UP_no_anti-alias_bilinear_scale_%f.png', down_scale(i)));
end

disp('No Anti-aliasing Filter with Bilinear Interpolation');
disp('---------------------------------------------------');
disp(['Scale: ' num2str(down_scale)]);
disp(['MSE : ' num2str(mse)]);
disp('---------------------------------------------------');
disp(' ');

%%  5) Anti-aliasing filter and cubic interpolation

for i=1:length(down_scale)
    im_resize1 = imresize(im_data, down_scale(i), 'cubic', 'Antialiasing', true);
    f = figure (i);
    imshow(im_resize1);
    %saveas(f,sprintf('DOWN_anti-alias_cubic_scale_%f.png', down_scale(i)));
    
    im_resize2 = imresize(im_resize1, up_scale(i), 'cubic');
    f1 = figure (i+3);
    imshow(im_resize2);
    mse(i) = immse(im_data, im_resize2);
    %saveas(f1,sprintf('UP_anti-alias_cubic_scale_%f.png', down_scale(i)));
end

disp('Anti-aliasing Filter with Cubic Interpolation');
disp('---------------------------------------------');
disp(['Scale: ' num2str(down_scale)]);
disp(['MSE : ' num2str(mse)]);
disp('---------------------------------------------');
disp(' ');

%%  6) No anti-aliasing filter and cubic interpolation

for i=1:length(down_scale)
    im_resize1 = imresize(im_data, down_scale(i), 'cubic', 'Antialiasing', false);
    f = figure (i);
    imshow(im_resize1);
    %saveas(f,sprintf('DOWN_no_anti-alias_cubic_scale_%f.png', down_scale(i)));
    
    im_resize2 = imresize(im_resize1, up_scale(i), 'cubic');
    f1 = figure (i+3);
    imshow(im_resize2);
    mse(i) = immse(im_data, im_resize2);
    %saveas(f1,sprintf('UP_no_anti-alias_cubic_scale_%f.png', down_scale(i)));
end

disp('No Anti-aliasing Filter with Cubic Interpolation');
disp('------------------------------------------------');
disp(['Scale: ' num2str(down_scale)]);
disp(['MSE : ' num2str(mse)]);
disp('------------------------------------------------');
disp(' ');
