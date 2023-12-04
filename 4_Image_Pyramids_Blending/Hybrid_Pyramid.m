% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

[FileName1, PathName1] = uigetfile('*.jpg', 'Select image 1');
imga = im2double(imread(strcat(PathName1, FileName1)));

[FileName2, PathName2] = uigetfile('*.jpg', 'Select image 2');
imgb = im2double(imread(strcat(PathName2, FileName2)));

imga = imresize(imga, [size(imgb,1) size(imgb,2)]);

level = 3;
pyrImgA = genPyramid(imga, 'L', level);
pyrImgB = genPyramid(imgb, 'L', level);
pyrImgA{level} = pyrImgB{level};

figure('NumberTitle', 'off', 'Name', 'Laplacian Pyramid Image 1');
for i = 1:level
    subplot(1,3,i);
    imshow(pyrImgA{i});
    title(['Laplacian Pyramid Img_1 Level: ', num2str(i)]);
end

figure('NumberTitle', 'off', 'Name', 'Laplacian Pyramid Image 2');
for i = 1:level
    subplot(1,3,i);
    imshow(pyrImgB{i});
    title(['Laplacian Pyramid Img_2 Level: ', num2str(i)]);
end

imgOut = recPyramid(pyrImgA);
figure('NumberTitle', 'off', 'Name', 'Output Image');
subplot(1,3,1);
imshow(imga);
title('Image 1');
subplot(1,3,2);
imshow(imgb);
title('Image 2');
subplot(1,3,3);
imshow(imgOut);
title('Hybrid Image in Laplacian Pyramid');