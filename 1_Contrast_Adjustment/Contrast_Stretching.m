% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

Image = rgb2gray(imread('Image2.jpg'));
[X,Y] = size(Image);
ContrastStrchImage = Image;
listLevel = 0:256;


% ----- Contrast Stretching ------

for i = 1:X
    for j = 1:Y
        
        listLevel(Image(i,j)) = Image(i,j);
        
    end
end

Templevel = listLevel;
maxlevel = max(listLevel);
a = input('Enter any value for 1st break point(a): ');
b = input('Enter any value for 2nd break point(b): ');
ya = input('Enter any value for 1st break point(Ya): ');
yb = input('Enter any value for 2nd break point(Yb): ');
h = input('Enter any value for 2nd break point(h): ');
r = input('Enter any value for 2nd break point(r): ');
ax = input('Enter any value for 2nd break point(ax): ');

for k = 1:256
    
    x1 = listLevel(k);
    y1 = listLevel(k);
    if(a>=0 && a<x1)
        y1 = ax*x1;
    end
    if(x1>=a && x1<b)
        y1 = h*(x1-a)+ya;
    end
    if(x1>=b && x1<maxlevel)
        y1 = r*(x1-b)+yb;
    end
    if (y1>maxlevel)
        y1 = maxlevel;
    end
    listLevel(k) = y1;
    
end

for i = 1:X
    for j = 1:Y
        
        ContrastStrchImage(i,j) = listLevel(Image(i,j));
        
    end
end

% ----- Contrast Stretching ------


subplot(2,3,1);
imshow(Image);
title('Original');
subplot(2,3,2);
plot(Templevel);
title('Histogram Image');
subplot(2,3,3);
imhist(Image);
title('Histogram Image');
subplot(2,3,4);
imshow(ContrastStrchImage);
title('ContrastStrch Image');
subplot(2,3,5);
plot(listLevel);
titleinput=strcat('[a=',num2str(a));
titleinput=strcat(titleinput,strcat(' b=',num2str(b)));
titleinput=strcat(titleinput,strcat(' ya=',num2str(ya)));
titleinput=strcat(titleinput,strcat(' yb=',num2str(yb)));
titleinput=strcat(titleinput,strcat(' h=',num2str(h)));
titleinput=strcat(titleinput,strcat(' r=',num2str(r)));
titleinput=strcat(titleinput,strcat(' ax=',num2str(ax)));
titleinput=strcat(titleinput,']');
title(strcat('Parameter ',titleinput));
subplot(2,3,6);
imhist(ContrastStrchImage);
title('Histogram Image');