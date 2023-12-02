% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

% ------ Notch Filter ------

% Image = rgb2gray(imread('Image3_A.jpg'));
Image = rgb2gray(imread('Image3_B.jpg'));
Ft = fftshift(fft2(Image));
F = abs(Ft);
F = log2(F);
F = mat2gray(F);

subplot(2,2,1);
imshow(Image);
title('Original');

subplot(2,2,2);
imshow(F);
title('FT Image');

% imwrite(F,'Pic3_A_1.jpg');
imwrite(F,'Pic3_B_1.jpg');

% Image2 = imread('Pic3_A_2.jpg');
Image2 = imread('Pic3_B_2.jpg');
subplot(2,2,3);
imshow(Image2);
title('Filter FT Image');

Filter = complex(double(Image2));
Ftx = Ft.*Filter;
F2 = ifft2(ifftshift(Ftx));
F2 = abs(F2);
F2 = mat2gray(F2);

subplot(2,2,4);
imshow(F2);
title('Edited Image');

% ------ Notch Filter ------