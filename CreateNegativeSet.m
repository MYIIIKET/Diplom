clear all;
clc;

% cd pos
% I=im2double(imread('1.pgm'));
% I=zscore(I, 1);
% II=integralImage(I);
% imshow(II, []);
% cd ..\

cd Test_Data
I=im2double(imread('street6.jpg'));
cd ..\
if length(I(1,1,:))>1
    I=rgb2gray(I);
end
width=length(I(1,:));
height=length(I(:,1));
base_size=24;
size=24;
scale=4;
wnd_size=round(size*scale);
step=round(wnd_size/1.5);
img_num=50;
i=1;
j=1;

while i<=height
    i=i+step;
    a_row=i;
    b_row=a_row+wnd_size-1;
    if b_row>height
        continue;
    end
    j=1;
    while j<=width
        j=j+step;
        a_col=j;
        b_col=a_col+wnd_size-1;
        if b_col>width
            continue;
        end
        txt='';
        txt=int2str(img_num);
        txt=strcat(txt,'.jpg');
        y=GetImageRect(I, a_row, b_row, a_col, b_col, wnd_size);
        cd test_neg
        imwrite(y,txt);
        cd ..\
        img_num=img_num+1;
    end
end
