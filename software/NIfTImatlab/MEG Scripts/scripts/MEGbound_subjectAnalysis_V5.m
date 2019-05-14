function data = MEGbound_subjectAnalysis(sub,omitBlocks)

CTM_cor_B_stimNames_group = [];
CTM_cor_NB_stimNames_group = [];


for isub = 1:length(sub)
    
    cd(['/Volumes/davachilab/MEGbound/Data/V6/' sub{isub}])
    
    %encoding analysis
    blocks = 1:16;
    
    if nargin==2
        blocks(omitBlocks)=[];
    end
    
    encoding = [];
    
    for iblock = blocks
        
        load(['encodingDataFileSub' sub{isub} 'Block' num2str(iblock)]);
        
        encoding = [encoding; encodingDataFile(2:end,:)];
        
        
    end
    
    
    %Encoding RTs for boundary and nonboundary items
    
    Encoding.RT.B = [];
    Encoding.RT.NB = [];
    EncodingBoundaryTrials = [];
    
    for iRTs = 1:length(encoding)
        
        if strcmp('B',encoding{iRTs,7})
            
            Encoding.RT.B = [Encoding.RT.B; cell2mat(encoding(iRTs,5))];
            EncodingBoundaryTrials = [EncodingBoundaryTrials; encoding(iRTs,:)];
            
        elseif strcmp('NB',encoding{iRTs,7})||strcmp('PB',encoding{iRTs,7})
            
            Encoding.RT.NB = [Encoding.RT.NB; cell2mat(encoding(iRTs,5))];
            
        end
        
    end
    
    figure
    h = bar([mean(Encoding.RT.B) mean(Encoding.RT.NB)]);
    hold on
    errorbar([mean(Encoding.RT.B) mean(Encoding.RT.NB)],[std(Encoding.RT.B) std(Encoding.RT.NB)],'*')
    axis([0 3 0 2])
    conditions = {'Boundary','Non-Boundary'};
    set(gca,'xTickLabel',conditions,'FontSize',20);
    ylabel('Response Time (seconds)','FontSize',20);
    title('Encoding Response Times','FontSize',20)
    axis tight
    
    
    %Encoding by position
    
    Encoding.RTs.pos1 = cell2mat(encoding(cell2mat(encoding(:,9))==1,5));
    Encoding.RTs.pos2 = cell2mat(encoding(cell2mat(encoding(:,9))==2,5));
    Encoding.RTs.pos3 = cell2mat(encoding(cell2mat(encoding(:,9))==3,5));
    Encoding.RTs.pos4 = cell2mat(encoding(cell2mat(encoding(:,9))==4,5));
    Encoding.RTs.pos5 = cell2mat(encoding(cell2mat(encoding(:,9))==5,5));
    Encoding.RTs.pos6 = cell2mat(encoding(cell2mat(encoding(:,9))==6,5));
    
    figure
    bar([mean(Encoding.RTs.pos1) mean(Encoding.RTs.pos2) mean(Encoding.RTs.pos3)...
        mean(Encoding.RTs.pos4) mean(Encoding.RTs.pos5) mean(Encoding.RTs.pos6)])
    
    hold on
    
    
    errorbar([mean(Encoding.RTs.pos1) mean(Encoding.RTs.pos2) mean(Encoding.RTs.pos3)...
        mean(Encoding.RTs.pos4) mean(Encoding.RTs.pos5) mean(Encoding.RTs.pos6)],...
        [std(Encoding.RTs.pos1) std(Encoding.RTs.pos2) std(Encoding.RTs.pos3)...
        std(Encoding.RTs.pos4) std(Encoding.RTs.pos5) std(Encoding.RTs.pos6)],'*')
    
    conditions = {'pos1','pos2','pos3','pos4','pos5','pos6'};
    set(gca,'xTickLabel',conditions,'FontSize',20);
    ylabel('Response Time (seconds)','FontSize',20);
    title('Encoding Response Times by Position','FontSize',20)
    axis tight
    
    %
    
    
    
    
    % Temporal order test
    
    sourcetest = [];
    ordertest = [];
    for iblock = blocks
        
        load(['testDataFileSub' sub{isub} 'Block' num2str(iblock)]);
        
        sourcetest = [sourcetest; testDataFile(2:12,:)];
        ordertest = [ordertest; testDataFile(13:23,:)];
        
        
    end
    
    
    
    
    BcorrectHC_source_trials = zeros(176,1);
    NBcorrectHC_source_trials = zeros(176,1);
    BincorrectHC_source_trials = zeros(176,1);
    NBincorrectHC_source_trials = zeros(176,1);
    
    BcorrectLC_source_trials = zeros(176,1);
    NBcorrectLC_source_trials = zeros(176,1);
    BincorrectLC_source_trials = zeros(176,1);
    NBincorrectLC_source_trials = zeros(176,1);
    
    for itrial = 1:size(sourcetest,1)
        
        if strcmp('B',sourcetest{itrial,9})&&((sourcetest{itrial,12}==0&&(strcmp('h',sourcetest{itrial,8})))||(sourcetest{itrial,12}==1&&(strcmp('l',sourcetest{itrial,8}))))
            
            BcorrectHC_source_trials(itrial) = 1;
            
        end
        
        if strcmp('B',sourcetest{itrial,9})&&((sourcetest{itrial,12}==1&&(strcmp('h',sourcetest{itrial,8})))||(sourcetest{itrial,12}==0&&(strcmp('l',sourcetest{itrial,8}))))
            
            BincorrectHC_source_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',sourcetest{itrial,9})&&((sourcetest{itrial,12}==0&&(strcmp('h',sourcetest{itrial,8})))||(sourcetest{itrial,12}==1&&(strcmp('l',sourcetest{itrial,8}))))
            
            NBcorrectHC_source_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',sourcetest{itrial,9})&&((sourcetest{itrial,12}==1&&(strcmp('h',sourcetest{itrial,8})))||(sourcetest{itrial,12}==0&&(strcmp('l',sourcetest{itrial,8}))))
            
            NBincorrectHC_source_trials(itrial) = 1;
            
        end
        
        if strcmp('B',sourcetest{itrial,9})&&((sourcetest{itrial,12}==0&&(strcmp('j',sourcetest{itrial,8})))||(sourcetest{itrial,12}==1&&(strcmp('k',sourcetest{itrial,8}))))
            
            BcorrectLC_source_trials(itrial) = 1;
            
        end
        
        if strcmp('B',sourcetest{itrial,9})&&((sourcetest{itrial,12}==1&&(strcmp('j',sourcetest{itrial,8})))||(sourcetest{itrial,12}==0&&(strcmp('k',sourcetest{itrial,8}))))
            
            BincorrectLC_source_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',sourcetest{itrial,9})&&((sourcetest{itrial,12}==0&&(strcmp('j',sourcetest{itrial,8})))||(sourcetest{itrial,12}==1&&(strcmp('k',sourcetest{itrial,8}))))
            
            NBcorrectLC_source_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',sourcetest{itrial,9})&&((sourcetest{itrial,12}==1&&(strcmp('j',sourcetest{itrial,8})))||(sourcetest{itrial,12}==0&&(strcmp('k',sourcetest{itrial,8}))))
            
            NBincorrectLC_source_trials(itrial) = 1;
            
        end
        
    end
    
    Bsource_HCacc = (sum(BcorrectHC_source_trials)/(length(blocks)*5))/((sum(BcorrectHC_source_trials)/(length(blocks)*5)) + (sum(BincorrectHC_source_trials)/(length(blocks)*5)));
    NBsource_HCacc = (sum(NBcorrectHC_source_trials)/(length(blocks)*5))/((sum(NBcorrectHC_source_trials)/(length(blocks)*5)) + (sum(NBincorrectHC_source_trials)/(length(blocks)*5)));
    
    Bsource_LCacc = (sum(BcorrectLC_source_trials)/(length(blocks)*5))/((sum(BcorrectLC_source_trials)/(length(blocks)*5)) + (sum(BincorrectLC_source_trials)/(length(blocks)*5)));
    NBsource_LCacc = (sum(NBcorrectLC_source_trials)/(length(blocks)*5))/((sum(NBcorrectLC_source_trials)/(length(blocks)*5)) + (sum(NBincorrectLC_source_trials)/(length(blocks)*5)));
    
    
    
    Bsource_HCacc_proportion = sum(BcorrectHC_source_trials)/(length(blocks)*5);
    NBsource_HCacc_proportion = sum(NBcorrectHC_source_trials)/(length(blocks)*6);
    
    Bsource_LCacc_proportion = sum(BcorrectLC_source_trials)/(length(blocks)*5);
    NBsource_LCacc_proportion = sum(NBcorrectLC_source_trials)/(length(blocks)*6);
    
    BcorrectHC_order_trials = zeros(176,1);
    NBcorrectHC_order_trials = zeros(176,1);
    BincorrectHC_order_trials = zeros(176,1);
    NBincorrectHC_order_trials = zeros(176,1);
    
    BcorrectLC_order_trials = zeros(176,1);
    NBcorrectLC_order_trials = zeros(176,1);
    BincorrectLC_order_trials = zeros(176,1);
    NBincorrectLC_order_trials = zeros(176,1);
    
    
    for itrial = 1:size(ordertest,1)
        
        if strcmp('B',ordertest{itrial,9})&&((ordertest{itrial,12}==0&&(strcmp('h',ordertest{itrial,8})))||(ordertest{itrial,12}==1&&(strcmp('l',ordertest{itrial,8}))))
            
            BcorrectHC_order_trials(itrial) = 1;
            
        end
        
        if strcmp('B',ordertest{itrial,9})&&((ordertest{itrial,12}==1&&(strcmp('h',ordertest{itrial,8})))||(ordertest{itrial,12}==0&&(strcmp('l',ordertest{itrial,8}))))
            
            BincorrectHC_order_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',ordertest{itrial,9})&&((ordertest{itrial,12}==0&&(strcmp('h',ordertest{itrial,8})))||(ordertest{itrial,12}==1&&(strcmp('l',ordertest{itrial,8}))))
            
            NBcorrectHC_order_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',ordertest{itrial,9})&&((ordertest{itrial,12}==1&&(strcmp('h',ordertest{itrial,8})))||(ordertest{itrial,12}==0&&(strcmp('l',ordertest{itrial,8}))))
            
            NBincorrectHC_order_trials(itrial) = 1;
            
        end
        
        if strcmp('B',ordertest{itrial,9})&&((ordertest{itrial,12}==0&&(strcmp('j',ordertest{itrial,8})))||(ordertest{itrial,12}==1&&(strcmp('k',ordertest{itrial,8}))))
            
            BcorrectLC_order_trials(itrial) = 1;
            
        end
        
        if strcmp('B',ordertest{itrial,9})&&((ordertest{itrial,12}==1&&(strcmp('j',ordertest{itrial,8})))||(ordertest{itrial,12}==0&&(strcmp('k',ordertest{itrial,8}))))
            
            BincorrectLC_order_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',ordertest{itrial,9})&&((ordertest{itrial,12}==0&&(strcmp('j',ordertest{itrial,8})))||(ordertest{itrial,12}==1&&(strcmp('k',ordertest{itrial,8}))))
            
            NBcorrectLC_order_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',ordertest{itrial,9})&&((ordertest{itrial,12}==1&&(strcmp('j',ordertest{itrial,8})))||(ordertest{itrial,12}==0&&(strcmp('k',ordertest{itrial,8}))))
            
            NBincorrectLC_order_trials(itrial) = 1;
            
        end
        
    end
    
    Border_HCacc = (sum(BcorrectHC_order_trials)/(length(blocks)*5))/((sum(BcorrectHC_order_trials)/(length(blocks)*5)) + (sum(BincorrectHC_order_trials)/(length(blocks)*5)));
    NBorder_HCacc = (sum(NBcorrectHC_order_trials)/(length(blocks)*5))/((sum(NBcorrectHC_order_trials)/(length(blocks)*5)) + (sum(NBincorrectHC_order_trials)/(length(blocks)*5)));
    
    Border_LCacc = (sum(BcorrectLC_order_trials)/(length(blocks)*5))/((sum(BcorrectLC_order_trials)/(length(blocks)*5)) + (sum(BincorrectLC_order_trials)/(length(blocks)*5)));
    NBorder_LCacc = (sum(NBcorrectLC_order_trials)/(length(blocks)*5))/((sum(NBcorrectLC_order_trials)/(length(blocks)*5)) + (sum(NBincorrectLC_order_trials)/(length(blocks)*5)));
    
    
    
    
    Border_HCacc_proportion = sum(BcorrectHC_order_trials)/(length(blocks)*5);
    NBorder_HCacc_proportion = sum(NBcorrectHC_order_trials)/(length(blocks)*6);
    
    Border_LCacc_proportion = sum(BcorrectLC_order_trials)/(length(blocks)*5);
    NBorder_LCacc_proportion = sum(NBcorrectLC_order_trials)/(length(blocks)*6);
    
    
    Test.Source.Acc.B = Bsource_HCacc_proportion + Bsource_LCacc_proportion;
    Test.Source.Acc.NB = NBsource_HCacc_proportion + NBsource_LCacc_proportion;
    Test.Order.Acc.B = Border_HCacc_proportion + Border_LCacc_proportion;
    Test.Order.Acc.NB = NBorder_HCacc_proportion + NBorder_LCacc_proportion;
    
    Test.Source.Acc.B_HC = Bsource_HCacc_proportion;
    Test.Source.Acc.NB_HC = NBsource_HCacc_proportion;
    Test.Order.Acc.B_HC = Border_HCacc_proportion;
    Test.Order.Acc.NB_HC = NBorder_HCacc_proportion;
    
    %WC = within confidence
    Test.Source.Acc.B_HC_WC = Bsource_HCacc;
    Test.Source.Acc.NB_HC_WC = NBsource_HCacc;
    Test.Order.Acc.B_HC_WC = Border_HCacc;
    Test.Order.Acc.NB_HC_WC = NBorder_HCacc;
    
    Test.Source.Acc.B_LC = Bsource_LCacc_proportion;
    Test.Source.Acc.NB_LC = NBsource_LCacc_proportion;
    Test.Order.Acc.B_LC = Border_LCacc_proportion;
    Test.Order.Acc.NB_LC = NBorder_LCacc_proportion;
    
    Test.Source.Acc.B_LC_WC = Bsource_LCacc;
    Test.Source.Acc.NB_LC_WC = NBsource_LCacc;
    Test.Order.Acc.B_LC_WC = Border_LCacc;
    Test.Order.Acc.NB_LC_WC = NBorder_LCacc;
    
    Test.Source.RT.Bcor = cell2mat(sourcetest(logical(BcorrectHC_source_trials+BcorrectLC_source_trials),7));
    Test.Source.RT.NBcor = cell2mat(sourcetest(logical(NBcorrectHC_source_trials+NBcorrectLC_source_trials),7));
    Test.Order.RT.Bcor = cell2mat(ordertest(logical(BcorrectHC_order_trials+BcorrectLC_order_trials),7));
    Test.Order.RT.NBcor = cell2mat(ordertest(logical(NBcorrectHC_order_trials+NBcorrectLC_order_trials),7));
    
    Test.Source.RT.Binc = cell2mat(sourcetest(logical(BincorrectHC_source_trials+BincorrectLC_source_trials),7));
    Test.Source.RT.NBinc = cell2mat(sourcetest(logical(NBincorrectHC_source_trials+NBincorrectLC_source_trials),7));
    Test.Order.RT.Binc = cell2mat(ordertest(logical(BincorrectHC_order_trials+BincorrectLC_order_trials),7));
    Test.Order.RT.NBinc = cell2mat(ordertest(logical(NBincorrectHC_order_trials+NBincorrectLC_order_trials),7));
    
    Test.Source.RT.Bcor_HC = cell2mat(sourcetest(logical(BcorrectHC_source_trials),7));
    Test.Source.RT.NBcor_HC = cell2mat(sourcetest(logical(NBcorrectHC_source_trials),7));
    Test.Order.RT.Bcor_HC = cell2mat(ordertest(logical(BcorrectHC_order_trials),7));
    Test.Order.RT.NBcor_HC = cell2mat(ordertest(logical(NBcorrectHC_order_trials),7));
    
    Test.Source.RT.Binc_HC = cell2mat(sourcetest(logical(BincorrectHC_source_trials),7));
    Test.Source.RT.NBinc_HC = cell2mat(sourcetest(logical(NBincorrectHC_source_trials),7));
    Test.Order.RT.Binc_HC = cell2mat(ordertest(logical(BincorrectHC_order_trials),7));
    Test.Order.RT.NBinc_HC = cell2mat(ordertest(logical(NBincorrectHC_order_trials),7));
    
    
    Test.Source.RT.Bcor_LC = cell2mat(sourcetest(logical(BcorrectLC_source_trials),7));
    Test.Source.RT.NBcor_LC = cell2mat(sourcetest(logical(NBcorrectLC_source_trials),7));
    Test.Order.RT.Bcor_LC = cell2mat(ordertest(logical(BcorrectLC_order_trials),7));
    Test.Order.RT.NBcor_LC = cell2mat(ordertest(logical(NBcorrectLC_order_trials),7));
    
    Test.Source.RT.Binc_LC = cell2mat(sourcetest(logical(BincorrectLC_source_trials),7));
    Test.Source.RT.NBinc_LC = cell2mat(sourcetest(logical(NBincorrectLC_source_trials),7));
    Test.Order.RT.Binc_LC = cell2mat(ordertest(logical(BincorrectLC_order_trials),7));
    Test.Order.RT.NBinc_LC = cell2mat(ordertest(logical(NBincorrectLC_order_trials),7));
    
    
    highBoundRT = nanmean([Test.Order.RT.Bcor; Test.Order.RT.Binc; Test.Order.RT.NBcor; Test.Order.RT.NBinc]) + nanstd([Test.Order.RT.Bcor; Test.Order.RT.Binc; Test.Order.RT.NBcor; Test.Order.RT.NBinc])*3;
    lowboundRT = nanmean([Test.Order.RT.Bcor; Test.Order.RT.Binc; Test.Order.RT.NBcor; Test.Order.RT.NBinc]) - std([Test.Order.RT.Bcor; Test.Order.RT.Binc; Test.Order.RT.NBcor; Test.Order.RT.NBinc])*3;
    
    Test.Source.RT.Bcor_HC_cleaned = Test.Source.RT.Bcor_HC(lowboundRT<Test.Source.RT.Bcor_HC<highBoundRT);
    Test.Source.RT.NBcor_HC_cleaned = cell2mat(sourcetest(logical(NBcorrectHC_source_trials),7));
    Test.Order.RT.Bcor_HC_cleaned = cell2mat(ordertest(logical(BcorrectHC_order_trials),7));
    Test.Order.RT.NBcor_HC_cleaned = cell2mat(ordertest(logical(NBcorrectHC_order_trials),7));
    
    
    Btrials = [];
    for a = 1:length(sourcetest)
        
        if strcmp(sourcetest{a,9},'B')
            
            Btrials = [Btrials; sourcetest(a,2) sourcetest(a,7)];
            
        end
        
    end
    
    
    for b = 1:length(Btrials)
        
        Btrials{b,3} = encoding{strmatch(Btrials{b,1},[encoding{:,2}]),5};
        
    end
    
    temp = [];
    for b = 1:length(Btrials)
        
        if ~isempty(Btrials{b,3})
            
            temp = [temp; Btrials(b,:)];
            
        end
        
    end
    
    %test for order primacy effects
    %     temp = [];
    %
    %         for itest = 1:length(ordertest)
    %
    %             for itest2 = 1:length(encoding)
    %             temp(itest2) = strcmp(ordertest(itest,2),encoding{itest2,2});
    %             end
    %
    %             position(itest) = encoding{find(temp),1};
    %             clear temp
    %         end
    %
    %         [sorted_position sorted_idx] = sort(position);
    %
    %         Btest =[sorted_position' BcorrectHC_order_trials(sorted_idx)+BcorrectLC_order_trials(sorted_idx)];
    %         Btest = mean(reshape(Btest([17:32 49:64 81:96 113:128 145:160],2),16,5));
    %
    %         NBtest =[sorted_position' NBcorrectHC_order_trials(sorted_idx)+NBcorrectLC_order_trials(sorted_idx)];
    %         NBtest = mean(reshape(NBtest([1:16 33:48 65:80 97:112 129:144 161:176],2),16,6));
    %
    %         Test.Order.AccbyBlockPosition.B = Btest;
    %         Test.Order.AccbyBlockPosition.NB = NBtest;
    %
    %         %test for source primacy effects
    %
    %         for itest = 1:length(sourcetest)
    %
    %             for itest2 = 1:length(encoding)
    %             temp(itest2) = strcmp(sourcetest(itest,2),encoding{itest2,2});
    %             end
    %
    %             position(itest) = encoding{find(temp),1};
    %             clear temp
    %         end
    %
    %         [sorted_position sorted_idx] = sort(position);
    %
    %         Btest =[sorted_position' BcorrectHC_source_trials(sorted_idx)+BcorrectLC_source_trials(sorted_idx)];
    %         Btest = mean(reshape(Btest([17:32 49:64 81:96 113:128 145:160],2),16,5));
    %
    %         NBtest =[sorted_position' NBcorrectHC_source_trials(sorted_idx)+NBcorrectLC_source_trials(sorted_idx)];
    %         NBtest = mean(reshape(NBtest([1:16 33:48 65:80 97:112 129:144 161:176],2),16,6));
    %
    %         Test.Source.AccbyBlock.B = Btest;
    %         Test.Source.AccbyBlock.NB = NBtest;
    
    
    
    figure
    bar([Test.Source.Acc.B_HC Test.Source.Acc.B_LC; Test.Source.Acc.NB_HC  Test.Source.Acc.NB_LC; Test.Order.Acc.B_HC Test.Order.Acc.B_LC; Test.Order.Acc.NB_HC  Test.Order.Acc.NB_LC],'stacked')
    conditions = {'Source B Acc','Source NB Acc','Order B Acc','Order NB Acc'};
    set(gca,'xTickLabel',conditions,'FontSize',12);
    ylabel('Accuracy (proportion correct)','FontSize',20);
    title('Accuracy by Condition','FontSize',20)
    axis([0 5 0 1])
    
    figure
    bar([mean(Test.Source.RT.Bcor) mean(Test.Source.RT.Binc) mean(Test.Source.RT.NBcor) mean(Test.Source.RT.NBinc)])
    conditions = {'Boundary Correct','Boundary Incorrect','Non-Boundary Correct','Non-Boundary Incorrect'};
    set(gca,'xTickLabel',conditions,'FontSize',12);
    ylabel('Response Time (seconds)','FontSize',20);
    title('Response Time at Source Retrieval by Condition','FontSize',20)
    hold on
    errorbar([mean(Test.Source.RT.Bcor) mean(Test.Source.RT.Binc) mean(Test.Source.RT.NBcor) mean(Test.Source.RT.NBinc)],[std(Test.Source.RT.Bcor) std(Test.Source.RT.Binc) std(Test.Source.RT.NBcor) std(Test.Source.RT.NBinc)],'*')
    
    figure
    bar([mean(Test.Order.RT.Bcor) mean(Test.Order.RT.Binc) mean(Test.Order.RT.NBcor) mean(Test.Order.RT.NBinc)])
    conditions = {'Boundary Correct','Boundary Incorrect','Non-Boundary Correct','Non-Boundary Incorrect'};
    set(gca,'xTickLabel',conditions,'FontSize',12);
    ylabel('Response Time (seconds)','FontSize',20);
    title('Response Time at Order Retrieval by Condition','FontSize',20)
    hold on
    errorbar([mean(Test.Order.RT.Bcor) mean(Test.Order.RT.Binc) mean(Test.Order.RT.NBcor) mean(Test.Order.RT.NBinc)],[std(Test.Order.RT.Bcor) std(Test.Order.RT.Binc) std(Test.Order.RT.NBcor) std(Test.Order.RT.NBinc)],'*')
    
    
    
    
    fig1 = figure(1);
    set(fig1, 'Position', [0 0 1000 600])
    print(fig1,'-djpeg', 'avgRTs.jpeg')
    
    fig2 = figure(2);
    set(fig2, 'Position', [0 0 1000 600])
    print(fig2,'-djpeg', 'RTsbypos.jpeg')
    
    fig3 = figure(3);
    set(fig3, 'Position', [0 0 1000 600])
    print(fig3,'-djpeg', 'accuracy.jpeg')
    
    fig4 = figure(4);
    set(fig4, 'Position', [0 0 1000 600])
    print(fig4,'-djpeg', 'sourceRTs.jpeg')
    
    fig5 = figure(5);
    set(fig5, 'Position', [0 0 1000 600])
    print(fig5,'-djpeg', 'orderRTs.jpeg')
    
    
    
    
    % Here is where the coarse temporal memory test is analyzed.  The
    % trials in the test are always position 1 or 4.
    % I don't yet separate the trials by accuracy during the color memory
    % experiment.  You could do this by reading out the accuracy from the
    % test files. TestDataFile(2:12,2) contains the names of the items that
    % are in the coarse temporal memory test.  TestDataFile(2:12,8) is the
    % response and TestDataFile(2:12,12) is the side of the screen the
    % correct answer is on where 0 means the correct answer was on the left
    % and 1 means the correct answer was on the right.
    
    %keyboard
    
    load(['MEGBound_PostTest_behav_data_s' sub{isub}]);
    
    
    PostTest.Acc.B = [];
    PostTest.Acc.NB = [];
    PostTest.RTs.B = [];
    PostTest.RTs.NB = [];
    
    %add in the condition labels
    Line_Resp_Record(:,3) = postTestSeq(:,2);
    
    %add in the study position (1:576) divide by 576 to get 'normalized'
    %position
    Line_Resp_Record(:,4) = postTestSeq(:,8);
    
    %removes the items rated as 'new' from the analysis and add the
    %remaining items to a new variable
    for itrial = 1:length(Line_Resp_Record)
        
        if strcmp('B',Line_Resp_Record{itrial,3})
            
            if Line_Resp_Record{itrial,10}==99
                
                PostTest.Acc.B = [PostTest.Acc.B; NaN NaN];
                PostTest.RTs.B = [PostTest.RTs.B; NaN];
                
            else
                
                PostTest.Acc.B = [PostTest.Acc.B; cell2mat(Line_Resp_Record(itrial,4))/576 cell2mat(Line_Resp_Record(itrial,9)) ];
                PostTest.RTs.B = [PostTest.RTs.B; cell2mat(Line_Resp_Record(itrial,11))];
                
            end
            
            
            
        elseif strcmp('NB',Line_Resp_Record{itrial,3})
            
            if Line_Resp_Record{itrial,10}==99
                
                PostTest.Acc.NB = [PostTest.Acc.NB; NaN NaN];
                PostTest.RTs.NB = [PostTest.RTs.NB; NaN];
                
            else
                
                PostTest.Acc.NB = [PostTest.Acc.NB; cell2mat(Line_Resp_Record(itrial,4))/576 cell2mat(Line_Resp_Record(itrial,9)) ];
                PostTest.RTs.NB = [PostTest.RTs.NB; cell2mat(Line_Resp_Record(itrial,11))];
                
            end
            
        end
        
    end
    
    tmp1idx = isnan(PostTest.Acc.B(:,1));
    tmpdata1 = [PostTest.Acc.B(:,1) PostTest.Acc.B(:,2)];
    tmpdata1(tmp1idx,:)=[];
    
    tmp2idx = isnan(PostTest.Acc.NB(:,1));
    tmpdata2 = [PostTest.Acc.NB(:,1) PostTest.Acc.NB(:,2)];
    tmpdata2(tmp2idx,:)=[];
    
    PostTest.corr.B = corr(tmpdata1(:,1),tmpdata1(:,2));
    PostTest.corr.NB = corr(tmpdata2(:,1),tmpdata2(:,2));
    
    
    
    figure
    subplot(2,2,1)
    B_scatter = scatter(PostTest.Acc.B(:,1),PostTest.Acc.B(:,2),'r');
    title('Boundary')
    axis([0 1 0 1])
    xlabel('Actual Position')
    ylabel('Estimated Position')
    lsline
    hold on
    plot([0 1],[0 1],'--k')
    
    subplot(2,2,2)
    NB_scatter = scatter(PostTest.Acc.NB(:,1),PostTest.Acc.NB(:,2),'g');
    lsline
    title('Non-Boundary')
    axis([0 1 0 1])
    xlabel('Actual Position')
    ylabel('Estimated Position')
    hold on
    plot([0 1],[0 1],'--k')
    
    [sorted_B B_sort_idx] = sort(PostTest.Acc.B(:,1));
    [sorted_NB NB_sort_idx] = sort(PostTest.Acc.NB(:,1));
    
    sorted_estimated_B = PostTest.Acc.B(B_sort_idx,2);
    sorted_estimated_NB = PostTest.Acc.NB(NB_sort_idx,2);
    
    subplot(2,2,3)
    hold on
    for iplot = 1:length(PostTest.Acc.B(:,1))
        
        if sorted_estimated_B(iplot)<1
            plot([sorted_B(iplot) sorted_B(iplot)],[sorted_B(iplot) sorted_estimated_B(iplot)])
            CTM_B_error(iplot) = sorted_B(iplot) - sorted_estimated_B(iplot);
        else
            CTM_B_error(iplot) = NaN;
        end
    end
    hold off
    axis([0 1 0 1])
    
    subplot(2,2,4)
    
    hold on
    for iplot = 1:length(PostTest.Acc.NB(:,1))
        
        if sorted_estimated_NB(iplot)<1
            plot([sorted_NB(iplot) sorted_NB(iplot)],[sorted_NB(iplot) sorted_estimated_NB(iplot)])
            CTM_NB_error(iplot) = sorted_NB(iplot) - sorted_estimated_NB(iplot);
        else
            CTM_NB_error(iplot) = NaN;
        end
    end
    hold off
    axis([0 1 0 1])
    %
    figure;
    plot(abs(nanmean(reshape(CTM_B_error,6,16))),'red')
    hold on
    plot(abs(nanmean(reshape(CTM_NB_error,6,16))),'green')
    
    PostTest.Error.NB = CTM_NB_error;
    PostTest.Error.B = CTM_B_error;
    
    
    
    %split by accuracy and equate trials
    
    sourcetest_B_cor = {};
    sourcetest_B_inc = {};
    sourcetest_NB_cor = {};
    sourcetest_NB_inc = {};
    
    for itrial = 1:176
        
        if strcmp('B',sourcetest{itrial,9})&&BcorrectHC_source_trials(itrial)==1
            
            sourcetest_B_cor = [sourcetest_B_cor; sourcetest{itrial,2}];
            
        elseif strcmp('B',sourcetest{itrial,9})&&BcorrectHC_source_trials(itrial)==0
            
            sourcetest_B_inc = [sourcetest_B_inc; sourcetest{itrial,2}];
            
        elseif strcmp('NB',sourcetest{itrial,9})&&NBcorrectHC_source_trials(itrial)==1
            
            sourcetest_NB_cor = [sourcetest_NB_cor; sourcetest{itrial,2}];
            
        elseif strcmp('NB',sourcetest{itrial,9})&&NBcorrectHC_source_trials(itrial)==0
            
            sourcetest_NB_inc = [sourcetest_NB_inc; sourcetest{itrial,2}];
            
        end
        
    end
    
    
    
    
    for iBcor = 1:length(sourcetest_B_cor)
        
        Line_Resp_Record(strmatch(sourcetest_B_cor{iBcor},Line_Resp_Record(:,2)),5)={1};
        
    end
    
    for iBinc = 1:length(sourcetest_B_inc)
        
        Line_Resp_Record(strmatch(sourcetest_B_inc{iBinc},Line_Resp_Record(:,2)),5)={0};
        
    end
    
    for iNBcor = 1:length(sourcetest_NB_cor)
        
        Line_Resp_Record(strmatch(sourcetest_NB_cor{iNBcor},Line_Resp_Record(:,2)),5)={1};
        
    end
    
    for iNBinc = 1:length(sourcetest_NB_inc)
        
        Line_Resp_Record(strmatch(sourcetest_NB_inc{iNBinc},Line_Resp_Record(:,2)),5)={0};
        
    end
    
    
    %plot CTM correlation separately for B/NB cor/inc
    CTM_cor_B = [];
    CTM_inc_B = [];
    CTM_cor_NB = [];
    CTM_inc_NB = [];
    CTM_cor_B_stimNames = [];
    CTM_cor_NB_stimNames = [];
    
    for iCTM = 1:length(Line_Resp_Record)
        
        if ~isempty(Line_Resp_Record{iCTM,5})
            
            if strcmp('B',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==1
                
                CTM_cor_B = [CTM_cor_B; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
                CTM_cor_B_stimNames = [CTM_cor_B_stimNames; Line_Resp_Record{iCTM,2} num2cell(Line_Resp_Record{iCTM,4}/576) num2cell(Line_Resp_Record{iCTM,9}) num2cell(Line_Resp_Record{iCTM,4}/576 - Line_Resp_Record{iCTM,9})];
                
            elseif  strcmp('B',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==0
                
                CTM_inc_B = [CTM_inc_B; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
                
            elseif  strcmp('NB',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==1
                
                CTM_cor_NB = [CTM_cor_NB; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
                CTM_cor_NB_stimNames = [CTM_cor_NB_stimNames; Line_Resp_Record{iCTM,2} num2cell(Line_Resp_Record{iCTM,4}/576) num2cell(Line_Resp_Record{iCTM,9}) num2cell(Line_Resp_Record{iCTM,4}/576 - Line_Resp_Record{iCTM,9})];
                
            elseif  strcmp('NB',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==0
                
                CTM_inc_NB = [CTM_inc_NB; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
                
            end
            
        end
        
    end
    
    
    %this was set up to test the hypothesis that faster correct source
    %responses would correlate with better coarse temporal memory.
    %there is a small, but signficant relationship if you combine
    %data
    %across all subjects
    
    for icorr = 1:length(CTM_cor_B_stimNames)
        
        CTM_cor_B_stimNames{icorr,5} = sourcetest{strmatch(CTM_cor_B_stimNames{icorr,1},sourcetest(:,2)),7};
        
    end
    
    for icorr = 1:length(CTM_cor_NB_stimNames)
        
        CTM_cor_NB_stimNames{icorr,5} = sourcetest{strmatch(CTM_cor_NB_stimNames{icorr,1},sourcetest(:,2)),7};
        
    end
    
    
    
    figure;
    subplot(2,2,1)
    scatter(CTM_cor_B(:,1),CTM_cor_B(:,2))
    PostTest.corr.Bcor = corr(CTM_cor_B(:,1),CTM_cor_B(:,2));
    axis([0 1 0 1])
    title('B cor')
    lsline
    
    subplot(2,2,2)
    scatter(CTM_cor_NB(:,1),CTM_cor_NB(:,2))
    PostTest.corr.NBcor = corr(CTM_cor_NB(:,1),CTM_cor_NB(:,2));
    axis([0 1 0 1])
    title('NB cor')
    lsline
    
    subplot(2,2,3)
    scatter(CTM_inc_B(:,1),CTM_inc_B(:,2))
    PostTest.corr.Binc = corr(CTM_inc_B(:,1),CTM_inc_B(:,2));
    axis([0 1 0 1])
    title('B inc')
    lsline
    
    subplot(2,2,4)
    scatter(CTM_inc_NB(:,1),CTM_inc_NB(:,2))
    PostTest.corr.NBinc = corr(CTM_inc_NB(:,1),CTM_inc_NB(:,2));
    axis([0 1 0 1])
    title('NB inc')
    lsline
    
    
    
    %look for changes in performance across the experiment
    Test.Source.AccByBlock = mean(reshape(BcorrectHC_source_trials+BcorrectLC_source_trials+NBcorrectHC_source_trials+NBcorrectLC_source_trials,11,16));
    Test.Order.AccByBlock = mean(reshape(BcorrectHC_order_trials+BcorrectLC_order_trials+NBcorrectHC_order_trials+NBcorrectLC_order_trials,11,16));
    

    %print out CTM figures
    fig6 = figure(6);
    set(fig6, 'Position', [0 0 1000 600])
    print(fig6,'-djpeg', 'CTM.jpeg')
    
    fig7 = figure(7);
    set(fig7, 'Position', [0 0 1000 600])
    print(fig7,'-djpeg', 'CTMbyBlock.jpeg')
    
    fig8 = figure(8);
    set(fig8, 'Position', [0 0 1000 600])
    print(fig8,'-djpeg', 'CTMbyAcc.jpeg')
    
    
    %Boundary RT / Memory Analysis - look to see if the magnitude of the
    %Boundary RT interacts with retrieval RTs and/or memory
    
    noResponse = [];
    
    for iCost = 1:length(EncodingBoundaryTrials)
        
        if isempty(EncodingBoundaryTrials{iCost,4})
            
            noResponse = [noResponse; iCost];
            
        end
        
    end
    
    EncodingBoundaryTrials(noResponse,:) = [];
    
    EncodingBoundaryTrials = EncodingBoundaryTrials(:,[2 5]);
    
    
    for iMatch = 1:length(EncodingBoundaryTrials)
        
        if ~isempty(strmatch(EncodingBoundaryTrials{iMatch,1},ordertest(:,2)))
            
            EncodingBoundaryTrials{iMatch,3} =  ordertest{strmatch(EncodingBoundaryTrials{iMatch,1},ordertest(:,2)),7};
    
            EncodingBoundaryTrials{iMatch,4} =  sourcetest{strmatch(EncodingBoundaryTrials{iMatch,1},sourcetest(:,2)),7};
            
            EncodingBoundaryTrials{iMatch,5} =  BcorrectHC_order_trials(strmatch(EncodingBoundaryTrials{iMatch,1},ordertest(:,2)));
    
            EncodingBoundaryTrials{iMatch,6} =  BcorrectLC_order_trials(strmatch(EncodingBoundaryTrials{iMatch,1},ordertest(:,2)));
            
            EncodingBoundaryTrials{iMatch,7} =  BcorrectHC_source_trials(strmatch(EncodingBoundaryTrials{iMatch,1},sourcetest(:,2)));
            
            EncodingBoundaryTrials{iMatch,8} =  BcorrectLC_source_trials(strmatch(EncodingBoundaryTrials{iMatch,1},sourcetest(:,2)));
            
        end
        
    end
    
    noResponse = [];
    
    for iCost = 1:length(EncodingBoundaryTrials)
        
        if isempty(EncodingBoundaryTrials{iCost,4})
            
            noResponse = [noResponse; iCost];
            
        end
        
    end
    
    EncodingBoundaryTrials(noResponse,:) = [];
    
    [~,Sortidx] = sort(cell2mat(EncodingBoundaryTrials(:,2)));
    
    SortedEncodingBoundaryTrials = EncodingBoundaryTrials(Sortidx,:);
    
    SplitTrials = round(length(SortedEncodingBoundaryTrials)/2);
     
    Encoding.BoundaryEffect.RT = [mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitTrials,2))) mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitTrials,3))) mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitTrials,4))); mean(cell2mat(SortedEncodingBoundaryTrials(SplitTrials+1:end,2))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitTrials+1:end,3))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitTrials+1:end,4)))];
    
    Encoding.BoundaryEffect.Mem.Source.MemHC = [mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitTrials,7))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitTrials+1:end,7)))];
    
    Encoding.BoundaryEffect.Mem.Source.MemLC = [mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitTrials,8))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitTrials+1:end,8)))];
    
    Encoding.BoundaryEffect.Mem.Source.Allhalf = [mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitTrials,7))+cell2mat(SortedEncodingBoundaryTrials(1:SplitTrials,8))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitTrials+1:end,7))+cell2mat(SortedEncodingBoundaryTrials(SplitTrials+1:end,8)))];
     
    Encoding.BoundaryEffect.Mem.Order.MemHC = [mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitTrials,5))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitTrials+1:end,5)))];
    
    Encoding.BoundaryEffect.Mem.Order.MemLC = [mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitTrials,6))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitTrials+1:end,6)))];
    
    Encoding.BoundaryEffect.Mem.Order.Allhalf = [mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitTrials,5))+cell2mat(SortedEncodingBoundaryTrials(1:SplitTrials,6))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitTrials+1:end,5))+cell2mat(SortedEncodingBoundaryTrials(SplitTrials+1:end,6)))];
    
    
    
    SplitThirds1 = round(length(SortedEncodingBoundaryTrials)/3);
    
    SplitThirds2 = round((length(SortedEncodingBoundaryTrials)/3)*2);
     
    Encoding.BoundaryEffect.Mem.Source.Allthirds = [mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitThirds1,7))+cell2mat(SortedEncodingBoundaryTrials(1:SplitThirds1,8))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitThirds1+1:SplitThirds2,7))+cell2mat(SortedEncodingBoundaryTrials(SplitThirds1+1:SplitThirds2,8))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitThirds2+1:end,7))+cell2mat(SortedEncodingBoundaryTrials(SplitThirds2+1:end,8)))];

    Encoding.BoundaryEffect.Mem.Order.Allthirds = [mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitThirds1,5))+cell2mat(SortedEncodingBoundaryTrials(1:SplitThirds1,6))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitThirds1+1:SplitThirds2,5))+cell2mat(SortedEncodingBoundaryTrials(SplitThirds1+1:SplitThirds2,6))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitThirds2+1:end,5))+cell2mat(SortedEncodingBoundaryTrials(SplitThirds2+1:end,6)))];
    
    
    SplitQuarters1 = round(length(SortedEncodingBoundaryTrials)/4);
    
    SplitQuarters2 = round((length(SortedEncodingBoundaryTrials)/4)*2);
    
    SplitQuarters3 = round((length(SortedEncodingBoundaryTrials)/4)*3);
     
    Encoding.BoundaryEffect.Mem.Source.Allquarters = [mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitQuarters1,7))+cell2mat(SortedEncodingBoundaryTrials(1:SplitQuarters1,8))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitQuarters1+1:SplitQuarters2,7))+cell2mat(SortedEncodingBoundaryTrials(SplitQuarters1+1:SplitQuarters2,8))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitQuarters2+1:SplitQuarters3,7))+cell2mat(SortedEncodingBoundaryTrials(SplitQuarters2+1:SplitQuarters3,8))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitQuarters3+1:end,7))+cell2mat(SortedEncodingBoundaryTrials(SplitQuarters3+1:end,8)))];

    Encoding.BoundaryEffect.Mem.Order.Allquarters = [mean(cell2mat(SortedEncodingBoundaryTrials(1:SplitQuarters1,5))+cell2mat(SortedEncodingBoundaryTrials(1:SplitQuarters1,6))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitQuarters1+1:SplitQuarters2,5))+cell2mat(SortedEncodingBoundaryTrials(SplitQuarters1+1:SplitQuarters2,6))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitQuarters2+1:SplitQuarters3,5))+cell2mat(SortedEncodingBoundaryTrials(SplitQuarters2+1:SplitQuarters3,6))) mean(cell2mat(SortedEncodingBoundaryTrials(SplitQuarters3+1:end,5))+cell2mat(SortedEncodingBoundaryTrials(SplitQuarters3+1:end,6)))];

    %Order memory contingent on getting source correct
    Test.Order.IFSourceHCCorrect = mean(cell2mat(SortedEncodingBoundaryTrials(logical(cell2mat(SortedEncodingBoundaryTrials(:,7))),5))+cell2mat(SortedEncodingBoundaryTrials(logical(cell2mat(SortedEncodingBoundaryTrials(:,7))),6)));
    Test.Order.IFSourceLCIncorrect = mean(cell2mat(SortedEncodingBoundaryTrials(~logical(cell2mat(SortedEncodingBoundaryTrials(:,7))),5))+cell2mat(SortedEncodingBoundaryTrials(~logical(cell2mat(SortedEncodingBoundaryTrials(:,7))),6)));
    
    data.Encoding = Encoding;
    data.Test = Test;
    data.PostTest = PostTest;
    
    save data data
    
    cd ../../
    close('all')
    
    
end

cd /Volumes/davachilab/MEGbound/scripts/

end



