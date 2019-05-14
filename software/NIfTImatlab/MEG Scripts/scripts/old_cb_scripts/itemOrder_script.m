% clear all;
% 
% for iblock = 1:24
%     load(['BlockOrder',num2str(iblock)])
%     BlockOrder_allsubs(:,iblock) = BlockOrder(:);
% end
% 
% BlockOrder_allsubs_repmat = [];
% 
% 
% %make a matrix that repeats each block color 4 times
% for irep = 1:length(BlockOrder_allsubs)
%     BlockOrder_allsubs_repmat = [BlockOrder_allsubs_repmat; repmat(BlockOrder_allsubs(irep,:),4,1)];
% end
% 
% ItemOrder = [1:576]';
% ItemPosition = repmat([1:4]',576/6,1);
% 
% %collect the items that have already been used for each block
% for iblock = 1:24
%     
%     UsedBlocks{:,iblock} = ItemOrder(BlockOrder_allsubs_repmat(:,1)==iblock);
%     
% end
% 
% positionVec = repmat([1:4]',96,1);
% 
% itemIdx = [1:576]';
% conditions = repmat([101:124 201:224 301:324 401:424];
% 
% 
% 
goOn = 0;
for isub = 2:24

    while goOn~=1

    prevItems = 0;
    tmpItemVec = [];
    for iItem = 1:576

        currentBlock = BlockOrder_allsubs_repmat(iItem,isub);
        UsedStim = UsedBlocks{:,currentBlock};

        tmp = [1:576]';

        for iUsed = 1:length(UsedStim)

            tmp(tmp==UsedStim(iUsed))=[];

        end

        if sum(prevItems>0)>0
            for iUsed = 2:length(prevItems)
                tmp(tmp==prevItems(iUsed))=[];
            end
        end


        tmpShuffle=tmp(randperm(length(tmp)));

        count = 0;
        while sum(tmpShuffle(1)==prevItems)==1
            tmpShuffle=tmp(randperm(length(tmp)));
            count = count + 1;
            if count>100
                keyboard
            end
        end

        if isempty(tmpShuffle)

            goOn=0;
            break
        else
            goOn=1;
        end

        tmpItemVec(iItem) = tmpShuffle(1);

        UsedBlocks{:,currentBlock} = [UsedBlocks{:,currentBlock}; tmpShuffle(1)];
        prevItems = [prevItems; tmpShuffle(1)];


    end

    end
    ItemOrder = [ItemOrder tmpItemVec'];
    goOn=0;

end
% done = 0;
% test = [];
% 
% while done==0
% positionVec = repmat([1:6]',96,1);
% 
% 
% V1_posOne = ItemOrder(positionVec==1);
% V1_posTwo = ItemOrder(positionVec==2);
% V1_posThree = ItemOrder(positionVec==3);
% V1_posFour = ItemOrder(positionVec==4);
% V1_posFive = ItemOrder(positionVec==5);
% V1_posSix = ItemOrder(positionVec==6);
% 
% V1_posOneRand = V1_posOne(randperm(length(V1_posOne)));
% V1_posTwoRand = V1_posTwo(randperm(length(V1_posTwo)));
% V1_posThreeRand = V1_posThree(randperm(length(V1_posThree)));
% V1_posFourRand = V1_posFour(randperm(length(V1_posFour)));
% V1_posFiveRand = V1_posFour(randperm(length(V1_posFive)));
% V1_posSixRand = V1_posFour(randperm(length(V1_posSix)));
% 
% V2_posOne = V1_posSixRand;
% V2_posTwo = V1_posOneRand;
% V2_posThree = V1_posTwoRand; 
% V2_posFour = V1_posThreeRand;
% V2_posFive = V1_posFourRand;
% V2_posSix = V1_posFiveRand;
% 
% V2_posOneRand = V2_posOne(randperm(length(V1_posOne)));
% V2_posTwoRand = V2_posTwo(randperm(length(V1_posTwo)));
% V2_posThreeRand = V2_posThree(randperm(length(V1_posThree)));
% V2_posFourRand = V2_posFour(randperm(length(V1_posFour)));
% 
% V3_posOne = V2_posThreeRand;
% V3_posTwo = V2_posFourRand;
% V3_posThree = V2_posOneRand; 
% V3_posFour = V2_posTwoRand;
% 
% V3_posOneRand = V3_posOne(randperm(length(V1_posOne)));
% V3_posTwoRand = V3_posTwo(randperm(length(V1_posTwo)));
% V3_posThreeRand = V3_posThree(randperm(length(V1_posThree)));
% V3_posFourRand = V3_posFour(randperm(length(V1_posFour)));
% 
% V4_posOne = V3_posThreeRand;
% V4_posTwo = V3_posFourRand;
% V4_posThree = V3_posOneRand; 
% V4_posFour = V3_posTwoRand;
% 
% V2_Order = [];
% for iPos = 1:96
%     
%     V2_Order = [V2_Order; V2_posOne(iPos); V2_posTwo(iPos); V2_posThree(iPos); V2_posFour(iPos)];
%     
% end
% 
% V3_Order = [];
% for iPos = 1:96
%     
%     V3_Order = [V3_Order; V3_posOne(iPos); V3_posTwo(iPos); V3_posThree(iPos); V3_posFour(iPos)];
%     
% end
% 
% 
% V4_Order = [];
% for iPos = 1:96
%     
%     V4_Order = [V4_Order; V4_posOne(iPos); V4_posTwo(iPos); V4_posThree(iPos); V4_posFour(iPos)];
%     
% end
% 
% 
% 
% 
% ItemOrder = [[1:576]' V2_Order V3_Order V4_Order];
% 
% ItemOrder = repmat(ItemOrder,1,6);
% 
% 
% for iColor = 1:24
% for iItem = 1:576
%     
%     ColorIdx = BlockOrder_allsubs_repmat==iColor;
%     ItemIdx = ItemOrder==iItem;
%     
%     tmp = sum(sum(ColorIdx&ItemIdx));
%     
%     ColorCount(iColor, iItem) = tmp;
% end
% end
% 
% if sum(sum(ColorCount>4))<10
%     done = 1;
%     
% else
%     done = 0;
%     test = [test; sum(sum(ColorCount>4))];
% end
% 
% if length(test)==100
%     keyboard
% end
% 
% end
%      
