function [H, alpha, threshold, toggle]=AdaBoost(data, T)

data=sortrows(data);
size=length(data(:,1));
pos_size=length(data(data(:,2)==1,2));
neg_size=length(data(data(:,2)==-1,2));
D=zeros(size, 1);
D(data(:,2)==1,1)=1/pos_size;
D(data(:,2)==-1,1)=1/neg_size;

alpha=zeros(T,1);
threshold=zeros(T,1);
toggle=zeros(T,1);

    
for i=1:T
    [weak_class, threshold(i,1), toggle(i,1)]=BestStump(D, data);

    error=sum(D(weak_class~=data(:,2),1));
    
    alpha(i,1)=(1/2)*log((1-error)/error);
    
    if error==0
        break;
    end
    
    D=(D./2).*((1/error).*(weak_class~=data(:,2))+(1/(1-error)).*(weak_class==data(:,2)));
    D=D./sum(D);
    
    
    
end
H=Classify(data, alpha, threshold, toggle);

end