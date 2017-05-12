function val=GetSingleFeature(II, i, j, w, h, type)
i=i+1;
j=j+1;
switch(type)
    case 'a'
        s1=II(i+h-1,j+w-1)+II(i-1,j-1)-II(i-1,j+w-1)-II(i+h-1,j-1);
        s2=II(i+h-1,j+2*w-1)+II(i-1,j+w-2)-II(i-1,j+2*w-1)-II(i+h-1,j+2*w-2);
        val=s1-s2;
    case 'b'
        s1=II(i+h-1,j+w-1)+II(i-1,j-1)-II(i-1,j+w-1)-II(i+h-1,j-1);
        s2=II(i+h-1,j+2*w-1)+II(i-1,j+w-2)-II(i-1,j+2*w-1)-II(i+h-1,j+w-2);
        s3=II(i+h-1,j+3*w-1)+II(i-1,j+2*w-2)-II(i-1,j+3*w-1)-II(i+h-1,j+2*w-2);
        val=s1-s2+s3;
    case 'c'
        s1=II(i+h-1,j+w-1)+II(i-1,j-1)-II(i-1,j+w-1)-II(i+h-1,j-1);
        s2=II(i+2*h-1,j+w-1)+II(i+h-2,j-1)-II(i+h-2,j+w-1)-II(i+2*h-1,j-1);
        val=s1-s2;
    case 'd'
        s1=II(i+h-1,j+w-1)+II(i-1,j-1)-II(i-1,j+w-1)-II(i+h-1,j-1);
        s2=II(i+2*h-1,j+w-1)+II(i+h-2,j-1)-II(i+h-2,j+w-1)-II(i+2*h-1,j-1);
        s3=II(i+3*h-1,j+w-1)+II(i+2*h-2,j-1)-II(i+2*h-2,j+w-1)-II(i+3*h-1,j-1);
        val=s1-s2+s3;
    case 'e'
        s1=II(i+h-1,j+w-1)+II(i-1,j-1)-II(i-1,j+w-1)-II(i+h-1,j-1);
        s2=II(i+2*h-1,j+w-1)+II(i+h-2,j-1)-II(i+h-2,j+w-1)-II(i+2*h-1,j-1);
        s3=II(i+h-1,j+2*w-1)+II(i-1,j+w-1)-II(i-1,j+2*w-1)-II(i+h-1,j-1);
        s4=II(i+2*h-1,j+2*w-1)+II(i+h-2,j+w-2)-II(i+h-2,j+2*w-1)-II(i+2*h-1,j+w-2);
        val=s1-s2-s3+s4;
end
end