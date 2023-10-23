% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

% ------ Wiener ------

Image = imread('Image1.jpg');
PSF = fspecial('motion', 4, 3);
Image = edgetaper(Image, PSF);

redChannel = Image(:,:,1);
redChDble = im2double(redChannel);
redEstNsr = 0.0006 / var(redChDble(:));
subplot(2,3,1);
imshow(redChannel);
title('Red');

greenChannel = Image(:,:,2);
greenChDble = im2double(greenChannel);
greenEstNsr = 0.0006 / var(greenChDble(:));
subplot(2,3,2);
imshow(greenChannel);
title('Green');

blueChannel = Image(:,:,3);
blueChDble = im2double(blueChannel);
blueEstNsr = 0.0006 / var(blueChDble(:));
subplot(2,3,3);
imshow(blueChannel);
title('Blue');

WienerFRed = deconvwnr(redChDble, PSF, redEstNsr);
WienerFGreen = deconvwnr(greenChDble, PSF, greenEstNsr);
WienerFBlue = deconvwnr(blueChDble, PSF, blueEstNsr);
WFrgbImage = cat(3, WienerFRed, WienerFGreen, WienerFBlue);

subplot(2,3,4);
imshow(WienerFRed);
title('Deblurring Red');

subplot(2,3,5);
imshow(WienerFGreen);
title('Deblurring Green');

subplot(2,3,6);
imshow(WienerFBlue);
title('Deblurring Blue');

figure
subplot(1,2,1);
imshow(Image);
title('Original');

subplot(1,2,2);
imshow(WFrgbImage);
title('Deblurring Image');

% ------ Wiener ------