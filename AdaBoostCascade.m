function [H, alpha, threshold, toggle, D]=AdaBoostCascade(data, D, alpha, threshold, toggle, T)

[weak_class, threshold(T,1), toggle(T,1)]=BestStump(D, data);

error=sum(D(weak_class~=data(:,2),1));

alpha(T,1)=(1/2)*log((1-error)/error);

D=(D./2).*((1/error).*(weak_class~=data(:,2))+(1/(1-error)).*(weak_class==data(:,2)));
D=D./sum(D);
    
H=Classify(data, alpha(1:T,1), threshold(1:T,1), toggle(1:T,1));

end