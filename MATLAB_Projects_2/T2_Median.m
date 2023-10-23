% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

% ------ Median Filter ------

Image = rgb2gray(imread('Image2.jpg'));

Median3x3 = medfilt2(Image,[3 3]);
Median5x5 = medfilt2(Image,[5 5]);

subplot(1,3,1);
imshow(Image);
title('Original');

subplot(1,3,2);
imshow(Median3x3);
title('Median 3x3');

subplot(1,3,3);
imshow(Median5x5);
title('Median 5x5');

% ------ Median Filter ------