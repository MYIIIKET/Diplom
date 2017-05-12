clear all;
clc;

cd test_neg
files = dir('*.jpg');
for id = 1:length(files)
    [~, f] = fileparts(files(id).name);
    movefile(files(id).name, sprintf('%i.jpg', id));
end
cd ..\

% cd pos
% files = dir('*.pgm');
% t=length(files);
% for id = length(files):-1:1
%     [~, f] = fileparts(files(id).name);
%     movefile(files(id).name, sprintf('%i.pgm', id));
% end
% cd ..\