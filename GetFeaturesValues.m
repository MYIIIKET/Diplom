function d=GetFeaturesValues(II)
s=24;
% features - структура всех комбинаций каждого признака, разделенных по
% типу: a, b, c, d, e
% Для ускорения работы алгоритма неоюходимо заранее выделить необходимое
% количество памяти l
features(5)=struct();
tp=['a' 'b' 'c' 'd' 'e'];
l=[43200 27600 43200 27600 20736];

for i=1:5
    features(i).type=tp(i);
    features(i).i=zeros(1,l(i));
    features(i).j=zeros(1,l(i));
    features(i).w=zeros(1,l(i));
    features(i).h=zeros(1,l(i));
    features(i).val=zeros(1,l(i));
end

a=0;
k=1;
t=1;
% Вычисление признака типа a
for i=2:s+1
    for j=2:s+1
        for h=1:s
            for w=1:s
                if ((i+h-2)<=s) && ((j+2*w-2)<=s)
                    s1=II(i+h-1,j+w-1)+II(i-1,j-1)-II(i-1,j+w-1)-II(i+h-1,j-1);
                    s2=II(i+h-1,j+2*w-1)+II(i-1,j+w-2)-II(i-1,j+2*w-1)-II(i+h-1,j+2*w-2);
                    a=s1-s2;
                    
                    features(t).i(k)=i-1;
                    features(t).j(k)=j-1;
                    features(t).w(k)=w;
                    features(t).h(k)=h;
                    features(t).val(k)=a;
                    
                    k=k+1;
                else
                    break;
                end
            end
        end
    end
end

k=1;
t=t+1;
% Вычисление признака типа b
for i=2:s+1
    for j=2:s+1
        for w=1:s
            for h=1:s
                if i+h-2<=s && j+3*w-2 <=s
                    s1=II(i+h-1,j+w-1)+II(i-1,j-1)-II(i-1,j+w-1)-II(i+h-1,j-1);
                    s2=II(i+h-1,j+2*w-1)+II(i-1,j+w-2)-II(i-1,j+2*w-1)-II(i+h-1,j+w-2);
                    s3=II(i+h-1,j+3*w-1)+II(i-1,j+2*w-2)-II(i-1,j+3*w-1)-II(i+h-1,j+2*w-2);
                    a=s1-s2+s3;
                    
                    features(t).i(k)=i-1;
                    features(t).j(k)=j-1;
                    features(t).w(k)=w;
                    features(t).h(k)=h;
                    features(t).val(k)=a;
                    
                    k=k+1;
                else
                    break;
                end
            end
        end
    end
end

k=1;
t=t+1;
% Вычисление признака типа c
for i=2:s+1
    for j=2:s+1
        for w=1:s
            for h=1:s
                if i+2*h-2<=s && j+w-2 <=s
                    s1=II(i+h-1,j+w-1)+II(i-1,j-1)-II(i-1,j+w-1)-II(i+h-1,j-1);
                    s2=II(i+2*h-1,j+w-1)+II(i+h-2,j-1)-II(i+h-2,j+w-1)-II(i+2*h-1,j-1);
                    a=s1-s2;
                    
                    features(t).i(k)=i-1;
                    features(t).j(k)=j-1;
                    features(t).w(k)=w;
                    features(t).h(k)=h;
                    features(t).val(k)=a;
                    
                    k=k+1;
                else
                    break;
                end
            end
        end
    end
end

k=1;
t=t+1;
% Вычисление признака типа d
for i=2:s+1
    for j=2:s+1
        for w=1:s
            for h=1:s
                if i+3*h-2<=s && j+w-2 <=s
                    s1=II(i+h-1,j+w-1)+II(i-1,j-1)-II(i-1,j+w-1)-II(i+h-1,j-1);
                    s2=II(i+2*h-1,j+w-1)+II(i+h-2,j-1)-II(i+h-2,j+w-1)-II(i+2*h-1,j-1);
                    s3=II(i+3*h-1,j+w-1)+II(i+2*h-2,j-1)-II(i+2*h-2,j+w-1)-II(i+3*h-1,j-1);
                    a=s1-s2+s3;
                    
                    features(t).i(k)=i-1;
                    features(t).j(k)=j-1;
                    features(t).w(k)=w;
                    features(t).h(k)=h;
                    features(t).val(k)=a;
                    
                    k=k+1;
                else
                    break;
                end
            end
        end
    end
end

k=1;
t=t+1;
% Вычисление признака типа e
for i=2:s+1
    for j=2:s+1
        for w=1:s
            for h=1:s
                if i+2*h-2<=s && j+2*w-2 <=s
                    s1=II(i+h-1,j+w-1)+II(i-1,j-1)-II(i-1,j+w-1)-II(i+h-1,j-1);
                    s2=II(i+2*h-1,j+w-1)+II(i+h-2,j-1)-II(i+h-2,j+w-1)-II(i+2*h-1,j-1);
                    s3=II(i+h-1,j+2*w-1)+II(i-1,j+w-1)-II(i-1,j+2*w-1)-II(i+h-1,j-1);
                    s4=II(i+2*h-1,j+2*w-1)+II(i+h-2,j+w-2)-II(i+h-2,j+2*w-1)-II(i+2*h-1,j+w-2);
                    a=s1-s2-s3+s4;
                    
                    features(t).i(k)=i-1;
                    features(t).j(k)=j-1;
                    features(t).w(k)=w;
                    features(t).h(k)=h;
                    features(t).val(k)=a;
                    
                    k=k+1;
                else
                    break;
                end
            end
        end
    end
end
d=features;
end