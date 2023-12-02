% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

[FileName, PathName] = uigetfile('*.jpg', 'Select an image');
img1Org = imread(strcat(PathName, FileName));
hsv1 = rgb2hsv(img1Org);

img1Half = fix(size(hsv1,1)/2);
img1Half_1 = hsv1(1:img1Half,:,:);
img1Half_2 = hsv1(img1Half+1:end,:,:);

img1E_H_H1 = im2double(img1Half_1(:,:,1));
img1E_S_H1 = im2double(img1Half_1(:,:,2));
img1E_V_H1 = im2double(img1Half_1(:,:,3));

img1E_H_H2 = im2double(img1Half_2(:,:,1));
img1E_S_H2 = im2double(img1Half_2(:,:,2));
img1E_V_H2 = im2double(img1Half_2(:,:,3));

histNorm1_H_H1 = imhist(img1E_H_H1)./numel(img1E_H_H1);
histNorm1_S_H1 = imhist(img1E_S_H1)./numel(img1E_S_H1);
histNorm1_V_H1 = imhist(img1E_V_H1)./numel(img1E_V_H1);

histNorm1_H_H2 = imhist(img1E_H_H2)./numel(img1E_H_H2);
histNorm1_S_H2 = imhist(img1E_S_H2)./numel(img1E_S_H2);
histNorm1_V_H2 = imhist(img1E_V_H2)./numel(img1E_V_H2);

imshow(img1Org);
title('Original Image');
figure;
subplot(2,1,1);
imshow(img1Half_1);
title('Half_1 Image');
subplot(2,1,2);
imshow(img1Half_2);
title('Half_2 Image');
% figure('NumberTitle', 'off', 'Name', 'HSV Matching (Half)');

% c1 = 0;
c2 = 0;
% err1 = 0.009;
err2 = 0.0195;

for i = 1:1000
    str = strcat(int2str(i-1), '.jpg');
    img2Org = imread(strcat(PathName, str));
    hsv2 = rgb2hsv(img2Org);
    
    img2Half = fix(size(hsv2,1)/2);
    img2Half_1 = hsv2(1:img2Half,:,:);
    img2Half_2 = hsv2(img2Half+1:end,:,:);
    
    img2E_H_H1 = im2double(img2Half_1(:,:,1));
    img2E_S_H1 = im2double(img2Half_1(:,:,2));
    img2E_V_H1 = im2double(img2Half_1(:,:,3));
    
    img2E_H_H2 = im2double(img2Half_2(:,:,1));
    img2E_S_H2 = im2double(img2Half_2(:,:,2));
    img2E_V_H2 = im2double(img2Half_2(:,:,3));
    
    histNorm2_H_H1 = imhist(img2E_H_H1)./numel(img2E_H_H1);
    histNorm2_S_H1 = imhist(img2E_S_H1)./numel(img2E_S_H1);
    histNorm2_V_H1 = imhist(img2E_V_H1)./numel(img2E_V_H1);
    
    histNorm2_H_H2 = imhist(img2E_H_H2)./numel(img2E_H_H2);
    histNorm2_S_H2 = imhist(img2E_S_H2)./numel(img2E_S_H2);
    histNorm2_V_H2 = imhist(img2E_V_H2)./numel(img2E_V_H2);
    
    F_H_H1 = sum((histNorm1_H_H1 - histNorm2_H_H1).^2);
    F_S_H1 = sum((histNorm1_S_H1 - histNorm2_S_H1).^2);
    F_V_H1 = sum((histNorm1_V_H1 - histNorm2_V_H1).^2);
    
    F_H_H2 = sum((histNorm1_H_H2 - histNorm2_H_H2).^2);
    F_S_H2 = sum((histNorm1_S_H2 - histNorm2_S_H2).^2);
    F_V_H2 = sum((histNorm1_V_H2 - histNorm2_V_H2).^2);
    
    ave = (F_H_H1 + F_S_H1 + F_V_H1 + F_H_H2 + F_S_H2 + F_V_H2)/6;
    
    %     ------ Method 1 ------
    %     if(F_H_H1 <= err1 && F_S_H1 <= err1 && F_V_H1 <= err1 && ...
    %             F_H_H2 <= err1 && F_S_H2 <= err1 && F_V_H2 <= err1)
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
figure('NumberTitle', 'off', 'Name', 'Average HSV Matching (Half)');
srt = sort(G2);
sz = size(srt, 2);

for j = 1:sz
    subplot(5,6,j);
    x = find(G2 == srt(j));
    imshow(E2{x});
    title(G2(x));
end