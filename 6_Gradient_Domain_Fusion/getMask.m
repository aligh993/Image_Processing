% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function [mask] = getMask(im)

figure(1), hold off, imagesc(im), axis image;
title('Draw polygon around source object, then press (e) to continue');
sx = [];
sy = [];
while 1
    figure(1)
    [x, y, b] = ginput(1);
    if b=='e'
        break;
    end
    sx(end+1) = x;
    sy(end+1) = y;
    hold on, plot(sx, sy, '*-', 'LineWidth', 2);
end

mask = poly2mask(sx, sy, size(im, 1), size(im, 2));

end