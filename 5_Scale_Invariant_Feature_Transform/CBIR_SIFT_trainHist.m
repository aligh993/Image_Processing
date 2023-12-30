% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

numTrainImg = 995;  % Number of Training Sampels

[~, PathName] = uigetfile('*.jpg', 'Select Training Images Folder');
PathName = erase(PathName, strcat(pwd, '\'));

Hists = cell(1, numTrainImg);
files = cell(1, numTrainImg);

for i = 1:numTrainImg
    str = strcat(int2str(i-1), '.jpg');
    str = strcat(PathName, str);
    
    [Hist, ~] = getImageHists(str);
    Hists{i} = Hist;
    files{i} = str;
end

save corelModelHist.mat Hists files;
clear Hists files

mat = matfile('corelModelHist.mat');
