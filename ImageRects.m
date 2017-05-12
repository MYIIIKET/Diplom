clear all;
close all;
clc;
scale=1.25^5;
base_size=25;
size=25;
wnd_size=round(size*scale);

hold on;
I=im2double(imread('face8.jpg'));
imshow(I);
if length(I(1,1,:))>1
    I=rgb2gray(I);
end
I=zscore(I, 1);
II=integralImage(I);

height=length(II(:,1));
width=length(II(1,:));
row=floor(height/wnd_size);
col=floor(width/wnd_size);
struct_size=row*col;
I_tmp(struct_size)=struct();
for i=1:struct_size
    I_tmp(i).wnd=zeros(wnd_size, wnd_size);
end
iter=1;
% step=round(wnd_size/4);
step=wnd_size;
for i=1:step:length(II(:,1))
%     a_row=(i-1)*wnd_size+1;
    a_row=i;
    b_row=a_row+wnd_size-1;
    if b_row>height
        continue;
    end
    for j=1:step:width
%         a_col=(j-1)*wnd_size+1;
        a_col=j;
        b_col=a_col+wnd_size-1;
        if b_col>width
            continue;
        end
        I_tmp(iter).wnd=imresize(II(a_row:b_row,a_col:b_col),[base_size base_size]);
        I_tmp(iter).i=i;
        I_tmp(iter).j=j;
        iter=iter+1;
    end
end

cd Data_3
load ('H', 'H');
load ('estimateclasssum_strong', 'estimateclasssum_strong');
load ('classestimate_strong', 'classestimate_strong');
load ('model_strong', 'model_strong');
load ('feature_params', 'feature_params');
cd ..\
% model_strong(1)=[];

strong_features_num=sum(H(1,:)==1);
iter_num=32;

model_test=struct();
model_test.alpha=[];
model_test.dimension=[];
model_test.threshold=[];
model_test.direction=[];
model_test.boundary=[];
model_test.error=[];
iterations=strong_features_num;
% iterations=128;
Prob=zeros(4,length(I_tmp));

alpha_sum=0;
threshold_sum=0;
for i=1:iterations
    for j=i*iter_num-(iter_num-1):i*iter_num
        alpha_sum=alpha_sum+model_strong(j).alpha;
        threshold_sum=threshold_sum+model_strong(j).threshold;
    end
end
alpha_sum=alpha_sum/(iter_num*(iterations));
threshold_sum=threshold_sum/(iter_num*(iterations));

iterations=32;
tic
for r=1:length(I_tmp)
    II=I_tmp(r).wnd;
    
    a_row=I_tmp(r).i;
    b_row=a_row+wnd_size-1;
    a_col=I_tmp(r).j;
    b_col=a_col+wnd_size-1;
    if b_row>=height
        b_row=b_row-1;
    end
    if b_col>=width
        b_col=b_col-1;
    end
    figure; colormap(gray(256)); imshow(I(a_row:b_row,a_col:b_col), []);
    
    f_sum=0;
    for i=1:iterations
        clc;
        ft=GetSingleFeature(II, feature_params(i).i, feature_params(i).j, feature_params(i).w, feature_params(i).h, feature_params(i).type);
        t=i*iter_num-iter_num;
        for j=i*iter_num-(iter_num-1):i*iter_num
            model_test(j-t).alpha=model_strong(j).alpha;
            model_test(j-t).dimension=model_strong(j).dimension;
            model_test(j-t).threshold=model_strong(j).threshold;
            model_test(j-t).direction=model_strong(j).direction;
            model_test(j-t).boundary=model_strong(j).boundary;
            model_test(j-t).error=model_strong(j).error;
        end
        testclass=adaboost('apply', ft, model_test);
        f_sum=f_sum+testclass;
        alpha_sum
        threshold_sum
        f_sum/i
    end
    f_sum=f_sum/(iterations);
    Prob(1, r)=abs(1-f_sum);
    Prob(2, r)=sign(f_sum);
    Prob(3, r)=alpha_sum;
    Prob(4, r)=f_sum;
    f_sum;
    alpha_sum;
    threshold_sum;
    if (Prob(2, r)==1 && (Prob(1, r)>0.9 && Prob(1, r)<1))
        rectangle('Position',[a_col, a_row, b_col-a_col, b_row-a_row],'EdgeColor','r')
%         plot([a_row a_col],[a_row b_col], 'g');
%         plot([a_row b_col],[b_row b_col], 'g');
%         plot([b_row b_col],[b_row a_col], 'g');
%         plot([b_row a_col],[a_row a_col], 'g');
    end
end
toc
% find(abs(1-Prob(1,:))>0.5)
img_num=find(Prob(2,:)==1 & (Prob(1,:)>0.95 & Prob(1,:)<1))
for i=1:length(img_num)
    a_row=I_tmp(img_num(i)).i;
    b_row=a_row+wnd_size-1;
    a_col=I_tmp(img_num(i)).j;
    b_col=a_col+wnd_size-1;
    if b_row>=height
        b_row=b_row-1;
    end
    if b_col>=width
        b_col=b_col-1;
    end
    figure; colormap(gray(256)); imshow(I(a_row:b_row,a_col:b_col), []);
end