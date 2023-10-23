% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

% ------ Unsharp Masking ------

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

Unsharp = padarray(2,[2 2]) - fspecial('gaussian' ,[5 5],2);
Unsharp2 = imsharpen(Image);
fr = imfilter(redChannel,Unsharp);
fg = imfilter(greenChannel,Unsharp);
fb = imfilter(blueChannel,Unsharp);
rgbImage = cat(3, fr, fg, fb);
fgray = imfilter(GrayImage,Unsharp);

subplot(2,3,4);
imshow(fr);
title('Unsharp Red');

subplot(2,3,5);
imshow(fg);
title('Unsharp Green');

subplot(2,3,6);
imshow(fb);
title('Unsharp Blue');

figure
subplot(2,2,1);
imshow(Image);
title('Original');

subplot(2,2,2);
imshow(rgbImage);
title('Unsharp Image');

subplot(2,2,3);
imshow(fgray);
title('Unsharp GrayImage');

subplot(2,2,4);
imshow(Unsharp2);
title('Unsharp2 GrayImage');

% ------ Unsharp Masking ------