function H=Classify(data, alpha, threshold, toggle)
weak_class_sum=0;
T=length(threshold);
for i=1:T
    weak_class=GetStump(data, threshold(i,1), toggle(i,1));
    weak_class_sum=weak_class_sum+alpha(i,1).*weak_class;
end
H=sign(weak_class_sum);
end