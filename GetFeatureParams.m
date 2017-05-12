function feature_params=GetFeatureParams(H)

I=zeros(24, 24);
I=integralImage(I);
ref=GetFeaturesValues(I);

fsz=sum(H(1,:));
feature_params(fsz)=struct();
sizes=[43200 27600 43200 27600 20736];
k=0;
for i=1:5
    sizes(i)=k+sizes(i);
    k=sizes(i);
end
k=1;
t=0;
for i=1:sizes(1)
    if i<=length(H(1,:))
        if H(1, i)==1
            feature_params(i-t).i=ref(1).i(i);
            feature_params(i-t).j=ref(1).j(i);
            feature_params(i-t).w=ref(1).w(i);
            feature_params(i-t).h=ref(1).h(i);
            feature_params(i-t).type='a';
        else
            t=t+1;
        end
    else
        break;
    end
end
for i=sizes(1)+1:sizes(2)
    if i<=length(H(1,:))
        if H(1, i)==1
            feature_params(i-t).i=ref(2).i(i-sizes(1));
            feature_params(i-t).j=ref(2).j(i-sizes(1));
            feature_params(i-t).w=ref(2).w(i-sizes(1));
            feature_params(i-t).h=ref(2).h(i-sizes(1));
            feature_params(i-t).type='b';
        else
            t=t+1;
        end
    else
        break;
    end
end
for i=sizes(2)+1:sizes(3)
    if i<=length(H(1,:))
        if H(1, i)==1
            feature_params(i-t).i=ref(3).i(i-sizes(2));
            feature_params(i-t).j=ref(3).j(i-sizes(2));
            feature_params(i-t).w=ref(3).w(i-sizes(2));
            feature_params(i-t).h=ref(3).h(i-sizes(2));
            feature_params(i-t).type='c';
        else
            t=t+1;
        end
    else
        break;
    end
end
for i=sizes(3)+1:sizes(4)
    if i<=length(H(1,:))
        if H(1, i)==1
            feature_params(i-t).i=ref(4).i(i-sizes(3));
            feature_params(i-t).j=ref(4).j(i-sizes(3));
            feature_params(i-t).w=ref(4).w(i-sizes(3));
            feature_params(i-t).h=ref(4).h(i-sizes(3));
            feature_params(i-t).type='d';
        else
            t=t+1;
        end
    else
        break;
    end
end
for i=sizes(4)+1:sizes(5)
    if i<=length(H(1,:))
        if H(1, i)==1
            feature_params(i-t).i=ref(5).i(i-sizes(4));
            feature_params(i-t).j=ref(5).j(i-sizes(4));
            feature_params(i-t).w=ref(5).w(i-sizes(4));
            feature_params(i-t).h=ref(5).h(i-sizes(4));
            feature_params(i-t).type='e';
        else
            t=t+1;
        end
    else
        break;
    end
end
end