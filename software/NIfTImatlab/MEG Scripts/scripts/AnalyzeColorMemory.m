%Color memory analysis by position
clear all;
%Analyze the effect of distance between the colors for the source memory
%judgement as a function of condition

sub = {'21' '22' '23' '24' '25' '26' '27' '28' '29' '30' '31' '32'};

encodingDataAllBlocks = [];
testDataAllBlocks = [];

for isub = 1:length(sub)
    
    listnum = mod(str2num(sub{isub}),12);
    if listnum == 0
        listnum = 12;
    end
    
    load(['/Volumes/davachilab/MEGbound/Encoding/testSeq_16block_V5_' num2str(listnum)])
    
    for iblock = 1:16
        
        if exist(['/Volumes/davachilab/MEGbound/Data/V4/' sub{isub} '/encodingDataFileSub' sub{isub} 'Block' num2str(iblock) '.mat'],'file')
            
            load(['/Volumes/davachilab/MEGbound/Data/V4/' sub{isub} '/encodingDataFileSub' sub{isub} 'Block' num2str(iblock)])
            encodingDataAllBlocks{isub,iblock}=encodingDataFile;
            
        else
            
            encodingDataAllBlocks{isub,iblock}=nan(1,1,1);
            
        end
        
        if exist(['/Volumes/davachilab/MEGbound/Data/V4/' sub{isub} '/testDataFileSub' sub{isub} 'Block' num2str(iblock) '.mat'],'file')
            
            load(['/Volumes/davachilab/MEGbound/Data/V4/' sub{isub} '/testDataFileSub' sub{isub} 'Block' num2str(iblock)])
            testDataAllBlocks{isub,iblock}=testDataFile;
            
        else
            
            testDataAllBlocks{isub,iblock}=nan(1,1,1);
            
        end
        
    end
    
    colorOrderData = [];
    
    for iblock = 1:16
        
        if size(testDataAllBlocks{isub,iblock})<=1
            
        else
        
        colorOrder = unique(cell2mat(encodingDataAllBlocks{isub,iblock}(2:end,8)),'stable');
        
        for itrial = 2:4
            
            colorTrial = find(strcmpi(testDataAllBlocks{isub,iblock}(itrial,3),testSeq(:,2)));
            
            item = testSeq(colorTrial(1),2);
            
            colorsPresented = cell2mat(testSeq(colorTrial(1),[6 7]));
            
            response = strcmp(testDataAllBlocks{isub,iblock}(itrial,8),'k');
            
            correctAns = cell2mat(testDataAllBlocks{isub,iblock}(itrial,11));
            
            Accuracy = response == correctAns;
            
            RT = cell2mat(testDataAllBlocks{isub,iblock}(itrial,7));
            
            Condition = strcmp(testDataAllBlocks{isub,iblock}(itrial,9),'B');
            
            correctColorPosition = find(colorsPresented(1)==colorOrder);
            
            incorrectColorPosition = find(colorsPresented(2)==colorOrder);
            
            colorDiff = incorrectColorPosition - correctColorPosition;
            
            colorOrderData = [colorOrderData; colorsPresented Accuracy RT Condition correctColorPosition incorrectColorPosition colorDiff];
            
        end
        
        end
    
    end
    
    nbIdx = colorOrderData(:,5)==0;
    bIdx  = colorOrderData(:,5)==1;
    
    nbcorIdx = colorOrderData(:,5)==0&colorOrderData(:,3)==1;
    nbincIdx = colorOrderData(:,5)==0&colorOrderData(:,3)==0;
    
    bcorIdx = colorOrderData(:,5)==1&colorOrderData(:,3)==1;
    bincIdx = colorOrderData(:,5)==1&colorOrderData(:,3)==0;
    

    colorMemoryHist(isub,:) = histc(colorOrderData(:,8),[-5 -4 -3 -2 -1 0 1 2 3 4 5]);
    
    colorMemoryHistb(isub,:) = histc(colorOrderData(bIdx,8),[-5 -4 -3 -2 -1 0 1 2 3 4 5])';
    
    colorMemoryHistnb(isub,:) = histc(colorOrderData(nbIdx,8),[-5 -4 -3 -2 -1 0 1 2 3 4 5])';
    
    colorMemoryHistbcor(isub,:) = histc(colorOrderData(bcorIdx,8),[-5 -4 -3 -2 -1 0 1 2 3 4 5])';

    colorMemoryHistbinc(isub,:) = histc(colorOrderData(bincIdx,8),[-5 -4 -3 -2 -1 0 1 2 3 4 5])';
    
    colorMemoryHistnbcor(isub,:) = histc(colorOrderData(nbcorIdx,8),[-5 -4 -3 -2 -1 0 1 2 3 4 5])';
    
    colorMemoryHistnbinc(isub,:) = histc(colorOrderData(nbincIdx,8),[-5 -4 -3 -2 -1 0 1 2 3 4 5])';
    
    colorMemoryHistbcorMean(isub) = nanmean(colorOrderData(bcorIdx,8));
    
    colorMemoryHistbincMean(isub) = nanmean(colorOrderData(bincIdx,8));
    
    colorMemoryHistnbcorMean(isub) = nanmean(colorOrderData(nbcorIdx,8));
    
    colorMemoryHistnbincMean(isub) = nanmean(colorOrderData(nbincIdx,8));
    
    
end

% figure
% bar(mean(colorMemoryHistbcor)./mean(colorMemoryHistbinc))
% figure
% bar(mean(colorMemoryHistbinc))
% figure
% bar(mean(colorMemoryHistnbcor))
% figure
% bar(mean(colorMemoryHistnbinc))

subplot(1,2,1)
bar([-5 -4 -3 -2 -1 0 1 2 3 4 5],mean(colorMemoryHistb))
title('Average Color Memory Lure Distribution: Boundary','fontsize',18)
xlabel('position of lure relative to target','fontsize',18)
ylabel('average number of trials in each position','fontsize',18)

subplot(1,2,2)
bar([-5 -4 -3 -2 -1 0 1 2 3 4 5],mean(colorMemoryHistnb))
title('Average Color Memory Lure Distribution: Non-boundary','fontsize',18)
xlabel('position of lure relative to target','fontsize',18)
ylabel('average number of trials in each position','fontsize',18)

figure;
bar([-5 -4 -3 -2 -1 0 1 2 3 4 5],mean(colorMemoryHist))
title('Grand Average Color Memory Lure Distribution','fontsize',18)
xlabel('position of lure relative to target','fontsize',18)
ylabel('average number of trials in each position','fontsize',18)


figure;
bar([-5 -4 -3 -2 -1 0 1 2 3 4 5],(sum(colorMemoryHistbcor)+sum(colorMemoryHistnbcor))./(sum(colorMemoryHistbcor)+sum(colorMemoryHistnbcor)+sum(colorMemoryHistbinc)+sum(colorMemoryHistnbinc)))
title('Grand Average Color Memory Accuracy by Position','fontsize',18)
xlabel('position of lure relative to target','fontsize',18)
ylabel('Accuracy','fontsize',18)

figure;
subplot(1,2,1)
bar([-5 -4 -3 -2 -1 0 1 2 3 4 5],sum(colorMemoryHistbcor)./(sum(colorMemoryHistbcor)+sum(colorMemoryHistbinc)))
title('Grand Average Color Memory Accuracy by Position: Boundary','fontsize',18)
xlabel('position of lure relative to target','fontsize',18)
ylabel('Accuracy','fontsize',18)


subplot(1,2,2)
bar([-5 -4 -3 -2 -1 0 1 2 3 4 5],sum(colorMemoryHistnbcor)./(sum(colorMemoryHistnbcor)+sum(colorMemoryHistnbinc)))
title('Grand Average Color Memory Accuracy by Position: Nob-boundary','fontsize',18)
xlabel('position of lure relative to target','fontsize',18)
ylabel('Accuracy','fontsize',18)



