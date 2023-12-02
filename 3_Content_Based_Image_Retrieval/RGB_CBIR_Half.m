% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

[FileName, PathName] = uigetfile('*.jpg', 'Select an image');
img1Org = imread(strcat(PathName, FileName));

img1Half = fix(size(img1Org,1)/2);
img1Half_1 = img1Org(1:img1Half,:,:);
img1Half_2 = img1Org(img1Half+1:end,:,:);

img1E_R_H1 = im2double(img1Half_1(:,:,1));
img1E_G_H1 = im2double(img1Half_1(:,:,2));
img1E_B_H1 = im2double(img1Half_1(:,:,3));

img1E_R_H2 = im2double(img1Half_2(:,:,1));
img1E_G_H2 = im2double(img1Half_2(:,:,2));
img1E_B_H2 = im2double(img1Half_2(:,:,3));

histNorm1_R_H1 = imhist(img1E_R_H1)./numel(img1E_R_H1);
histNorm1_G_H1 = imhist(img1E_G_H1)./numel(img1E_G_H1);
histNorm1_B_H1 = imhist(img1E_B_H1)./numel(img1E_B_H1);

histNorm1_R_H2 = imhist(img1E_R_H2)./numel(img1E_R_H2);
histNorm1_G_H2 = imhist(img1E_G_H2)./numel(img1E_G_H2);
histNorm1_B_H2 = imhist(img1E_B_H2)./numel(img1E_B_H2);

imshow(img1Org);
title('Original Image');
figure;
subplot(2,1,1);
imshow(img1Half_1);
title('Half_1 Image');
subplot(2,1,2);
imshow(img1Half_2);
title('Half_2 Image');
% figure('NumberTitle', 'off', 'Name', 'RGB Matching (Half)');

% c1 = 0;
c2 = 0;
% err1 = 0.009;
err2 = 0.12;

for i = 1:1000
    str = strcat(int2str(i-1), '.jpg');
    img2Org = imread(strcat(PathName, str));
    
    img2Half = fix(size(img2Org,1)/2);
    img2Half_1 = img2Org(1:img2Half,:,:);
    img2Half_2 = img2Org(img2Half+1:end,:,:);
    
    img2E_R_H1 = im2double(img2Half_1(:,:,1));
    img2E_G_H1 = im2double(img2Half_1(:,:,2));
    img2E_B_H1 = im2double(img2Half_1(:,:,3));
    
    img2E_R_H2 = im2double(img2Half_2(:,:,1));
    img2E_G_H2 = im2double(img2Half_2(:,:,2));
    img2E_B_H2 = im2double(img2Half_2(:,:,3));
    
    histNorm2_R_H1 = imhist(img2E_R_H1)./numel(img2E_R_H1);
    histNorm2_G_H1 = imhist(img2E_G_H1)./numel(img2E_G_H1);
    histNorm2_B_H1 = imhist(img2E_B_H1)./numel(img2E_B_H1);
    
    histNorm2_R_H2 = imhist(img2E_R_H2)./numel(img2E_R_H2);
    histNorm2_G_H2 = imhist(img2E_G_H2)./numel(img2E_G_H2);
    histNorm2_B_H2 = imhist(img2E_B_H2)./numel(img2E_B_H2);
    
    F_R_H1 = sum((histNorm1_R_H1 - histNorm2_R_H1).^2);
    F_G_H1 = sum((histNorm1_G_H1 - histNorm2_G_H1).^2);
    F_B_H1 = sum((histNorm1_B_H1 - histNorm2_B_H1).^2);
    
    F_R_H2 = sum((histNorm1_R_H2 - histNorm2_R_H2).^2);
    F_G_H2 = sum((histNorm1_G_H2 - histNorm2_G_H2).^2);
    F_B_H2 = sum((histNorm1_B_H2 - histNorm2_B_H2).^2);
    
    ave = (F_R_H1 + F_G_H1 + F_B_H1 + F_R_H2 + F_G_H2 + F_B_H2)/6;
    
    %     ------ Method 1 ------
    %     if(F_R_H1 <= err1 && F_G_H1 <= err1 && F_B_H1 <= err1 && ...
    %             F_R_H2 <= err1 && F_G_H2 <= err1 && F_B_H2 <= err1)
    %         c1 = c1 + 1;
    %         E1{c1} = img2Org;
    %         subplot(5,6,c1);
    %         imshow(E1{c1});
    %     end
    
    %     ------ Method 2 ------
    if(ave <= err2)
        c2 = c2 + 1;
        E2{c2} = img2Org;
        G2(c2) = ave;
    end
end

% ascending sort
figure('NumberTitle', 'off', 'Name', 'Average RGB Matching (Half)');
srt = sort(G2);
sz = size(srt, 2);

for j = 1:sz
    subplot(5,6,j);
    x = find(G2 == srt(j));
    imshow(E2{x});
    title(G2(x));
end