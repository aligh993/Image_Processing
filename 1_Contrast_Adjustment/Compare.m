% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

Image = rgb2gray(imread('Image2.jpg'));
[X,Y] = size(Image);
ContrastStrchImage = Image;
listLevel = 0:256;

HisteqImg = histeq(Image);

% ----- Histogram Equalization Function ------

NumOfPixels = size(Image,1)*size(Image,2);
HistogramImage = uint8(zeros(size(Image,1),size(Image,2)));
Freq = zeros(256,1);
Probf = zeros(256,1);
Probc = zeros(256,1);
Cum = zeros(256,1);
Output = zeros(256,1);

for i = 1:size(Image,1)
    for j = 1:size(Image,2)
       
        value = Image(i,j);
        Freq(value+1) = Freq(value+1)+1;
        Probf(value+1) = Freq(value+1)/NumOfPixels;
        
    end
end

sum = 0;
no_bins = 255;

for i = 1:size(Probf)
    
    sum = sum+Freq(i);
    Cum(i) = sum;
    Probc(i) = Cum(i)/NumOfPixels;
    Output(i) = round(Probc(i)*no_bins);
    
end

for i = 1:size(Image,1)
    for j = 1:size(Image,2)
        
        HistogramImage(i,j) = Output(Image(i,j)+1);
        
    end
end

% ----- Histogram Equalization Function ------


% ----- Contrast Stretching ------

for i = 1:X
    for j = 1:Y
        
        listLevel(Image(i,j)) = Image(i,j);
        
    end
end

Templevel = listLevel;
maxlevel = max(listLevel);
a = 100;
b = 160;
ya = 30;
yb = 90;
h = 1;
r = 4;
ax = 0.5;

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


subplot(2,4,1);
imshow(Image);
title('Original');
subplot(2,4,2);
imshow(HistogramImage);
title("MyHistFunc Image");
subplot(2,4,3);
imshow(ContrastStrchImage);
title('ContrastStrch Image');
subplot(2,4,4);
imshow(HisteqImg);
title('Histeq Image');
subplot(2,4,5);
imhist(Image);
title('Histogram Original');
subplot(2,4,6);
imhist(HistogramImage);
title('Histogram MyHistFunc');
subplot(2,4,7);
imhist(ContrastStrchImage);
title('Histogram ContrastStrch');
subplot(2,4,8);
imhist(HisteqImg);
title('Histogram Histeq');