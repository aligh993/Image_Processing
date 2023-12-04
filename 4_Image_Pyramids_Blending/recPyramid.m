% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function [outImg] = recPyramid(inpPyr)
% Reconstruction Pyramid

for i = length(inpPyr)-1:-1:1
    inpPyr{i} = inpPyr{i} + impyramid(inpPyr{i+1}, 'expand');
end
outImg = inpPyr{1};

end