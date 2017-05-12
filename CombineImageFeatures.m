clear all;
clc;

% ��� ���������� ��������� ����� ��������� ���������, ���������� � ������� 
% GetFeatureStruct.m
tic
cd Data
load ('TestFeaturesATT', 'test_features');
cd ..\
toc

% ���������� ���������,feature_num, ������� ��������.
% ����� �������� ���������� ���������� ������� �� ���������, feature_sizes.
feature_num=162336;
test_var_num=length(test_features);
feature_sizes=[43200 27600 43200 27600 20736];

% ��� ��������� ������ ���������� ������� �������� ��������� ������ �������
% ���������, px_test.
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
% ����������� ������ ��������� �������� ������ ��������: 
% (���������� �����������)x(���������� ���������)
% ��� ���������� ��� ���������� �������� ��������, ��������� ������ �
% ������� ������� �������, ��� ������ � ����� ���������
cd Data
save ('CombineTestFeatures', 'px_test', '-v7.3');
cd ..\

