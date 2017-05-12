clear all;
clc;

% ��� ������������ ��������� ��������� ���������� ������������ ���������
% �����������, �������������� � GetImageStruct.m
cd Data
load ('TestVarATT', 'test_var');
cd ..\

% test_features - ��������� ��������� ��� ������� �����������
n=length(test_var.i);
test_features(n)=struct();
tic
for i=1:n
% ����������� GetFeaturesValues �������� ��������� ��������� ��� ������
% �����������
    pfx=GetFeaturesValues(test_var.i(i).img);
    test_features(i).img=pfx;
end
toc

cd Data
save ('TestFeaturesATT', 'test_features', '-v7.3');
cd ..\