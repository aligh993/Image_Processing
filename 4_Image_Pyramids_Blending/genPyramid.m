% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function [outPyr] = genPyramid(inpImg, type, level)
% Generate Gaussian or Laplacian Pyramid

ImgG = cell(1,level);
ImgL = cell(1,level);

ImgG{1} = inpImg;
for i = 2:level
    ImgG{i} = impyramid(ImgG{i-1}, 'reduce');
end

for i = level-1:-1:1
    imSZ = size(ImgG{i+1})*2-1;
    ImgG{i} = ImgG{i}(1:imSZ(1), 1:imSZ(2), :);
end

for i = 1:level-1
    ImgL{i} = ImgG{i} - impyramid(ImgG{i+1}, 'expand');
end
ImgL{level} = ImgG{level};

if(type == 'G')  % Gaussian pyramid
    outPyr = ImgG;
elseif(type == 'L')  % Laplacian pyramid
    outPyr = ImgL;
end

end