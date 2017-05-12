clear all;
clc;

% Для формирования структуры признаков необходимо использовать структуру
% изображений, использованных в GetImageStruct.m
cd Data
load ('TestVarATT', 'test_var');
cd ..\

% test_features - структура признаков для каждого изображения
n=length(test_var.i);
test_features(n)=struct();
tic
for i=1:n
% Результатом GetFeaturesValues является структура признаков для одного
% изображения
    pfx=GetFeaturesValues(test_var.i(i).img);
    test_features(i).img=pfx;
end
toc

cd Data
save ('TestFeaturesATT', 'test_features', '-v7.3');
cd ..\