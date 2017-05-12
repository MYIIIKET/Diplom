clear all;
clc;

tic
cd test_neg
files = dir('*.pgm');
for id = 1:length(files)
    if strfind(files(id).name, '24x24')
        movefile(files(id).name, sprintf('%i.pgm', id));
    else
        delete(files(id).name);
    end
end
cd ..\
toc