% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

Image = imread('Image1.jpg');
PosCircle = [280 290 110];
ColorCircle = {'red'};
Circle = insertShape(Image,'Circle',PosCircle,'Color',ColorCircle,'Opacity',1.0,'LineWidth',10);


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
        
        if (i-PosCircle(2))^2 + (j-PosCircle(1))^2 < PosCircle(3)^2
            HistogramImage(i,j) = Output(Image(i,j)+1);
        else
            HistogramImage(i,j) = Image(i,j);
        end
        
    end
end

% ----- Histogram Equalization Function ------


HistogramImage = insertShape(HistogramImage,'Circle',PosCircle,'Color',ColorCircle,'Opacity',1.0,'LineWidth',10);

subplot(1,3,1);
imshow(Image);
title("Original");
subplot(1,3,2);
imshow(Circle);
title("Circle Image");
subplot(1,3,3);
imshow(HistogramImage);
title("Histogram Image");