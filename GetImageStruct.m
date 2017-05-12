clear all;
clc;

% pos_num � neg_num - ������� ��������� ���������� ���������� � ���������� 
% ��������
pos_num=80; 
neg_num=160;
% num - ����� ���������� ������������� �������
num=pos_num+neg_num;
k=1;
% test_var - ���������, ���������� �����������
test_var=[];
test_var.i(num)=struct();

% ��� ��������� ������ ���������� ������� �������� ����������� ������
% �������� ������ ����������� - ������� 25x25
for i=1:num
    test_var.i(i).img=zeros(25, 25);
end

txt='';

% ���������� ��������� ������������� ���
tic
cd test_pos
files = dir('*.pgm');
for id = 1:pos_num
    if id>pos_num
        break;
    end
    txt=int2str(id);
    txt=strcat(txt,'.pgm');
% ����������� ������������ � ���� double, ����� ������� ������ �������
% ����� �� � ��������� [0; 255], � � ��������� [0; 1]
    I=im2double(imread(txt));
% ��� ������������ ����������� ������������ ������ zscore
    I=zscore(I, 1);
% �������������� ����������� � ������������ ����� � ������� integralImage
    II=integralImage(I); 
% ������ ����������� ������ ��������������� ������������ ������� 25x25
    II=imresize(II, [25 25]);
    test_var.i(k).img=II;
    k=k+1;
end
cd ..\
toc

% ���������� ��������� ������������� �� ���
tic
cd test_neg
files = dir('*.jpg');
for id = 1:neg_num
    if id>neg_num
        break;
    end
    txt=int2str(id);
    txt=strcat(txt,'.jpg');
    I=im2double(imread(txt));
    I=zscore(I, 1);
    II=integralImage(I);
    II=imresize(II, [25 25]);
    test_var.i(k).img=II;
    k=k+1;
end
cd ..\
toc
cd Data
save('TestVarATT', 'test_var');
cd ..\