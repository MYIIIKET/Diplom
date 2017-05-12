clearvars -except px_train px_test
clc;

% cd Data
% load('CombineTrainFeatures', 'px_train');
% load('CombineTestFeatures', 'px_test');
% cd ..\

pos_train_size=320;
neg_train_size=640;
train_size=pos_train_size+neg_train_size;

train_data=zeros(train_size, 2);
train_data(1:pos_train_size,2)=1;
train_data(pos_train_size+1:end,2)=-1;

% ---------------------------------------------
pos_test_size=80;
neg_test_size=160;
test_size=pos_test_size+neg_test_size;

test_data=zeros(test_size, 1);
test_data(1:pos_test_size,2)=1;
test_data(pos_test_size+1:end,2)=-1;

T=1500;
f_sz=162336;
dpr_train=zeros(f_sz, 1);
fpr_train=zeros(f_sz, 1);
tic
for i=1:f_sz
    train_data(:,1)=px_train(:,i);
    [H_train, alpha, threshold, toggle]=AdaBoost(train_data, T);
    [dpr_train(i,1), ~, fpr_train(i,1), ~]=GetRates(train_data, H_train);
end
toc
cd Data
save('dpr_train', 'dpr_train');
save('fpr_train', 'fpr_train');
cd ..\

% T=1000;
% 
% [H_train, alpha, threshold, toggle]=AdaBoost(train_data, T);
% [dpr_train, ~, fpr_train, ~]=GetRates(train_data, H_train);
% 
% H_test=Classify(test_data, alpha, threshold, toggle);
% [dpr_test, ~, fpr_test, ~]=GetRates(test_data, H_test);