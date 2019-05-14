function data = MEGbound_subjectAnalysis(sub,omitBlocks)

for isub = 1:length(sub)
    
    cd(['/Volumes/davachilab/MEGbound/Data/V4/' sub{isub}])
    
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
    
    for iRTs = 1:length(encoding)
        
        if strcmp('B',encoding{iRTs,7})
            
            Encoding.RT.B = [Encoding.RT.B; cell2mat(encoding(iRTs,5))];
            
        elseif strcmp('NB',encoding{iRTs,7})
            
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
    
    
    
    
    % Temporal order test
    
    sourcetest = [];
    ordertest = [];
    for iblock = blocks
        
        load(['testDataFileSub' sub{isub} 'Block' num2str(iblock)]);
        
        sourcetest = [sourcetest; testDataFile(2:4,:)];
        ordertest = [ordertest; testDataFile(5:15,:)];
        
        
    end
    
    
    
    
    Bcorrect_source_trials = zeros(48,1);
    NBcorrect_source_trials = zeros(48,1);
    Bincorrect_source_trials = zeros(48,1);
    NBincorrect_source_trials = zeros(48,1);
    
    for itrial = 1:length(sourcetest)
        
        if strcmp('B',sourcetest{itrial,9})&&(sourcetest{itrial,11}==0&&(strcmp('j',sourcetest{itrial,8}))||sourcetest{itrial,11}==1&&(strcmp('k',sourcetest{itrial,8})))
            
            Bcorrect_source_trials(itrial) = 1;
            
        end
        
        if strcmp('B',sourcetest{itrial,9})&&(sourcetest{itrial,11}==1&&(strcmp('j',sourcetest{itrial,8}))||sourcetest{itrial,11}==0&&(strcmp('k',sourcetest{itrial,8})))
            
            Bincorrect_source_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',sourcetest{itrial,9})&&(sourcetest{itrial,11}==0&&(strcmp('j',sourcetest{itrial,8}))||sourcetest{itrial,11}==1&&(strcmp('k',sourcetest{itrial,8})))
            
            NBcorrect_source_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',sourcetest{itrial,9})&&(sourcetest{itrial,11}==1&&(strcmp('j',sourcetest{itrial,8}))||sourcetest{itrial,11}==0&&(strcmp('k',sourcetest{itrial,8})))
            
            NBincorrect_source_trials(itrial) = 1;
            
        end
        
    end
    
    Bsource_acc = sum(Bcorrect_source_trials)/(length(blocks)*1);
    NBsource_acc = sum(NBcorrect_source_trials)/(length(blocks)*2);
    
    
    
    Bcorrect_order_trials = zeros(176,1);
    NBcorrect_order_trials = zeros(176,1);
    Bincorrect_order_trials = zeros(176,1);
    NBincorrect_order_trials = zeros(176,1);
    
    
    for itrial = 1:length(ordertest)
        
        if strcmp('B',ordertest{itrial,9})&&(ordertest{itrial,11}==0&&(strcmp('j',ordertest{itrial,8}))||(ordertest{itrial,11}==1&&(strcmp('k',ordertest{itrial,8}))))
            
            Bcorrect_order_trials(itrial) = 1;
            
        end
        
        if strcmp('B',ordertest{itrial,9})&&(ordertest{itrial,11}==1&&(strcmp('j',ordertest{itrial,8}))||(ordertest{itrial,11}==0&&(strcmp('k',ordertest{itrial,8}))))
            
            Bincorrect_order_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',ordertest{itrial,9})&&(ordertest{itrial,11}==0&&(strcmp('j',ordertest{itrial,8}))||(ordertest{itrial,11}==1&&(strcmp('k',ordertest{itrial,8}))))
            
            NBcorrect_order_trials(itrial) = 1;
            
        end
        
        if strcmp('NB',ordertest{itrial,9})&&(ordertest{itrial,11}==1&&(strcmp('j',ordertest{itrial,8}))||(ordertest{itrial,11}==0&&(strcmp('k',ordertest{itrial,8}))))
            
            NBincorrect_order_trials(itrial) = 1;
            
        end
    end
    
    Border_acc = sum(Bcorrect_order_trials)/(length(blocks)*5);
    NBorder_acc = sum(NBcorrect_order_trials)/(length(blocks)*6);
    
    
    %test for primacy effects
    
    for itest = 1:length(ordertest)
        
        for itest2 = 1:length(encoding)
        temp(itest2) = strcmp(ordertest(itest,2),encoding{itest2,2});
        end
        
        position(itest) = encoding{find(temp),1};
        clear temp
    end
    
    [sorted_position sorted_idx] = sort(position);
    
    Btest =[sorted_position' Bcorrect_order_trials(sorted_idx)];
    Btest = mean(reshape(Btest([17:32 49:64 81:96 113:128 145:160],2),16,5)); 
    
    NBtest =[sorted_position' NBcorrect_order_trials(sorted_idx)];
    NBtest = mean(reshape(NBtest([1:16 33:48 65:80 97:112 129:144 161:176],2),16,6));    
    
    
    Test.Source.Acc.B = Bsource_acc;
    Test.Source.Acc.NB = NBsource_acc;
    Test.Order.Acc.B = Border_acc;
    Test.Order.Acc.NB = NBorder_acc;
    
    Test.Source.RT.Bcor = cell2mat(sourcetest(logical(Bcorrect_source_trials),7));
    Test.Source.RT.NBcor = cell2mat(sourcetest(logical(NBcorrect_source_trials),7));
    Test.Order.RT.Bcor = cell2mat(ordertest(logical(Bcorrect_order_trials),7));
    Test.Order.RT.NBcor = cell2mat(ordertest(logical(NBcorrect_order_trials),7));
    
    Test.Source.RT.Binc = cell2mat(sourcetest(logical(Bincorrect_source_trials),7));
    Test.Source.RT.NBinc = cell2mat(sourcetest(logical(NBincorrect_source_trials),7));
    Test.Order.RT.Binc = cell2mat(ordertest(logical(Bincorrect_order_trials),7));
    Test.Order.RT.NBinc = cell2mat(ordertest(logical(NBincorrect_order_trials),7));
    
    
    %     Test.TO.Acc.all = TO_acc_vec;
    %     Test.TO.Acc.B.correct = [];
    %     Test.TO.Acc.B.incorrect = [];
    %     Test.TO.Acc.NB.correct = [];
    %     Test.TO.Acc.NB.incorrect = [];
    %     Test.TO.RT.B.correct = [];
    %     Test.TO.RT.B.incorrect = [];
    %     Test.TO.RT.NB.correct = [];
    %     Test.TO.RT.NB.incorrect = [];
    %
    %     for itrial = 1:length(TO_test)
    %
    %         if strcmp('B',TO_test{itrial,9})&&Test.TO.Acc.all(itrial)==1
    %
    %             Test.TO.Acc.B.correct=[Test.TO.Acc.B.correct; 1];
    %             Test.TO.RT.B.correct= [Test.TO.RT.B.correct; TO_test{itrial,7}];
    %
    %         elseif strcmp('B',TO_test{itrial,9})&&Test.TO.Acc.all(itrial)==0
    %
    %             Test.TO.Acc.B.incorrect=[Test.TO.Acc.B.incorrect; 0];
    %             Test.TO.RT.B.incorrect= [Test.TO.RT.B.incorrect; TO_test{itrial,7}];
    %
    %         elseif strcmp('NB',TO_test{itrial,9})&&Test.TO.Acc.all(itrial)==1
    %
    %             Test.TO.Acc.NB.correct=[Test.TO.Acc.NB.correct; 1];
    %             Test.TO.RT.NB.correct= [Test.TO.RT.NB.correct; TO_test{itrial,7}];
    %
    %         elseif strcmp('NB',TO_test{itrial,9})&&Test.TO.Acc.all(itrial)==0
    %
    %             Test.TO.Acc.NB.incorrect=[Test.TO.Acc.NB.incorrect; 0];
    %             Test.TO.RT.NB.incorrect= [Test.TO.RT.NB.incorrect; TO_test{itrial,7}];
    %         end
    %     end
    %
    %     TO_B_Acc = length(Test.TO.Acc.B.correct)/(length(Test.TO.Acc.B.correct)+length(Test.TO.Acc.B.incorrect));
    %     TO_NB_Acc = length(Test.TO.Acc.NB.correct)/(length(Test.TO.Acc.NB.correct)+length(Test.TO.Acc.NB.incorrect));
    % %
    figure
    bar([Test.Source.Acc.B Test.Source.Acc.NB Test.Order.Acc.B Test.Order.Acc.NB])
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
   
    %Post test
    load(['MEGBound_PostTest_behav_data_s' sub{isub}]);
    
    
    PostTest.Acc.B = [];
    PostTest.Acc.NB = [];
    PostTest.RTs.B = [];
    PostTest.RTs.NB = [];
    
    Line_Resp_Record(:,3) = postTestSeq(:,2);
    
    Line_Resp_Record(:,4) = postTestSeq(:,8);
    
    for itrial = 1:length(Line_Resp_Record)
        
        if strcmp('B',Line_Resp_Record{itrial,3})
            
            PostTest.Acc.B = [PostTest.Acc.B; cell2mat(Line_Resp_Record(itrial,4))/576 cell2mat(Line_Resp_Record(itrial,9)) ];
            PostTest.RTs.B = [PostTest.RTs.B; cell2mat(Line_Resp_Record(itrial,11))];
            
        elseif strcmp('NB',Line_Resp_Record{itrial,3})
            
            PostTest.Acc.NB = [PostTest.Acc.NB; cell2mat(Line_Resp_Record(itrial,4))/576 cell2mat(Line_Resp_Record(itrial,9)) ];
            PostTest.RTs.NB = [PostTest.RTs.NB; cell2mat(Line_Resp_Record(itrial,11))];
        end
        
    end
    
    PostTest.corr.B = corr(PostTest.Acc.B(:,1),PostTest.Acc.B(:,2));
    PostTest.corr.NB = corr(PostTest.Acc.NB(:,1),PostTest.Acc.NB(:,2));
    
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
        
        %if sorted_estimated_B(iplot)<1
            plot([sorted_B(iplot) sorted_B(iplot)],[sorted_B(iplot) sorted_estimated_B(iplot)])
            CTM_B_error(iplot) = sorted_B(iplot) - sorted_estimated_B(iplot);
        %end
        
    end
    hold off
    
    
    subplot(2,2,4)
    
    hold on
    for iplot = 1:length(PostTest.Acc.NB(:,1))
        
        %if sorted_estimated_NB(iplot)<1
            plot([sorted_NB(iplot) sorted_NB(iplot)],[sorted_NB(iplot) sorted_estimated_NB(iplot)])
            CTM_NB_error(iplot) = sorted_NB(iplot) - sorted_estimated_NB(iplot);
        %end
    end
    hold off
    
    figure;
    plot(abs(mean(reshape(CTM_B_error,6,16))),'red')
    hold on
    plot(abs(mean(reshape(CTM_NB_error,6,16))),'green')
    
    PostTest.Error.NB = CTM_NB_error;
    PostTest.Error.B = CTM_B_error;
    
    
    
%     %split by accuracy and equate trials
%     
%         TO_test_B_cor = {};
%         TO_test_B_inc = {};
%         TO_test_NB_cor = {};
%         TO_test_NB_inc = {};
%     
%         for itrial = 1:length(TO_test)
%     
%             if strcmp('B',TO_test{itrial,9})&&Bcorrect_source_trials(itrial)==1
%     
%                 TO_test_B_cor = [TO_test_B_cor; TO_test{itrial,3}];
%     
%             elseif strcmp('B',TO_test{itrial,9}) && TO_acc_vec(itrial)==0
%     
%                 TO_test_B_inc = [TO_test_B_inc; TO_test{itrial,3}];
%     
%             elseif strcmp('NB',TO_test{itrial,9}) && TO_acc_vec(itrial)==1
%     
%                 TO_test_NB_cor = [TO_test_NB_cor; TO_test{itrial,3}];
%     
%             elseif strcmp('NB',TO_test{itrial,9}) && TO_acc_vec(itrial)==0
%     
%                 TO_test_NB_inc = [TO_test_NB_inc; TO_test{itrial,3}];
%     
%             end
%     
%         end
%     
%     
%     
%     
%         for iBcor = 1:length(TO_test_B_cor)
%     
%             Line_Resp_Record(strmatch(TO_test_B_cor{iBcor},Line_Resp_Record(:,2)),5)={1};
%     
%         end
%     
%         for iBinc = 1:length(TO_test_B_inc)
%     
%             Line_Resp_Record(strmatch(TO_test_B_inc{iBinc},Line_Resp_Record(:,2)),5)={0};
%     
%         end
%     
%         for iNBcor = 1:length(TO_test_NB_cor)
%     
%             Line_Resp_Record(strmatch(TO_test_NB_cor{iNBcor},Line_Resp_Record(:,2)),5)={1};
%     
%         end
%     
%         for iNBinc = 1:length(TO_test_NB_inc)
%     
%             Line_Resp_Record(strmatch(TO_test_NB_inc{iNBinc},Line_Resp_Record(:,2)),5)={0};
%     
%         end
%     
%     
%         %plot CTM correlation separately for B/NB cor/inc
%         CTM_cor_B = [];
%         CTM_inc_B = [];
%         CTM_cor_NB = [];
%         CTM_inc_NB = [];
%     
%         for iCTM = 1:length(Line_Resp_Record)
%     
%             if ~isempty(Line_Resp_Record{iCTM,5})
%     
%                 if strcmp('B',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==1
%     
%                     CTM_cor_B = [CTM_cor_B; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
%     
%                 elseif  strcmp('B',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==0
%     
%                     CTM_inc_B = [CTM_inc_B; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
%     
%                 elseif  strcmp('NB',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==1
%     
%                     CTM_cor_NB = [CTM_cor_NB; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
%     
%                 elseif  strcmp('NB',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==0
%     
%                     CTM_inc_NB = [CTM_inc_NB; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
%     
%                 end
%     
%             end
%     
%         end
%     
%         figure;
%         subplot(2,2,1)
%         scatter(CTM_cor_B(:,1),CTM_cor_B(:,2))
%         PostTest.corr.Bcor = corr(CTM_cor_B(:,1),CTM_cor_B(:,2));
%         axis([0 1 0 1])
%         title('B cor')
%         lsline
%     
%         subplot(2,2,2)
%         scatter(CTM_cor_NB(:,1),CTM_cor_NB(:,2))
%         PostTest.corr.NBcor = corr(CTM_cor_NB(:,1),CTM_cor_NB(:,2));
%         axis([0 1 0 1])
%         title('NB cor')
%         lsline
%     
%         subplot(2,2,3)
%         scatter(CTM_inc_B(:,1),CTM_inc_B(:,2))
%         PostTest.corr.Binc = corr(CTM_inc_B(:,1),CTM_inc_B(:,2));
%         axis([0 1 0 1])
%         title('B inc')
%         lsline
%     
%         subplot(2,2,4)
%         scatter(CTM_inc_NB(:,1),CTM_inc_NB(:,2))
%         PostTest.corr.NBinc = corr(CTM_inc_NB(:,1),CTM_inc_NB(:,2));
%         axis([0 1 0 1])
%         title('NB inc')
%         lsline
%     
    
    
    
    
    data.Encoding = Encoding;
    data.Test = Test;
    data.PostTest = PostTest;
    data.OrderEffects.B = Btest;
    data.OrderEffects.NB = NBtest;
    
    save data data
    
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
    
     fig6 = figure(6);
     set(fig6, 'Position', [0 0 1000 600])
     print(fig6,'-djpeg', 'CTM.jpeg')
    
     fig7 = figure(7);
     set(fig7, 'Position', [0 0 1000 600])
     print(fig7,'-djpeg', 'CTMbyBlock.jpeg')     
    
    cd ../../
    close('all')
    
    
end



cd /Volumes/davachilab/MEGbound/scripts/

end

