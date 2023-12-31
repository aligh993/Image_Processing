% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

[FileName1, PathName1] = uigetfile({'*.jpg;*.tif;*.png;*.gif',...
    'All Image Files';'*.*','All Files' }, 'Select Source image');
im_source = im2double(imread(strcat(PathName1, FileName1)));

[FileName2, PathName2] = uigetfile({'*.jpg;*.tif;*.png;*.gif',...
    'All Image Files';'*.*','All Files' }, 'Select Target image');
im_target = im2double(imread(strcat(PathName2, FileName2)));


src_mask = getMask(im_source);
[im_s, mask_s] = alignSource(im_source, src_mask, im_target);


im_poisBlend = poissonBlend(im_s, mask_s, im_target);
imwrite(im_poisBlend, 'Output_Images/Poisson_Blend.jpg');
subplot(1,3,2), imshow(im_poisBlend), title('Poisson Blend');

im_mixGradient = mixedGradient(im_s, mask_s, im_target);
imwrite(im_mixGradient, 'Output_Images/Mixed_Gradients_Blend.jpg');
subplot(1,3,3), imshow(im_mixGradient), title('Mixed Gradients Blend');