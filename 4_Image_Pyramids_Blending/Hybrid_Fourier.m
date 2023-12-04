% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

[FileName1, PathName1] = uigetfile('*.jpg', 'Select image 1');
img1 = imread(strcat(PathName1, FileName1));
[m1, n1, z1] = size(img1);

[FileName2, PathName2] = uigetfile('*.jpg', 'Select image 2');
img2 = imread(strcat(PathName2, FileName2));
[m2, n2, z2] = size(img2);

if(m1~=m2 && n1~=n2)
    img1 = imresize(img1,[size(img2,1) size(img2,2)]);
end

if(z1==3 && z2==3)
    num = 3;
elseif(z1==1 && z2==1)
    num = 1;
elseif(z1==1 && z2==3)
    num = 1;
    img2 = rgb2gray(img2);
elseif(z1==3 && z2==1)
    num = 1;
    img1 = rgb2gray(img1);
end

hybridimg(img1, img2, 'HybridImg.jpg', num);
figure('NumberTitle', 'off', 'Name', 'Output Image');
subplot(1,3,1);
imshow(img1);
title('Image 1');
subplot(1,3,2);
imshow(img2);
title('Image 2');
subplot(1,3,3);
imshow('HybridImg.jpg');
title('Hybrid Image');