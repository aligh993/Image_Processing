% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

% ------ Adaptive Median Filter ------

Image = rgb2gray(imread('Image2.jpg'));

adpMedian3 = adpmedian(Image, 3);
adpMedian5 = adpmedian(Image, 5);
adpMedian7 = adpmedian(Image, 7);

subplot(2,2,1);
imshow(Image);
title('Original');

subplot(2,2,2);
imshow(adpMedian3);
title('Adaptive Median 3');

subplot(2,2,3);
imshow(adpMedian5);
title('Adaptive Median 5');

subplot(2,2,4);
imshow(adpMedian7);
title('Adaptive Median 7');

% ------ Adaptive Median Filter ------