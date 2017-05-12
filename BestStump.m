function [weak_class, threshold, toggle]=BestStump(D, data)
size=length(data(:,1));
threshold=min(data(:,1))-1;
margin=0;
error=2;
W_plus_pos=sum(D(data(:,1)>threshold & data(:,2)==1,1));
W_plus_neg=sum(D(data(:,1)>threshold & data(:,2)==-1,1));
W_minus_pos=sum(D(data(:,1)<threshold & data(:,2)==1,1));
W_minus_neg=sum(D(data(:,1)<threshold & data(:,2)==-1,1));
j=0; threshold_tmp=threshold; margin_tmp=margin;
while 1
    error_plus=W_minus_pos+W_plus_neg;
    error_minus=W_plus_pos+W_minus_neg;
    if error_plus<error_minus
        error_tmp=error_plus;
        toggle_tmp=1;
    else
        error_tmp=error_minus;
        toggle_tmp=-1;
    end
    if error_tmp<error || (error_tmp==error && margin_tmp>margin)
        error=error_tmp;
        threshold=threshold_tmp;
        toggle=toggle_tmp;
    end
    if j==size
        break;
    end
    j=j+1;
    while 1
        if data(j,2)==-1
            W_minus_neg=W_minus_neg+D(j,1);
            W_plus_neg=W_plus_neg-D(j,1);
        else
            W_minus_pos=W_minus_pos+D(j,1);
            W_plus_pos=W_plus_pos-D(j,1);
        end
        if j==size || data(j,1)~=data(j+1,1)
            break;
        end
    end
    if j==size
        threshold_tmp=max(data(:,1))+1;
        margin_tmp=0;
    else
        threshold_tmp=(data(j,1)+data(j+1,1))/2;
        margin_tmp=data(j+1,1)-data(j,1);
    end
end
weak_class=GetStump(data, threshold, toggle);
end