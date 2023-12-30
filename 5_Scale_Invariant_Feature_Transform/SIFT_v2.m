% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

[FileName, PathName] = uigetfile('*.jpg', 'Select an image');
im1 = imread(strcat(PathName, FileName));

im2 = imresize(im1, 0.75);
im2 = imrotate(im2, 15);

num = match(im1, im2);