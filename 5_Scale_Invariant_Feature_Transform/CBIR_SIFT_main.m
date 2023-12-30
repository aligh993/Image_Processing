% @author: ALI GHANBARI
% @email: alighanbari446@gmail.com

close all;
clear all;
clc;

nResults = 11;
modelName = 'corelModelHist';

[FileName, PathName] = uigetfile('*.jpg', 'Select an image');
imageName = strcat(PathName, FileName);

searchImgHist_Sift(imageName, modelName, nResults);
