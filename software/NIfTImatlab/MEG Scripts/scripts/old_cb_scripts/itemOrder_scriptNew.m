clear all;

for iblock = 1:24
    load(['BlockOrder',num2str(iblock)])
    BlockOrder_allsubs(:,iblock) = BlockOrder(:);
end

BlockOrder_allsubs_repmat = [];


%make a matrix that repeats each block color 4 times
for irep = 1:length(BlockOrder_allsubs)
    BlockOrder_allsubs_repmat = [BlockOrder_allsubs_repmat; repmat(BlockOrder_allsubs(irep,:),6,1)];
end

ItemOrder = [1:576]';
ItemPosition = repmat([1:6]',576/6,1);

Sub1 = [[1:576]' ItemOrder ItemPosition BlockOrder_allsubs_repmat(:,1)];

for ihist = 1:576
    eval(['itemHistory.history',num2str(ihist),'=',num2str(BlockOrder_allsubs_repmat(ihist,1)),';']);
end


itemOrder = [1:576]';

for isub = 2:24
    itemOrder(:,isub) = randperm(576)';
end