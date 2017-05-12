clearvars -except px_train dpr_train fpr_train
close all;
clc;

cd Data
load('CombineTrainFeatures', 'px_train');
load('dpr_train');
load('fpr_train');
cd ..\

I=zeros(24, 24);
I=integralImage(I);
ref=GetFeaturesValues(I);
sizes=[0 43200 27600 43200 27600 20736];
k=0;
for i=1:length(sizes)
    sizes(i)=k+sizes(i);
    k=sizes(i);
end

pos_train_size=320;
neg_train_size=640;
train_size=pos_train_size+neg_train_size;

train_data=zeros(train_size, 2);
train_data(1:pos_train_size,2)=1;
train_data(pos_train_size+1:end,2)=-1;

strong_class_QuadraticDiscriminant=struct();
ind1=find(dpr_train(:,1)>0.9);
ind2=find(fpr_train(:,1)<0.1);
ind3=intersect(ind1,ind2);

dpr_arr_QuadraticDiscriminant=zeros(length(ind3), 1);
fpr_arr_QuadraticDiscriminant=zeros(length(ind3), 1);

it=1;
f_num=0;

for i=1:length(ind3)
    train_data(:,1)=px_train(:,ind3(i,1));
    train_data(1:pos_train_size,2)=1;
    train_data(pos_train_size+1:end,2)=-1;
    train_data=sortrows(train_data);
    
    [trainedClassifier, validationAccuracy] = trainClassifier(train_data);
    H = trainedClassifier.predictFcn(train_data(:,1));
    [dpr_arr_QuadraticDiscriminant(i,1), ~, fpr_arr_QuadraticDiscriminant(i,1), ~]=GetRates(train_data, H);

    s1=find(sizes(:)<ind3(i,1));
    f_num=s1(end);
    s1=sizes(f_num);
    s1=ind3(i,1)-s1;
    strong_class_QuadraticDiscriminant(it).i=ref(f_num).i(s1);
    strong_class_QuadraticDiscriminant(it).j=ref(f_num).j(s1);
    strong_class_QuadraticDiscriminant(it).w=ref(f_num).w(s1);
    strong_class_QuadraticDiscriminant(it).h=ref(f_num).h(s1);
    strong_class_QuadraticDiscriminant(it).trainedClass=trainedClassifier;
    switch(f_num)
        case 1
            strong_class_QuadraticDiscriminant(it).type='a';
        case 2
            strong_class_QuadraticDiscriminant(it).type='b';
        case 3
            strong_class_QuadraticDiscriminant(it).type='c';
        case 4
            strong_class_QuadraticDiscriminant(it).type='d';
        case 5
            strong_class_QuadraticDiscriminant(it).type='e';
    end
    it=it+1;
end
cd Data
save('strong_class_QuadraticDiscriminant', 'strong_class_QuadraticDiscriminant');
save('dpr_arr_QuadraticDiscriminant', 'dpr_arr_QuadraticDiscriminant');
save('fpr_arr_QuadraticDiscriminant', 'fpr_arr_QuadraticDiscriminant');
cd ..\



% [H, alpha, threshold, toggle]=AdaBoost(train_data, T);








% 
% clearvars -except px_train px_test
% clc;
% 
% % cd Data
% % load('CombineTrainFeatures', 'px_train');
% % load('CombineTestFeatures', 'px_test');
% % cd ..\
% 
% pos_train_size=320;
% neg_train_size=640;
% train_size=pos_train_size+neg_train_size;
% 
% train_data=zeros(train_size, 2);
% train_data(1:pos_train_size,2)=1;
% train_data(pos_train_size+1:end,2)=-1;
% 
% 
% 
% T=1000;
% f_sz=162336;
% f_num=90000;
% dpr_train=[];
% fpr_train=[];
% 
% alpha=[];
% threshold=[];
% toggle=[];
% train_data(:,1)=px_train(:,f_num);
% train_data=sortrows(train_data);
% 
% D=zeros(train_size, 1);
% D(train_data(:,2)==1,1)=1/pos_train_size;
% D(train_data(:,2)==-1,1)=1/neg_train_size;
% it=1;
% tic
% for i=20:10:T
% %     [H_train, alpha, threshold, toggle, D]=AdaBoostCascade(train_data, D, alpha, threshold, toggle, i);
%     [H_train, alpha, threshold, toggle]=AdaBoost(train_data, i);
%     [dpr_train(it,1), ~, fpr_train(it,1), ~]=GetRates(train_data, H_train);
%     it=it+1;
% end
% toc
% [X,Y,~,AUC]=perfcurve(train_data(:,2),H_train,1)
% % hold on
% % plot(dpr_train);
% % plot(fpr_train);
