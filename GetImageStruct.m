clear all;
clc;

% pos_num и neg_num - заранее известное количество позитивных и негативных 
% образцов
pos_num=80; 
neg_num=160;
% num - общее количество тренировочной выборки
num=pos_num+neg_num;
k=1;
% test_var - структура, содержаща€ изображени€
test_var=[];
test_var.i(num)=struct();

% ƒл€ ускорени€ работы необходимо заранее выделить необходимую пам€ть
% »сходный размер изображени€ - матрица 25x25
for i=1:num
    test_var.i(i).img=zeros(25, 25);
end

txt='';

% «аполнение структуры изображени€ми лиц
tic
cd test_pos
files = dir('*.pgm');
for id = 1:pos_num
    if id>pos_num
        break;
    end
    txt=int2str(id);
    txt=strcat(txt,'.pgm');
% »зображение представлено в виде double, таким образом каждый пиксель
% лежит не в диапазоне [0; 255], а в диапазоне [0; 1]
    I=im2double(imread(txt));
% ƒл€ нормализации изображени€ используетс€ функци zscore
    I=zscore(I, 1);
% ѕреобразование изображени€ в интегральную форму с помощью integralImage
    II=integralImage(I); 
% –азмер изображени€ должен соответствовать стандартному размеру 25x25
    II=imresize(II, [25 25]);
    test_var.i(k).img=II;
    k=k+1;
end
cd ..\
toc

% «аполнение структуры изображени€ми не лиц
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