% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function hybridimg(Img1, Img2, ImgFileOut, Num)
% Hybrid Image Generator
% Usage: hybridimg(<Img1>, <Img2>, <ImgOutput Filename>, <NumberChannel>);

radius = 13;   % GaussianRadius
Img1_ = fftshift(fft2(double(Img1)));
Img2_ = fftshift(fft2(double(Img2)));
[m, n , ~] = size(Img1);
h = fspecial('gaussian', [m n], radius);
h = h./max(max(h));
for colorI = 1:Num
    J_(:,:,colorI) = Img1_(:,:,colorI).*(1-h) + Img2_(:,:,colorI).*h;
end
J = uint8(real(ifft2(ifftshift(J_))));
imwrite(J, ImgFileOut);
end