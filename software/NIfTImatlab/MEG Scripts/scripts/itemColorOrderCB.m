%load in item lists
load /Volumes/davachilab/MEGbound/scripts/ListMat_v2

%reshape item list

for ishape=1:12
    
    tmp = ListMat(:,:,ishape)';
    itemList(:,ishape) = tmp(:);
    
end

%clean up
clearvars -except itemList

for iboot = 1:5000

%initiate variable that breaks loop if the process searches too long
tmp_break = 0;

%generate a starting list
initColorOrder = colorOrderScript();
colorOrder = initColorOrder;
itemColors = [];

%get item/color pairings for the first list
[tmp,I] = sort(itemList(:,1));
itemColors = initColorOrder(I);



while size(itemColors,2)<12

    tmp_break = 0;
    
    %now generate the other 11 lists
    for iList = 2:12
        %iList = 2;
        
        tmp_break = 0;
        
        tic
        while 1
            
            %generate a color list
            curColorOrder = colorOrderScript();
            
            %get item indices
            [tmp,I] = sort(itemList(:,iList));
            itemColors(:,iList)=curColorOrder(I);
            
            for iunique = 1:576
                
                if abs(length(unique(itemColors(iunique,:)))-length(itemColors(iunique,:)))<7
                else
                    break
                end
            end
            
            if iunique==576
                break
            end
            
            if toc>10 && size(itemColors,2)<12
                tic
                tmp_break = 1;
                break
            end
            
            if toc>3600 && size(itemColors,2)>=12
                tic
                tmp_break = 1;
                break
            end
            
        end
        
        if tmp_break==1
            
            disp('Restarting...')
            
            %generate a starting list
            initColorOrder = colorOrderScript();
            colorOrder = initColorOrder;
            itemColors = [];
            
            %get item/color pairings for the first list
            [tmp,I] = sort(itemList(:,1));
            itemColors = initColorOrder(I);
            
            break
        end
        
        colorOrder = [colorOrder curColorOrder];
        
        disp(['Finished list:',num2str(iList),' in: ',num2str(toc)])
        save itemColors itemColors
        save colorOrder colorOrder
        
        
    end
    
end

for iItem = 1:length(itemColors)
    
    repeats(iItem) = length(itemColors(iItem,:)) - length(unique(itemColors(iItem,:)));
    
end

repSum(iboot) = sum(repeats>3);
itemColorsBoot(:,:,iboot)=itemColors;
colorOrderBoot(:,:,iboot)=colorOrder;

save itemColorsBoot itemColorsBoot colorOrderBoot repSum


end

theOne = find(repSum==min(repSum));
theList = colorOrderBoot(:,:,theOne);

for icheck3 = 1:740
    
    for icheck1 = 1:24
        
        for icheck2 = 1:576
            
            freqlist(icheck1,icheck2,icheck3)= sum(sum(itemList==icheck2&colorOrderBoot(:,:,icheck3)==icheck1));
            
        end
        
    end
    
end

for ifreqlist = 1:740
    
    freqMtx(:,ifreqlist)=[sum(sum(freqlist(:,:,ifreqlist)==0)) sum(sum(freqlist(:,:,ifreqlist)==1)) sum(sum(freqlist(:,:,ifreqlist)==2)) sum(sum(freqlist(:,:,ifreqlist)==3)) sum(sum(freqlist(:,:,ifreqlist)==4)) sum(sum(freqlist(:,:,ifreqlist)==5)) sum(sum(freqlist(:,:,ifreqlist)==6))];      
end   
