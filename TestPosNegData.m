clearvars -except strong_class_QuadraticDiscriminant
close all;
clc;


% cd Data
% load ('strong_class_QuadraticDiscriminant');
% cd ..\


iterations=193;
num=48;
it=0;
tic
for t=1:160
    cd test_neg
    txt='';
    txt=int2str(t);
    txt=strcat(txt,'.jpg');
    
    I=im2double(imread(txt));
    
    I=zscore(I, 1);
    II=integralImage(I);
    II=imresize(II, [25 25]);
    cd ..\
    
%     x=Recognize(II, iterations, strong_class);
    f_sum=0;
    for i=1:iterations
        ft=GetSingleFeature(II, strong_class_QuadraticDiscriminant(i).i, strong_class_QuadraticDiscriminant(i).j, strong_class_QuadraticDiscriminant(i).w, strong_class_QuadraticDiscriminant(i).h, strong_class_QuadraticDiscriminant(i).type);
%         H=Classify(ft, strong_class(i).alpha, strong_class(i).threshold, strong_class(i).toggle);
        H = strong_class_QuadraticDiscriminant(i).trainedClass.predictFcn(ft);
        f_sum=f_sum+H;
    end
    if f_sum<0
        it=it+1;
    end
end
toc
