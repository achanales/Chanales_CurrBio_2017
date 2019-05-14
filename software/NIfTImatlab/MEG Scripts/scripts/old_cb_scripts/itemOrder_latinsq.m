clear all

latsqMtx = latsq(576);

cbMtx(:,1) = latsqMtx(:,1);
cbMtx(:,2) = latsqMtx(:,2);


i = 3;
for n = 3:576

if mod(n,2) == 0
cbMtx(:,n)=latsqMtx(:,i-1);
else
cbMtx(:,n)=latsqMtx(:,576-i+3);
i = i + 1;
end


end

cbMtx = cbMtx';

itemPosition = repmat([1:6]',96,1);

subItemLists = [cbMtx(:,1:12) cbMtx(:,565:end)];

for ipos = 1:6
    
    for iItem = 1:576
    
    itemByPos(iItem,ipos) = sum(sum(cbMtx(:,1:24)==iItem,2)&itemPosition==ipos);
    
    end
    
end

imagesc(itemByPos)

ideal = repmat(ones(1,6)*4,576,1);


i = 1;
minimize_this = 1001;

% while minimize_this(i)>1000
% 
% tmp = randperm(576);
% randsample = tmp(1:24);
% 
% tmpMtx = cbMtx(:,randsample);
% 
% for ipos = 1:6
%     
%     for iItem = 1:576
%     
%     itemByPos(iItem,ipos) = sum(sum(tmpMtx(:,1:24)==iItem,2)&itemPosition==ipos);
%     
%     end
%     
%   
% end
% 
% i = i + 1;
% minimize_this(i) = sum(sum(abs(itemByPos-ideal)));  
% 
% end


%%%
itemPosition = repmat([1:6]',96,576);

for iOrder = 1:576
    
    for iItem = 1:576
    
    whatever(iItem,iOrder) = itemPosition(find(cbMtx(:,iOrder)==iItem));
    
    end
    
  
end
% 
a = 1;
for i = 1:24:576
    itemOrder(:,a)=cbMtx(:,i);
    a = a+1;
 end
% 
% 
% %%%
% itemPosition = repmat([1:6]',96,24);
% 
% for iOrder = 1:24
%     
%     for iItem = 1:576
%     
%     whatever(iItem,iOrder) = itemPosition(find(test(:,iOrder)==iItem));
%     
%     end
%     
%   
% end

cd /Volumes/davachilab/MEGbound/blockOrder/

for iblock = 1:24
    load(['BlockOrder',num2str(iblock)])
    BlockOrder_allsubs(:,iblock) = BlockOrder(:);
end

BlockOrder_allsubs_repmat = [];
for irep = 1:length(BlockOrder_allsubs)
    BlockOrder_allsubs_repmat = [BlockOrder_allsubs_repmat; repmat(BlockOrder_allsubs(irep,:),6,1)];
end

for iRepeat = 1:1000

tmp = randperm(576);
randsample = tmp(1:24);
itemOrder = cbMtx(:,randsample);
ideal = ones(576,24);

for iOrder = 1:24
    
    for iItem = 1:576
        
        test(iItem,iOrder,:)=sum(itemOrder==iItem&BlockOrder_allsubs_repmat==iOrder);
        
    end
    
    
    
end

    similarity(iRepeat) = sum(sum(abs(sum(test,3) - ideal)));

end


    
    


    
