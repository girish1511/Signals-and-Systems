clc;
fl=['100m.mat';'101m.mat';'102m.mat';'103m.mat';'104m.mat';'105m.mat';'106m.mat';'107m.mat';'108m.mat';'109m.mat',];
for i=1:10
    [b(i),n(i)]=QRS(fl(i,:));
end
b=b.';
n=n.';
%result=[b,n];
fprintf('  Data    No of Beats   Beats per minute\n')
for i=1:10
    fprintf('%s    %d          %f\n', fl(i,:),n(i),b(i));
end