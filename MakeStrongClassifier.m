clearvars -except dpr_train fpr_train px_train
clc;

% cd Data
% load ('dpr_train');
% load ('fpr_train');
% load ('CombineTrainFeatures');
% cd ..\

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

strong_class=struct();
ind1=find(dpr_train(:,1)>0.9);
ind2=find(fpr_train(:,1)<0.1);
ind3=intersect(ind1,ind2);

it=1;
f_num=0;

T=1500;
for i=1:length(ind3)
    train_data=zeros(train_size, 2);
    train_data(:,1)=px_train(:,ind3(i,1));
    train_data(1:pos_train_size,2)=1;
    train_data(pos_train_size+1:end,2)=-1;
    
    [H, alpha, threshold, toggle]=AdaBoost(train_data, T);

    s1=find(sizes(:)<ind3(i,1));
    f_num=s1(end);
    s1=sizes(f_num);
    s1=ind3(i,1)-s1;
    strong_class(it).i=ref(f_num).i(s1);
    strong_class(it).j=ref(f_num).j(s1);
    strong_class(it).w=ref(f_num).w(s1);
    strong_class(it).h=ref(f_num).h(s1);
    strong_class(it).alpha=alpha;
    strong_class(it).threshold=threshold;
    strong_class(it).toggle=toggle;
    switch(f_num)
        case 1
            strong_class(it).type='a';
        case 2
            strong_class(it).type='b';
        case 3
            strong_class(it).type='c';
        case 4
            strong_class(it).type='d';
        case 5
            strong_class(it).type='e';
    end
    it=it+1;
end