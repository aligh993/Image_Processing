% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

% ------ Highboost ------

Image = imread('Image1.jpg');
GrayImage = rgb2gray(Image);

redChannel = Image(:,:,1);
subplot(2,3,1);
imshow(redChannel);
title('Red');

greenChannel = Image(:,:,2);
subplot(2,3,2);
imshow(greenChannel);
title('Green');

blueChannel = Image(:,:,3);
subplot(2,3,3);
imshow(blueChannel);
title('Blue');

HighBoost = [0 -1 0; -1 5 -1; 0 -1 0];
fr = imfilter(redChannel,HighBoost);
fg = imfilter(greenChannel,HighBoost);
fb = imfilter(blueChannel,HighBoost);
rgbImage = cat(3, fr, fg, fb);
fgray = imfilter(GrayImage,HighBoost);

subplot(2,3,4);
imshow(fr);
title('Highboost Red');

subplot(2,3,5);
imshow(fg);
title('Highboost Green');

subplot(2,3,6);
imshow(fb);
title('Highboost Blue');

figure
subplot(1,3,1);
imshow(Image);
title('Original');

subplot(1,3,2);
imshow(rgbImage);
title('Highboost Image');

subplot(1,3,3);
imshow(fgray);
title('Highboost GrayImage');

% ------ Highboost ------