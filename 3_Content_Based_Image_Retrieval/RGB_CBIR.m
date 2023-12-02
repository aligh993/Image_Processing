% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

[FileName, PathName] = uigetfile('*.jpg', 'Select an image');
img1Org = imread(strcat(PathName, FileName));

img1E_R = im2double(img1Org(:,:,1));
img1E_G = im2double(img1Org(:,:,2));
img1E_B = im2double(img1Org(:,:,3));

histNorm1_R = imhist(img1E_R)./numel(img1E_R);
histNorm1_G = imhist(img1E_G)./numel(img1E_G);
histNorm1_B = imhist(img1E_B)./numel(img1E_B);

imshow(img1Org);
title('Original Image');
% figure('NumberTitle', 'off', 'Name', 'RGB Matching');

% c1 = 0;
c2 = 0;
% err1 = 0.0012;
err2 = 0.00087;

for i = 1:1000
    str = strcat(int2str(i-1), '.jpg');
    img2Org = imread(strcat(PathName, str));
    
    img2E_R = im2double(img2Org(:,:,1));
    img2E_G = im2double(img2Org(:,:,2));
    img2E_B = im2double(img2Org(:,:,3));
    
    histNorm2_R = imhist(img2E_R)./numel(img2E_R);
    histNorm2_G = imhist(img2E_G)./numel(img2E_G);
    histNorm2_B = imhist(img2E_B)./numel(img2E_B);
    
    F_R = sum((histNorm1_R - histNorm2_R).^2);
    F_G = sum((histNorm1_G - histNorm2_G).^2);
    F_B = sum((histNorm1_B - histNorm2_B).^2);
    
    ave = (F_R + F_G + F_B)/3;
    
    %     ------ Method 1 ------
    %     if(F_R <= err1 && F_G <= err1 && F_B <= err1)
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
figure('NumberTitle', 'off', 'Name', 'Average RGB Matching');
srt = sort(G2);
sz = size(srt, 2);

for j = 1:sz
    subplot(5,6,j);
    x = find(G2 == srt(j));
    imshow(E2{x});
    title(G2(x));
end