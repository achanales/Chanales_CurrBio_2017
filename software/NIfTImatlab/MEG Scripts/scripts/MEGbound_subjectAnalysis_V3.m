function data = MEGbound_subjectAnalysis(sub,omitBlocks)

for isub = 1:length(sub)
    
    cd(['/Volumes/davachilab/MEGbound/Data/' sub{isub}])
    
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
    
    test = [];
    
    for iblock = blocks
        
        load(['testDataFileSub' sub{isub} 'Block' num2str(iblock)]);
        
        sourcetest = [test; testDataFile(2:4,:)];
        
        
    end
    
    TO_new_trials = [];
    new_trial_idx = zeros(length(test),1);
    miss_TO_item = [];
    rm_trial_idx = zeros(length(test),1);
    
    for inew = 1:length(test)
        
        if strcmp(' ',test(inew,3))
            
            TO_new_trials = [TO_new_trials; test(inew,:)];
            new_trial_idx(inew) = 1;
            rm_trial_idx(inew) = 1;
            
        elseif isempty(test{inew,3})
            
            new_trial_idx(inew) = 1;
            rm_trial_idx(inew) = 1;
            
        elseif test{inew,8}=='l'
        
            
            miss_TO_item(inew) = 1;
            %rm_trial_idx(inew) = 1;
            %rm_trial_idx(inew+1) = 1;
            
        elseif strcmp(test{inew,8},';:')
                miss_TO_item(inew) = 1;
                
        end
        
    end
    
    test(logical(rm_trial_idx),:)=[];
    
    %old_new_test = test(logical(repmat([1;0],length(test)/2,1)),:);
    %TO_test = test(logical(repmat([0;1],length(test)/2,1)),:);
    
    
    % Old/new accuracy
    

    
    num_B_trials = 0;
    num_NB_trials = 0;
    
    for itrial = 1:length(test)
        
        if strcmp('B',test{itrial,9})&&test{itrial,11}==1&&(strcmp('j',test{itrial,8})||strcmp('k',test{itrial,8}))
            
            num_B_trials=num_B_trials+1;
            
        end
        
        if strcmp('NB',test{itrial,9})&&test{itrial,11}==1&&(strcmp('j',test{itrial,8})||strcmp('k',test{itrial,8}))
            
            num_NB_trials=num_NB_trials+1;
            
        end
    end
    
    
 B_acc_vec = [];
 NB_acc_vec = [];
 B_CR_vec = [];
 NB_CR_vec = [];
    
    for itrial = 1:length(test)
        
        if strcmp('j',test{itrial,8})&&strcmp('B',test{itrial,9})&&test{itrial,11}==1
            
            B_acc_vec=[B_acc_vec; itrial];
            
        end
        
        if strcmp('k',test{itrial,8})&&strcmp('B',test{itrial,9})&&test{itrial,11}==0
            
            B_CR_vec=[B_CR_vec; itrial];
            
        end
       
        
        if strcmp('j',test{itrial,8})&&strcmp('NB',test{itrial,9})&&test{itrial,11}==1
            
            NB_acc_vec=[NB_acc_vec; itrial];
            
        end
        
        if strcmp('k',test{itrial,8})&&strcmp('NB',test{itrial,9})&&test{itrial,11}==0
            
            NB_CR_vec=[NB_CR_vec; itrial];
            
        end
    end
    
    Test.Neighbor.Acc.B = length(B_acc_vec)/num_B_trials;
    Test.Neighbor.Acc.NB = length(NB_acc_vec)/num_NB_trials;
    Test.Neighbor.FA.B = 1-length(B_CR_vec)/16;
    Test.Neighbor.FA.NB = 1-length(NB_CR_vec)/16;
%    Test.OldNew.Acc.all = old_new_acc_vec;
    
    % Temporal order accuracy
    
    TO_acc_vec = zeros(length(test),1);
    
    for itrial = 1:length(test)
        
        if strcmp('j',test{itrial,8})&&test{itrial,11}==1
            
            TO_acc_vec(itrial)=1;
            
        elseif strcmp('k',test{itrial,8})&&test{itrial,11}==0
            
            TO_acc_vec(itrial)=1;
            
        elseif strcmp('l',test{itrial,8})
            
            TO_acc_vec(itrial)=99;
            
        elseif strcmp(';:',test{itrial,8})
            
            TO_acc_vec(itrial)=99;
            
        end
        
    end
    

    
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
    bar([Test.Neighbor.Acc.B Test.Neighbor.Acc.NB Test.Neighbor.FA.B Test.Neighbor.FA.NB])
    conditions = {'Boundary Acc','Non-Boundary Acc','Boundary FA','Non-Boundary FA'};
    set(gca,'xTickLabel',conditions,'FontSize',12);
    ylabel('Accuracy (proportion correct)','FontSize',20);
    title('Accuracy by Condition','FontSize',20)
    axis([0 5 0 1])  
%     figure
%     bar([mean(Test.TO.RT.B.correct(Test.TO.RT.B.correct<3*std(Test.TO.RT.B.correct))) mean(Test.TO.RT.B.incorrect(Test.TO.RT.B.incorrect<3*std(Test.TO.RT.B.incorrect))) mean(Test.TO.RT.NB.correct(Test.TO.RT.NB.correct<3*std(Test.TO.RT.NB.correct))) mean(Test.TO.RT.NB.incorrect(Test.TO.RT.NB.incorrect<3*std(Test.TO.RT.NB.incorrect)))])
%     conditions = {'Boundary Correct','Boundary Incorrect','Non-Boundary Correct','Non-Boundary Incorrect'};
%     set(gca,'xTickLabel',conditions,'FontSize',12);
%     ylabel('Response Time (seconds)','FontSize',20);
%     title('Response Time at Retrieval by Condition','FontSize',20)
%     hold on
%     errorbar([mean(Test.TO.RT.B.correct(Test.TO.RT.B.correct<3*std(Test.TO.RT.B.correct))) mean(Test.TO.RT.B.incorrect(Test.TO.RT.B.incorrect<3*std(Test.TO.RT.B.incorrect))) mean(Test.TO.RT.NB.correct(Test.TO.RT.NB.correct<3*std(Test.TO.RT.NB.correct))) mean(Test.TO.RT.NB.incorrect(Test.TO.RT.NB.incorrect<3*std(Test.TO.RT.NB.incorrect)))],...
%         [std(Test.TO.RT.B.correct(Test.TO.RT.B.correct<3*std(Test.TO.RT.B.correct))) std(Test.TO.RT.B.incorrect(Test.TO.RT.B.incorrect<3*std(Test.TO.RT.B.incorrect))) std(Test.TO.RT.NB.correct(Test.TO.RT.NB.correct<3*std(Test.TO.RT.NB.correct))) std(Test.TO.RT.NB.incorrect(Test.TO.RT.NB.incorrect<3*std(Test.TO.RT.NB.incorrect)))],'*')
%     
%     %Post test
%     
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
        
        if sorted_estimated_B(iplot)<1
        plot([sorted_B(iplot) sorted_B(iplot)],[sorted_B(iplot) sorted_estimated_B(iplot)])
        CTM_B_error(iplot) = sorted_B(iplot) - sorted_estimated_B(iplot);
        end
        
    end
    hold off  
    
    
    subplot(2,2,4) 
    
    hold on
    for iplot = 1:length(PostTest.Acc.NB(:,1))
        
        if sorted_estimated_NB(iplot)<1
        plot([sorted_NB(iplot) sorted_NB(iplot)],[sorted_NB(iplot) sorted_estimated_NB(iplot)])
        CTM_NB_error(iplot) = sorted_NB(iplot) - sorted_estimated_NB(iplot);
        end
    end
    hold off  
    
    figure; 
    plot(abs(mean(reshape(CTM_B_error,6,16))),'red')
    hold on
    plot(abs(mean(reshape(CTM_NB_error,6,16))),'green')
    
    PostTest.Error.NB = CTM_NB_error;
    PostTest.Error.B = CTM_B_error;
    
    
    
    %split by accuracy and equate trials
    
%     TO_test_B_cor = {};
%     TO_test_B_inc = {};
%     TO_test_NB_cor = {};
%     TO_test_NB_inc = {};
%     
%     for itrial = 1:length(TO_test)
%         
%         if strcmp('B',TO_test{itrial,9})&&TO_acc_vec(itrial)==1
%             
%             TO_test_B_cor = [TO_test_B_cor; TO_test{itrial,3}];
%             
%         elseif strcmp('B',TO_test{itrial,9}) && TO_acc_vec(itrial)==0
%             
%             TO_test_B_inc = [TO_test_B_inc; TO_test{itrial,3}];
%             
%         elseif strcmp('NB',TO_test{itrial,9}) && TO_acc_vec(itrial)==1
%             
%             TO_test_NB_cor = [TO_test_NB_cor; TO_test{itrial,3}];
%             
%         elseif strcmp('NB',TO_test{itrial,9}) && TO_acc_vec(itrial)==0
%             
%             TO_test_NB_inc = [TO_test_NB_inc; TO_test{itrial,3}];
%             
%         end
%         
%     end
%     
%     
%     
%     
%     for iBcor = 1:length(TO_test_B_cor)
%         
%         Line_Resp_Record(strmatch(TO_test_B_cor{iBcor},Line_Resp_Record(:,2)),5)={1};
%         
%     end
%     
%     for iBinc = 1:length(TO_test_B_inc)
%         
%         Line_Resp_Record(strmatch(TO_test_B_inc{iBinc},Line_Resp_Record(:,2)),5)={0};
%         
%     end
%     
%     for iNBcor = 1:length(TO_test_NB_cor)
%         
%         Line_Resp_Record(strmatch(TO_test_NB_cor{iNBcor},Line_Resp_Record(:,2)),5)={1};
%         
%     end
%     
%     for iNBinc = 1:length(TO_test_NB_inc)
%         
%         Line_Resp_Record(strmatch(TO_test_NB_inc{iNBinc},Line_Resp_Record(:,2)),5)={0};
%         
%     end
%     
%     
%     %plot CTM correlation separately for B/NB cor/inc
%     CTM_cor_B = [];
%     CTM_inc_B = [];
%     CTM_cor_NB = [];
%     CTM_inc_NB = [];
%     
%     for iCTM = 1:length(Line_Resp_Record)
%         
%         if ~isempty(Line_Resp_Record{iCTM,5})
%             
%             if strcmp('B',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==1
%                 
%                 CTM_cor_B = [CTM_cor_B; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
%                 
%             elseif  strcmp('B',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==0
%                 
%                 CTM_inc_B = [CTM_inc_B; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
%                 
%             elseif  strcmp('NB',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==1
%                 
%                 CTM_cor_NB = [CTM_cor_NB; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
%                 
%             elseif  strcmp('NB',Line_Resp_Record(iCTM,3)) && Line_Resp_Record{iCTM,5}==0
%                 
%                 CTM_inc_NB = [CTM_inc_NB; Line_Resp_Record{iCTM,4}/576 Line_Resp_Record{iCTM,9}];
%                 
%             end
%             
%         end
%         
%     end
%     
%     figure;
%     subplot(2,2,1)
%     scatter(CTM_cor_B(:,1),CTM_cor_B(:,2))
%     PostTest.corr.Bcor = corr(CTM_cor_B(:,1),CTM_cor_B(:,2));
%     axis([0 1 0 1])
%     title('B cor')
%     lsline
%     
%     subplot(2,2,2)
%     scatter(CTM_cor_NB(:,1),CTM_cor_NB(:,2))
%     PostTest.corr.NBcor = corr(CTM_cor_NB(:,1),CTM_cor_NB(:,2));
%     axis([0 1 0 1])
%     title('NB cor')
%     lsline
%     
%     subplot(2,2,3)
%     scatter(CTM_inc_B(:,1),CTM_inc_B(:,2))
%     PostTest.corr.Binc = corr(CTM_inc_B(:,1),CTM_inc_B(:,2));
%     axis([0 1 0 1])
%     title('B inc')
%     lsline
%     
%     subplot(2,2,4)
%     scatter(CTM_inc_NB(:,1),CTM_inc_NB(:,2))
%     PostTest.corr.NBinc = corr(CTM_inc_NB(:,1),CTM_inc_NB(:,2));
%     axis([0 1 0 1])
%     title('NB inc')
%     lsline
%     
    
    
           
    
 data.Encoding = Encoding;
data.Test = Test;
data.PostTest = PostTest;

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
print(fig4,'-djpeg', 'TORTs.jpeg')

fig5 = figure(5);
set(fig5, 'Position', [0 0 1000 600])
print(fig5,'-djpeg', 'CTM.jpeg')

% fig7 = figure(7);
% set(fig7, 'Position', [0 0 1000 600])
% print(fig7,'-djpeg', 'CTMbyAcc.jpeg')


cd ../../
close('all')   
    
    
end



cd /Volumes/davachilab/MEGbound/scripts/

end

