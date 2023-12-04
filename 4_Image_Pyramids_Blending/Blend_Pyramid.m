% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

[FileName1, PathName1] = uigetfile('*.jpg', 'Select image 1');
imga = im2double(imread(strcat(PathName1, FileName1)));
% imga = rgb2gray(imga);

[FileName2, PathName2] = uigetfile('*.jpg', 'Select image 2');
imgb = im2double(imread(strcat(PathName2, FileName2)));
% imgb = rgb2gray(imgb);

imga = imresize(imga, [size(imgb,1) size(imgb,2)]);

level = 5;
pyrImgA = genPyramid(imga, 'L', level);
pyrImgB = genPyramid(imgb, 'L', level);

figure('NumberTitle', 'off', 'Name', 'Laplacian Pyramid Image 1');
for i = 1:level
    subplot(2,3,i);
    imshow(pyrImgA{i});
    title(['Laplacian Pyramid Img_1 Level: ', num2str(i)]);
end

figure('NumberTitle', 'off', 'Name', 'Laplacian Pyramid Image 2');
for i = 1:level
    subplot(2,3,i);
    imshow(pyrImgB{i});
    title(['Laplacian Pyramid Img_2 Level: ', num2str(i)]);
end

% Image Blending Algorithm
pyrImgC = cell(1,level);
for i = 1:level
    K = size(pyrImgA{i},2);
    A = round(K/2-1); B = round(K/2); C = round(K/2+1);
    pyrImgC{i}(:,1:A,:) = pyrImgA{i}(:,1:A,:);
    pyrImgC{i}(:,B,:) = (pyrImgA{i}(:,B,:)+pyrImgB{i}(:,B,:))/2;
    pyrImgC{i}(:,C:K,:) = pyrImgB{i}(:,C:K,:);
end

imgOut = recPyramid(pyrImgC);
figure('NumberTitle', 'off', 'Name', 'Output Image');
subplot(1,3,1);
imshow(imga);
title('Image 1');
subplot(1,3,2);
imshow(imgb);
title('Image 2');
subplot(1,3,3);
imshow(imgOut);
title(['Image Blending in Laplacian Pyramid ',num2str(i),' Lvl']);