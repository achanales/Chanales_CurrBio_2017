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

positionMtx = repmat([1:6; [2:6 1]; [3:6 1:2]; [4:6 1:3]; [5:6 1:4]; [6 1:5]],96,1);

itemOrder = [];

for iItem = 1:6:576

itemOrder.item1 = [[16:24 1:15]' repmat([1 2 3 4 5 6]',4,1) ones(24,1)];
itemOrder.item2 = [[16:24 1:15]' repmat([2 3 4 5 6 1]',4,1) ones(24,1)*2];
itemOrder.item3 = [[16:24 1:15]' repmat([3 4 5 6 1 2]',4,1) ones(24,1)*3];
itemOrder.item4 = [[16:24 1:15]' repmat([4 5 6 1 2 3]',4,1) ones(24,1)*4];
itemOrder.item5 = [[16:24 1:15]' repmat([5 6 1 2 3 4]',4,1) ones(24,1)*5];
itemOrder.item6 = [[16:24 1:15]' repmat([6 1 2 3 4 5]',4,1) ones(24,1)*6];

itemOrder.item7 = [[3:24 1:2]' repmat([1 2 3 4 5 6]',4,1) ones(24,1)*7];
itemOrder.item8 = [[3:24 1:2]' repmat([2 3 4 5 6 1]',4,1) ones(24,1)*8];
itemOrder.item9 = [[3:24 1:2]' repmat([3 4 5 6 1 2]',4,1) ones(24,1)*9];
itemOrder.item10 = [[3:24 1:2]' repmat([4 5 6 1 2 3]',4,1) ones(24,1)*10];
itemOrder.item11 = [[3:24 1:2]' repmat([5 6 1 2 3 4]',4,1) ones(24,1)*11];
itemOrder.item12 = [[3:24 1:2]' repmat([6 1 2 3 4 5]',4,1) ones(24,1)*12];

itemOrder.item13 = [[3:24 1:2]' repmat([1 2 3 4 5 6]',4,1) ones(24,1)*13];
itemOrder.item14 = [[3:24 1:2]' repmat([2 3 4 5 6 1]',4,1) ones(24,1)*14];
itemOrder.item15 = [[3:24 1:2]' repmat([3 4 5 6 1 2]',4,1) ones(24,1)*15];
itemOrder.item16 = [[3:24 1:2]' repmat([4 5 6 1 2 3]',4,1) ones(24,1)*16];
itemOrder.item17 = [[3:24 1:2]' repmat([5 6 1 2 3 4]',4,1) ones(24,1)*17];
itemOrder.item18 = [[3:24 1:2]' repmat([6 1 2 3 4 5]',4,1) ones(24,1)*18];
