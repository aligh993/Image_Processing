% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

[FileName, PathName] = uigetfile('*.jpg', 'Select an image');
im1 = imread(strcat(PathName, FileName));
[image, ~, locs] = sift(im1);
showkeys(image, locs);
x1 = locs(:, 2);
y1 = locs(:, 1);
figure, imshow(im1), hold on, plot(x1, y1, 'rs'), hold off;

im2 = imresize(im1, 0.75);
im2 = imrotate(im2, 15);
[image2, ~, locs2] = sift(im2);
showkeys(image2, locs2);
x2 = locs2(:, 2);
y2 = locs2(:, 1);
figure, imshow(im2), hold on, plot(x2, y2, 'rs'), hold off;