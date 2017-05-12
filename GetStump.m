function stump=GetStump(data, threshold, toggle)
size=length(data(:,1));
stump=zeros(size, 1);
if toggle==1
    stump(data(:,1)>=threshold)=1;
else
    stump(data(:,1)<threshold)=1;
end
stump(stump(:,1)==0,1)=-1;
end