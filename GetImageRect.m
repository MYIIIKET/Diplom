function y=GetImageRect(I, x1, y1, x2, y2, base_size)
    y=imresize(I(x1:y1,x2:y2),[base_size base_size]);
end