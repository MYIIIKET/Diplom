clear all;
clc;

% ƒл€ выполнени€ алгоритма нужна структура признаков, полученна€ с помощью 
% GetFeatureStruct.m
tic
cd Data
load ('TestFeaturesATT', 'test_features');
cd ..\
toc

%  оличество признаков,feature_num, заранее известно.
% “акже известно количество комбинаций каждого из признаков, feature_sizes.
feature_num=162336;
test_var_num=length(test_features);
feature_sizes=[43200 27600 43200 27600 20736];

% дл€ ускорени€ работы необходимо заранее выделить требуемый размер массива
% признаков, px_test.
px_test=zeros(test_var_num, feature_num);
tic
for i=1:test_var_num
    tmp=1;
    for j=1:length(feature_sizes)
        px_test(i,tmp:tmp+feature_sizes(j)-1)=test_features(i).img(j).val;
        tmp=tmp+feature_sizes(j);
    end
end
toc
% –езультатом работы алгоритма €вл€етс€ массив размером: 
% (количество изображений)x(количество признаков)
% Ёто необходимо дл€ увеличени€ скорости обучени€, поскольку доступ к
% массиву намного быстрее, чем доступ к пол€м структуры
cd Data
save ('CombineTestFeatures', 'px_test', '-v7.3');
cd ..\

