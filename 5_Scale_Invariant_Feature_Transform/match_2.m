% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function num = match_2(image1, image2)

[~, des1, ~] = sift(image1);
[~, des2, ~] = sift(image2);

distRatio = 0.6;

des2t = des2';
for i = 1 : size(des1,1)
    dotprods = des1(i,:) * des2t;
    [vals,indx] = sort(acos(dotprods));
    
    if (vals(1) < distRatio * vals(2))
        match(i) = indx(1);
    else
        match(i) = 0;
    end
end

num = sum(match > 0);
