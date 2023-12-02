% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

[FileName, PathName] = uigetfile('*.jpg', 'Select an image');
img1Org = imread(strcat(PathName, FileName));
hsv1 = rgb2hsv(img1Org);

img1E_H = im2double(hsv1(:,:,1));
img1E_S = im2double(hsv1(:,:,2));
img1E_V = im2double(hsv1(:,:,3));

histNorm1_H = imhist(img1E_H)./numel(img1E_H);
histNorm1_S = imhist(img1E_S)./numel(img1E_S);
histNorm1_V = imhist(img1E_V)./numel(img1E_V);

imshow(img1Org);
title('Original Image');
% figure('NumberTitle', 'off', 'Name', 'HSV Matching');

% c1 = 0;
c2 = 0;
% err1 = 0.02;
err2 = 0.0262;

for i = 1:1000
    str = strcat(int2str(i-1), '.jpg');
    img2Org = imread(strcat(PathName, str));
    hsv2 = rgb2hsv(img2Org);
    
    img2E_H = im2double(hsv2(:,:,1));
    img2E_S = im2double(hsv2(:,:,2));
    img2E_V = im2double(hsv2(:,:,3));
    
    histNorm2_H = imhist(img2E_H)./numel(img2E_H);
    histNorm2_S = imhist(img2E_S)./numel(img2E_S);
    histNorm2_V = imhist(img2E_V)./numel(img2E_V);
    
    F_H = sum((histNorm1_H - histNorm2_H).^2);
    F_S = sum((histNorm1_S - histNorm2_S).^2);
    F_V = sum((histNorm1_V - histNorm2_V).^2);
    
    ave = (F_H + F_S + F_V)/3;
    
    %     ------ Method 1 ------
    %     if(F_H <= err1 && F_S <= err1 && F_V <= err1)
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
figure('NumberTitle', 'off', 'Name', 'Average HSV Matching');
srt = sort(G2);
sz = size(srt, 2);

for j = 1:sz
    subplot(5,6,j);
    x = find(G2 == srt(j));
    imshow(E2{x});
    title(G2(x));
end