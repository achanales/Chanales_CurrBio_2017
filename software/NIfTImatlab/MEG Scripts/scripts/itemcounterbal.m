
% itemcounterbal.m
% script to generate counterbalanced lists for MEGBound

% create matrix to store lists
nLists = 16;
ListMat = zeros(96,6,nLists);

% create item list (each # corresponds to an item)
a = [1:576]';

% shape items into 96 'events' of 6 items each
a = reshape(a,6,96)';


colposshift = repmat([-1:-1:-6],1,3);

for iList = 1:nLists
    t = zeros(size(a));
    if iList==1
        ListMat(:,:,iList) = a;
        
    else
        % shift each column of the 96x6 matrix by amount specified in colshiftnrows.
        % shifting each column by a different amount ensures that every item is
        % paired with a new set of 5 other items for each list.
        colshiftnrows = [-6 -5 -4 -3 -2 -1];
        for iCol = 1:6
            t(:,iCol) = circshift(a(:,iCol),iList*colshiftnrows(iCol));
        end
        
        % after shifting each column by a different # of rows, then shift entire
        % columns around so that each column is placed in a different 1-6 'within
        % event' position in each list
        t = circshift(t,[0 colposshift(iList)]);
        ListMat(:,:,iList) = t;
    end

end % iList



% need to randomly permute rows of lists and then check to make sure there
% are enough that are free of repeat pairs
ListThresh = 15; nIter = 1;
tic
%while 1
    
    % randomly shuffle the rows of each list in ListMat
    % do this random shuffling for as long as needed to generate some number of
    % lists without repeated pairs
    %rand('state',sum(100*clock))
%     for iList = 1:nLists
%         ListMat(:,:,iList) = ListMat(randperm(length(ListMat)),:,iList);
%     end
%     
    
    % now need to implement checks to make sure that triplets of items are not
    % paired together across events more than once
    inds = nan(95,nLists,nLists);
    for iList = 1:nLists
        
        while 1
        
            ListMat(:,:,iList) = ListMat(randperm(length(ListMat)),:,iList);
            
            for iRow = 1:95
                pair = [ListMat(iRow,6,iList),ListMat(iRow+1,1,iList)]';
                
                for iList2 = 1:iList
                    tmpList = reshape(ListMat(:,:,iList2)',576,1);
                    inds(iRow,iList2,iList) = length(findsubmat(tmpList,pair));
                end % iList2
                
            end % iRow
            
            %totals = squeeze(nansum(nansum(inds,2))-95;
            %if sum(totals<=ListThresh) == 16
            %    break
            %end
            
            totals = sum(nansum(inds(:,:,iList),2))-95;
            if totals==0
                break
            end
            
        end % while
        display(['completed ' num2str(iList) ' lists']);
        save ListMat_v2 ListMat
        
        
    end % iList
    
    
%     totals = squeeze(sum(sum(inds),2))-95;
%     if sum(totals<=ListThresh) == 16
%         break
%     end
%     

%     nIter = nIter+1;
%     if mod(nIter,10000)==0
%         display(['completed ' num2str(nIter) ' iterations...']);
%     end
%     
%end % while
toc



