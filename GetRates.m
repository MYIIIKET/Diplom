% Функция GetRates получает значения Detection positive rate, Detection
% negative rate, False positive rate, False negative rate
function [dpr, dnr, fpr, fnr]=GetRates(data, H)
data=sortrows(data);
pos_size=length(data(data(:,2)==1,2));
neg_size=length(data(data(:,2)==-1,2));


H1=H(data(:,2)==1,1);
H1(H1(:,1)==-1,1)=0;
dpr=sum(H1)/pos_size;

H2=H(data(:,2)==-1,1);
H2(H2(:,1)==1)=0;
H2=abs(H2);
dnr=sum(H2)/neg_size;

fpr=1-dnr;

fnr=1-dpr;
end