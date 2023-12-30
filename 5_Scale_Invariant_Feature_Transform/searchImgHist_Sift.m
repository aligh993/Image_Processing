% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

function searchImgHist_Sift(imageName, modelName, nResults)

% A - CBIR using the 3D (HSV) histogram

load(modelName);

fprintf('Computing 3D (HSV) histogram for query image ...\n');
[Hist, RGBQ] = getImageHists(imageName);

Numfiles = length(Hists);

% Decision Thresholds:
t = 0.010;
t2 = 0.8;

fprintf('Searching ...\n');

range = 0.0:0.1:1.0;
rangeNew = 0.0:0.05:1.0;
[x,y,z]    = meshgrid(range);
[x2,y2,z2] = meshgrid(rangeNew);

Hist = interp3(x,y,z,Hist,x2,y2,z2);

Simil = zeros(Numfiles, 1);

for i=1:Numfiles
    
    HistT = interp3(x, y, z, Hists{i}, x2, y2, z2);
    Difr = abs(Hist-HistT) ./ Hist;
    Difr = Difr(Hist>t);
    
    Difr2 = Difr(Difr<t2);
    L2 = length(Difr2);
    
    Simil(i) = length(Difr) * mean(Difr2) / (L2^2);
    plotThres = 0.5 * 10 / length(Difr);
    
    if (Simil(i) < plotThres)
        subplot(2,2,1); imshow(RGBQ);
        title('Query image');
        RGB = imread(files{i});
        subplot(2,2,2); imshow(RGB);
        title('A similar image ... Still Searching ...');
        subplot(2,2,3);
        plot(Difr)
        
        if (length(Difr2)>1)
            subplot(2,2,4); plot(Difr2);
            axis([1 length(Difr2) 0.2 1])
        end
        drawnow
    end
end

[Sorted, ISorted] = sort(Simil);

NRows = ceil((nResults+1) / 3);

figure('Name', 'CBIR using the 3D (HSV) histogram');
subplot(NRows,3,1); imshow(RGBQ); title('Query Image');

for i=1:nResults
    RGB = imread(files{ISorted(i)});
    str = sprintf('Img %d: %.3f',i,100*Sorted(i));
    subplot(NRows,3,i+1); imshow(RGB); title(str);
end

fprintf('CBIR using the 3D (HSV) histogram was done\n');

% B - SIFT Processing for refining and ranking the result images

fprintf('refining and ranking the result images using the SIFT ...\n');
num = zeros(nResults, 1);
fprintf('Processing ...\n');

for i=1:nResults
    RGB2 = imread(files{ISorted(i)});
    num(i) = match_2(RGBQ, RGB2);
end

[Sorted2, ISorted2] = sort(num, 'descend');

figure('Name', 'refined & ranked the result using the SIFT');
subplot(NRows,3,1); imshow(RGBQ); title('Query Image');

for i=1:nResults
    RGB2 = imread(files{ISorted(ISorted2(i))});
    str2 = sprintf('Img %d: %d',i,Sorted2(i));
    subplot(NRows,3,i+1); imshow(RGB2);  title(str2);
end

fprintf('SIFT processing was Done\n');
