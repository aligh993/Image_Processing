% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function [im_s2, mask2] = alignSource(im_s, mask, im_t)
tempT = im_t;
figure(2), hold off, imagesc(tempT), axis image;
[y, x] = find(mask);
y1 = min(y)-1; y2 = max(y)+1; x1 = min(x)-1; x2 = max(x)+1;
im_s2 = zeros(size(im_t));
title('Choose target bottom-center location');
[tx, ty] = ginput(1);

yind = (y1:y2);
yind2 = yind - max(y) + round(ty);
xind = (x1:x2);
xind2 = xind - round(mean(x)) + round(tx);

y = y - max(y) + round(ty);
x = x - round(mean(x)) + round(tx);
ind = y + (x-1)*size(im_t, 1);
mask2 = false(size(im_t, 1), size(im_t, 2));
mask2(ind) = true;

im_s2(yind2, xind2, :) = im_s(yind, xind, :);
im_t(repmat(mask2, [1 1 3])) = im_s2(repmat(mask2, [1 1 3]));
imwrite(im_t, 'Output_Images/Naive_Blend.jpg');
figure(1), hold off, subplot(1,3,1), imshow(im_s), title('Source Image');
subplot(1,3,2), imshow(mask), title('Mask');
subplot(1,3,3), imshow(tempT), title('Traget Image');
figure(2), hold off, subplot(1,3,1), imshow(im_t), title('Naive Blend');
drawnow;