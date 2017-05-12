function f_sum=Recognize(I, iterations, feature_params)
f_sum=0;
% for i=1:iterations
%     ft=GetSingleFeature(I, feature_params(i).i, feature_params(i).j, feature_params(i).w, feature_params(i).h, feature_params(i).type);
%     H=Classify(ft, feature_params(i).alpha, feature_params(i).threshold, feature_params(i).toggle);
%     f_sum=f_sum+H;
% end
s=10;
s1=1;
s2=10;
while ~(s2>=iterations)
    for i=s1:s2
        ft=GetSingleFeature(I, feature_params(i).i, feature_params(i).j, feature_params(i).w, feature_params(i).h, feature_params(i).type);
        H=Classify(ft, feature_params(i).alpha, feature_params(i).threshold, feature_params(i).toggle);
        f_sum=f_sum+H;
    end
    if f_sum<0
%         abs(f_sum)/s2
        if (abs(f_sum)/s2)<0.1
            s1=s2+1;
            s2=s2+s;
            if s2>iterations
                s2=iterations;
            end
        else
            f_sum=f_sum;
            break;
        end
    else
        s1=s2+1;
        s2=s2+s;
        if s2>iterations
            s2=iterations;
        end
    end
end
end