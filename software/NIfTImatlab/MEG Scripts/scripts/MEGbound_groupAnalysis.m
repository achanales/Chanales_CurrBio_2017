function GroupData = MEGbound_groupAnalysis(sub,groupDir,saveOut)

for isub = 1:length(sub)
    
    load(['/Volumes/davachilab/MEGbound/Data/V6/' sub{isub} '/data.mat'])
    eval(['data_s' sub{isub} '=data;'])
    
end

for isub = 1:length(sub)
    
    %encoding RTs
    eval(['GroupData.Encoding.RT.B(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Encoding.RT.B);'])
    eval(['GroupData.Encoding.RT.NB(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Encoding.RT.NB);'])
    
    %by position
    eval(['GroupData.Encoding.RTs.pos1(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Encoding.RTs.pos1);'])
    eval(['GroupData.Encoding.RTs.pos2(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Encoding.RTs.pos2);'])
    eval(['GroupData.Encoding.RTs.pos3(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Encoding.RTs.pos3);'])
    eval(['GroupData.Encoding.RTs.pos4(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Encoding.RTs.pos4);'])
    eval(['GroupData.Encoding.RTs.pos5(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Encoding.RTs.pos5);'])
    eval(['GroupData.Encoding.RTs.pos6(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Encoding.RTs.pos6);'])
    
    %test source
    eval(['GroupData.Test.Source.Acc.B(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.Acc.B);'])
    eval(['GroupData.Test.Source.Acc.NB(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.Acc.NB);'])
    
    %test source HC
    eval(['GroupData.Test.Source.Acc.B_HC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.Acc.B_HC_WC);'])
    eval(['GroupData.Test.Source.Acc.NB_HC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.Acc.NB_HC_WC);'])
    
    %test source LC
    eval(['GroupData.Test.Source.Acc.B_LC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.Acc.B_LC_WC);'])
    eval(['GroupData.Test.Source.Acc.NB_LC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.Acc.NB_LC_WC);'])
    
    %test order
    eval(['GroupData.Test.Order.Acc.B(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.Acc.B);'])
    eval(['GroupData.Test.Order.Acc.NB(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.Acc.NB);'])
    
    %test order HC
    eval(['GroupData.Test.Order.Acc.B_HC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.Acc.B_HC_WC);'])
    eval(['GroupData.Test.Order.Acc.NB_HC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.Acc.NB_HC_WC);'])
    
    %test order LC
    eval(['GroupData.Test.Order.Acc.B_LC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.Acc.B_LC_WC);'])
    eval(['GroupData.Test.Order.Acc.NB_LC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.Acc.NB_LC_WC);'])
    
    %test source RTs correct
    eval(['GroupData.Test.Source.RT.B.correct(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.RT.Bcor);'])
    eval(['GroupData.Test.Source.RT.NB.correct(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.RT.NBcor);'])
    eval(['GroupData.Test.Source.RT.B.incorrect(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.RT.Binc);'])
    eval(['GroupData.Test.Source.RT.NB.incorrect(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.RT.NBinc);'])
    eval(['GroupData.Test.Source.RT.B.correctHC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.RT.Bcor_HC_cleaned);'])
    eval(['GroupData.Test.Source.RT.NB.correctHC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Source.RT.NBcor_HC_cleaned);'])
    
    %test order RTs incorrect
    eval(['GroupData.Test.Order.RT.B.correct(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.RT.Bcor);'])
    eval(['GroupData.Test.Order.RT.NB.correct(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.RT.NBcor);'])
    eval(['GroupData.Test.Order.RT.B.incorrect(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.RT.Binc);'])
    eval(['GroupData.Test.Order.RT.NB.incorrect(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.RT.NBinc);'])
    eval(['GroupData.Test.Order.RT.B.correctHC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.RT.Bcor_HC_cleaned);'])
    eval(['GroupData.Test.Order.RT.NB.correctHC(' num2str(isub) ')=nanmean(data_s' sub{isub} '.Test.Order.RT.NBcor_HC_cleaned);'])
    
    %     %post test coarse temporal memory error
    eval(['GroupData.PostTest.Error.B(' num2str(isub) ',:)=data_s' sub{isub} '.PostTest.Error.B;'])
    eval(['GroupData.PostTest.Error.NB(' num2str(isub) ',:)=data_s' sub{isub} '.PostTest.Error.NB;'])
    
    %eval(['GroupData.OrderEffects.B(' num2str(isub) ',:)=data_s' sub{isub} '.OrderEffects.B;'])
    %eval(['GroupData.OrderEffects.NB(' num2str(isub) ',:)=data_s' sub{isub} '.OrderEffects.NB;'])
    
    
    %     %post test coarse temporal memory correlation
    eval(['GroupData.PostTest.corr.B(' num2str(isub) ')=data_s' sub{isub} '.PostTest.corr.B;'])
    eval(['GroupData.PostTest.corr.NB(' num2str(isub) ')=data_s' sub{isub} '.PostTest.corr.NB;'])
    %
    %     %post test coarse temporal memory by accuracy
    eval(['GroupData.PostTest.corr.Bcor(' num2str(isub) ')=data_s' sub{isub} '.PostTest.corr.Bcor;'])
    eval(['GroupData.PostTest.corr.NBcor(' num2str(isub) ')=data_s' sub{isub} '.PostTest.corr.NBcor;'])
    eval(['GroupData.PostTest.corr.Binc(' num2str(isub) ')=data_s' sub{isub} '.PostTest.corr.Binc;'])
    eval(['GroupData.PostTest.corr.NBinc(' num2str(isub) ')=data_s' sub{isub} '.PostTest.corr.NBinc;'])
    
    eval(['GroupData.Test.Source.AccByBlock(' num2str(isub) ',:)=data_s' sub{isub} '.Test.Source.AccByBlock;'])
    eval(['GroupData.Test.Order.AccByBlock(' num2str(isub) ',:)=data_s' sub{isub} '.Test.Order.AccByBlock;'])
    
    eval(['GroupData.Encoding.BoundaryEffect.Mem.Source.MemHC(' num2str(isub) ',:)=data_s' sub{isub} '.Encoding.BoundaryEffect.Mem.Source.MemHC;'])
    eval(['GroupData.Encoding.BoundaryEffect.Mem.Order.MemHC(' num2str(isub) ',:)=data_s' sub{isub} '.Encoding.BoundaryEffect.Mem.Order.MemHC;'])
    
    eval(['GroupData.Encoding.BoundaryEffect.Mem.Source.All.half(' num2str(isub) ',:)=data_s' sub{isub} '.Encoding.BoundaryEffect.Mem.Source.Allhalf;'])
    eval(['GroupData.Encoding.BoundaryEffect.Mem.Order.All.half(' num2str(isub) ',:)=data_s' sub{isub} '.Encoding.BoundaryEffect.Mem.Order.Allhalf;'])
    
    eval(['GroupData.Encoding.BoundaryEffect.Mem.Source.All.thirds(' num2str(isub) ',:)=data_s' sub{isub} '.Encoding.BoundaryEffect.Mem.Source.Allthirds;'])
    eval(['GroupData.Encoding.BoundaryEffect.Mem.Order.All.thirds(' num2str(isub) ',:)=data_s' sub{isub} '.Encoding.BoundaryEffect.Mem.Order.Allthirds;'])
    
    eval(['GroupData.Encoding.BoundaryEffect.Mem.Source.All.quarters(' num2str(isub) ',:)=data_s' sub{isub} '.Encoding.BoundaryEffect.Mem.Source.Allquarters;'])
    eval(['GroupData.Encoding.BoundaryEffect.Mem.Order.All.quarters(' num2str(isub) ',:)=data_s' sub{isub} '.Encoding.BoundaryEffect.Mem.Order.Allquarters;'])
    
    eval(['GroupData.Test.Order.IFSourceHCCorrect(' num2str(isub) ',:)=data_s' sub{isub} '.Test.Order.IFSourceHCCorrect;'])
    eval(['GroupData.Test.Order.IFSourceLCIncorrect(' num2str(isub) ',:)=data_s' sub{isub} '.Test.Order.IFSourceLCIncorrect;'])
    
    %eval(['GroupData.Test.Order.AccbyBlockPosition.B(' num2str(isub) ',:)=data_s' sub{isub} '.Test.Order.AccbyBlockPosition.B;'])
    %eval(['GroupData.Test.Order.AccbyBlockPosition.NB(' num2str(isub) ',:)=data_s' sub{isub} '.Test.Order.AccbyBlockPosition.NB;'])
    
end


figure;
bar([nanmean(GroupData.Encoding.RT.B) nanmean(GroupData.Encoding.RT.NB)])
hold on
conditions = {'Boundary','Non-Boundary'};
set(gca,'xTickLabel',conditions,'FontSize',20);
errorbar([nanmean(GroupData.Encoding.RT.B) nanmean(GroupData.Encoding.RT.NB)],[nanstd(GroupData.Encoding.RT.B)/sqrt(length(sub)) nanstd(GroupData.Encoding.RT.NB)/sqrt(length(sub))],'*')
ylabel('Reaction Time (sec)','Fontsize',20)
xlabel('Condition','Fontsize',20)
title('Encoding Reaction Times','Fontsize',20)
axis([0 3 1 2.5])
[h p] = ttest(GroupData.Encoding.RT.B, GroupData.Encoding.RT.NB);
str1= {['p=' num2str(p)]};
text(2.25,2.45,str1,'Fontsize',20)


figure;
bar([nanmean(GroupData.Encoding.RTs.pos1) nanmean(GroupData.Encoding.RTs.pos2) nanmean(GroupData.Encoding.RTs.pos3) nanmean(GroupData.Encoding.RTs.pos4) nanmean(GroupData.Encoding.RTs.pos5) nanmean(GroupData.Encoding.RTs.pos6) ])
hold on
errorbar([nanmean(GroupData.Encoding.RTs.pos1) nanmean(GroupData.Encoding.RTs.pos2) nanmean(GroupData.Encoding.RTs.pos3) nanmean(GroupData.Encoding.RTs.pos4) nanmean(GroupData.Encoding.RTs.pos5) nanmean(GroupData.Encoding.RTs.pos6)],[nanstd(GroupData.Encoding.RTs.pos1)/sqrt(length(sub)) nanstd(GroupData.Encoding.RTs.pos2)/sqrt(length(sub)) nanstd(GroupData.Encoding.RTs.pos3)/sqrt(length(sub)) nanstd(GroupData.Encoding.RTs.pos4)/sqrt(length(sub)) nanstd(GroupData.Encoding.RTs.pos5)/sqrt(length(sub)) nanstd(GroupData.Encoding.RTs.pos6)/sqrt(length(sub))],'*')
ylabel('Reaction Time (sec)','Fontsize',20)
xlabel('Position','Fontsize',20)
title('Encoding Reaction Times','Fontsize',20)
axis([0 7 1 2.5])


figure;
bar([nanmean(GroupData.Test.Source.Acc.B) nanmean(GroupData.Test.Source.Acc.NB) nanmean(GroupData.Test.Order.Acc.B) nanmean(GroupData.Test.Order.Acc.NB)])
hold on
conditions = {'Source B','Source NB' 'Order B' 'Order NB'};
set(gca,'xTickLabel',conditions,'FontSize',20);
errorbar([nanmean(GroupData.Test.Source.Acc.B) nanmean(GroupData.Test.Source.Acc.NB) nanmean(GroupData.Test.Order.Acc.B) nanmean(GroupData.Test.Order.Acc.NB)],[nanstd(GroupData.Test.Source.Acc.B)/sqrt(length(sub)) nanstd(GroupData.Test.Source.Acc.NB)/sqrt(length(sub)) nanstd(GroupData.Test.Order.Acc.B)/sqrt(length(sub)) nanstd(GroupData.Test.Order.Acc.NB)/sqrt(length(sub))],'*')
ylabel('Accuracy','Fontsize',20)
xlabel('Condition','Fontsize',20)
title('Source and Order Accuracy','Fontsize',20)
axis([0 5 0 1])
[h p] = ttest(GroupData.Test.Source.Acc.B, GroupData.Test.Source.Acc.NB);
str1= {['p=' num2str(p)]};
text(.25,.95,str1,'Fontsize',20)
[h p] = ttest(GroupData.Test.Order.Acc.B, GroupData.Test.Order.Acc.NB);
str2= {['p=' num2str(p)]};
text(3.75,.95,str2,'Fontsize',20)
%plot([.5 .5 .5 .5 .5],'k--','LineWidth',1,'DisplayName','criterion','YDataSource','criterion')


figure;
bar([nanmean(GroupData.Test.Source.Acc.B_HC) nanmean(GroupData.Test.Source.Acc.NB_HC) nanmean(GroupData.Test.Order.Acc.B_HC) nanmean(GroupData.Test.Order.Acc.NB_HC)])
hold on
conditions = {'SourceB','SourceNB' 'OrderB' 'OrderNB'};
set(gca,'xTickLabel',conditions,'FontSize',20);
errorbar([nanmean(GroupData.Test.Source.Acc.B_HC) nanmean(GroupData.Test.Source.Acc.NB_HC) nanmean(GroupData.Test.Order.Acc.B_HC) nanmean(GroupData.Test.Order.Acc.NB_HC)],[nanstd(GroupData.Test.Source.Acc.B_HC)/sqrt(length(sub)) nanstd(GroupData.Test.Source.Acc.NB_HC)/sqrt(length(sub)) nanstd(GroupData.Test.Order.Acc.B_HC)/sqrt(length(sub)) nanstd(GroupData.Test.Order.Acc.NB_HC)/sqrt(length(sub))],'*')
ylabel('Accuracy','Fontsize',20)
xlabel('Condition','Fontsize',20)
title('High Confidence Source and Order Accuracy','Fontsize',20)
axis([0 5 0 1])
[h p] = ttest(GroupData.Test.Source.Acc.B_HC, GroupData.Test.Source.Acc.NB_HC);
str1= {['p=' num2str(p)]};
text(.25,.95,str1,'Fontsize',20)
[h p] = ttest(GroupData.Test.Order.Acc.B_HC, GroupData.Test.Order.Acc.NB_HC);
str2= {['p=' num2str(p)]};
text(3.75,.95,str2,'Fontsize',20)
%plot([.5 .5 .5 .5 .5],'k--','LineWidth',1,'DisplayName','criterion','YDataSource','criterion')



figure;
bar([nanmean(GroupData.Test.Source.Acc.B_LC) nanmean(GroupData.Test.Source.Acc.NB_LC) nanmean(GroupData.Test.Order.Acc.B_LC) nanmean(GroupData.Test.Order.Acc.NB_LC)])
hold on
conditions = {'SourceB','SourceNB' 'OrderB' 'OrderNB'};
set(gca,'xTickLabel',conditions,'FontSize',20);
errorbar([nanmean(GroupData.Test.Source.Acc.B_LC) nanmean(GroupData.Test.Source.Acc.NB_LC) nanmean(GroupData.Test.Order.Acc.B_LC) nanmean(GroupData.Test.Order.Acc.NB_LC)],[nanstd(GroupData.Test.Source.Acc.B_LC)/sqrt(length(sub)) nanstd(GroupData.Test.Source.Acc.NB_LC)/sqrt(length(sub)) nanstd(GroupData.Test.Order.Acc.B_LC)/sqrt(length(sub)) nanstd(GroupData.Test.Order.Acc.NB_LC)/sqrt(length(sub))],'*')
ylabel('Accuracy','Fontsize',20)
xlabel('Condition','Fontsize',20)
title('Low Confidence Source and Order Accuracy','Fontsize',20)
axis([0 5 0 1])
[h p] = ttest(GroupData.Test.Source.Acc.B_LC, GroupData.Test.Source.Acc.NB_LC);
str1= {['p=' num2str(p)]};
text(.25,.95,str1,'Fontsize',20)
[h p] = ttest(GroupData.Test.Order.Acc.B_LC, GroupData.Test.Order.Acc.NB_LC);
str2= {['p=' num2str(p)]};
text(3.75,.95,str2,'Fontsize',20)
%plot([.5 .5 .5 .5 .5],'k--','LineWidth',1,'DisplayName','criterion','YDataSource','criterion')


figure;
bar([nanmean(GroupData.Test.Source.RT.B.correct) nanmean(GroupData.Test.Source.RT.B.incorrect) nanmean(GroupData.Test.Source.RT.NB.correct) nanmean(GroupData.Test.Source.RT.NB.incorrect)])
hold on
conditions = {'B cor','B inc' 'NB cor' 'NC inc'};
set(gca,'xTickLabel',conditions,'FontSize',20);
errorbar([nanmean(GroupData.Test.Source.RT.B.correct) nanmean(GroupData.Test.Source.RT.B.incorrect) nanmean(GroupData.Test.Source.RT.NB.correct) nanmean(GroupData.Test.Source.RT.NB.incorrect)],[nanstd(GroupData.Test.Source.RT.B.correct)/sqrt(length(sub)) nanstd(GroupData.Test.Source.RT.B.incorrect)/sqrt(length(sub)) nanstd(GroupData.Test.Source.RT.NB.correct)/sqrt(length(sub)) nanstd(GroupData.Test.Source.RT.NB.incorrect)/sqrt(length(sub))],'*')
ylabel('Response Time','Fontsize',20)
xlabel('Condition','Fontsize',20)
title('Source: Response Times by Accuracy','Fontsize',20)
%axis([0 5 2 4])


figure;
bar([nanmean(GroupData.Test.Order.RT.B.correct) nanmean(GroupData.Test.Order.RT.B.incorrect) nanmean(GroupData.Test.Order.RT.NB.correct) nanmean(GroupData.Test.Order.RT.NB.incorrect)])
hold on
conditions = {'B cor','B inc' 'NB cor' 'NC inc'};
set(gca,'xTickLabel',conditions,'FontSize',20);
errorbar([nanmean(GroupData.Test.Order.RT.B.correct) nanmean(GroupData.Test.Order.RT.B.incorrect) nanmean(GroupData.Test.Order.RT.NB.correct) nanmean(GroupData.Test.Order.RT.NB.incorrect)],[nanstd(GroupData.Test.Order.RT.B.correct)/sqrt(length(sub)) nanstd(GroupData.Test.Order.RT.B.incorrect)/sqrt(length(sub)) nanstd(GroupData.Test.Order.RT.NB.correct)/sqrt(length(sub)) nanstd(GroupData.Test.Order.RT.NB.incorrect)/sqrt(length(sub))],'*')
ylabel('Response Time','Fontsize',20)
xlabel('Condition','Fontsize',20)
title('Order: Response Times by Accuracy','Fontsize',20)

figure;
bar([nanmean(GroupData.Test.Source.RT.B.correctHC) nanmean(GroupData.Test.Source.RT.NB.correctHC) nanmean(GroupData.Test.Order.RT.B.correctHC) nanmean(GroupData.Test.Order.RT.NB.correctHC)])
hold on
conditions = {'Source B','Source NB' 'Order B' 'Order NB'};
set(gca,'xTickLabel',conditions,'FontSize',20);
errorbar([nanmean(GroupData.Test.Source.RT.B.correctHC) nanmean(GroupData.Test.Source.RT.NB.correctHC) nanmean(GroupData.Test.Order.RT.B.correctHC) nanmean(GroupData.Test.Order.RT.NB.correctHC)],[nanstd(GroupData.Test.Source.RT.B.correctHC)/sqrt(length(sub)) nanstd(GroupData.Test.Source.RT.NB.correctHC)/sqrt(length(sub)) nanstd(GroupData.Test.Order.RT.B.correctHC)/sqrt(length(sub)) nanstd(GroupData.Test.Order.RT.NB.correctHC)/sqrt(length(sub))],'*')
ylabel('Response Time','Fontsize',20)
xlabel('Condition','Fontsize',20)
title('Response Times for Cleaned Correct Trials: High Confidence','Fontsize',20)
[h p] = ttest(GroupData.Test.Source.RT.B.correctHC, GroupData.Test.Source.RT.NB.correctHC);
str1= {['p=' num2str(p)]};
text(.25,4.9,str1,'Fontsize',20)
[h p] = ttest(GroupData.Test.Order.RT.B.correctHC, GroupData.Test.Order.RT.NB.correctHC);
str2= {['p=' num2str(p)]};
text(3.75,4.9,str2,'Fontsize',20)

%axis([0 5 2 4])

% figure;
% bar([nanmean(GroupData.PostTest.corr.B) nanmean(GroupData.PostTest.corr.NB)])
% hold on
% conditions = {'Boundary','Non-Boundary'};
% set(gca,'xTickLabel',conditions,'FontSize',20);
% errorbar([nanmean(GroupData.PostTest.corr.B) nanmean(GroupData.PostTest.corr.NB)],[nanstd(GroupData.PostTest.corr.B)/sqrt(length(sub)) nanstd(GroupData.PostTest.corr.NB)/sqrt(length(sub))],'*')
% ylabel('Correlation','Fontsize',20)
% xlabel('Condition','Fontsize',20)
% title('Average Coarse Temporal Memory Performance','Fontsize',20)
% axis([0 3 0 .5])
% [h p] = ttest(GroupData.PostTest.corr.B, GroupData.PostTest.corr.NB);
% str1= {['p=' num2str(p)]};
% text(2.25,.485,str1,'Fontsize',20)
%
%
% figure;
% bar([nanmean(GroupData.PostTest.corr.Bcor) nanmean(GroupData.PostTest.corr.Binc) nanmean(GroupData.PostTest.corr.NBcor) nanmean(GroupData.PostTest.corr.NBinc)])
% hold on
% conditions = {'B cor','B inc' 'NB cor' 'NB inc'};
% set(gca,'xTickLabel',conditions,'FontSize',20);
% errorbar([nanmean(GroupData.PostTest.corr.Bcor) nanmean(GroupData.PostTest.corr.Binc) nanmean(GroupData.PostTest.corr.NBcor) nanmean(GroupData.PostTest.corr.NBinc)],...
%     [nanstd(GroupData.PostTest.corr.Bcor)/sqrt(length(sub)) nanstd(GroupData.PostTest.corr.Binc)/sqrt(length(sub)) nanstd(GroupData.PostTest.corr.NBcor)/sqrt(length(sub)) nanstd(GroupData.PostTest.corr.NBinc)/sqrt(length(sub))],'*');
% ylabel('CTM correlation','Fontsize',20)
% xlabel('Condition','Fontsize',20)
% title('CTM correlation by Accuracy','Fontsize',20)
% axis([0 5 0 .5])
% [h p] = ttest(GroupData.PostTest.corr.Bcor, GroupData.PostTest.corr.NBcor);
% str1= {['p=' num2str(p)]};
% text(3.75,.45,str1,'Fontsize',20)
%
% [h p] = ttest(GroupData.PostTest.corr.Bcor, GroupData.PostTest.corr.NBcor)
% [h p] = ttest(GroupData.PostTest.corr.Bcor, GroupData.PostTest.corr.Binc)
% [h p] = ttest(GroupData.PostTest.corr.NBcor, GroupData.PostTest.corr.NBinc)


if saveOut ==1
    
    mkdir(groupDir)
    cd(groupDir)
    
    save GroupData GroupData
    
    fig1 = figure(1);
    set(fig1, 'Position', [0 0 1000 600])
    print(fig1,'-djpeg', 'avgRTs.jpeg')
    print(fig1,'-deps', 'avgRTs.eps')
    
    fig2 = figure(2);
    set(fig2, 'Position', [0 0 1000 600])
    print(fig2,'-djpeg', 'RTsbypos.jpeg')
    print(fig2,'-deps', 'RTsbypos.eps')
    
    fig3 = figure(3);
    set(fig3, 'Position', [0 0 1000 600])
    print(fig3,'-djpeg', 'accuracy.jpeg')
    print(fig3,'-deps', 'accuracy.eps')
    
    fig4 = figure(4);
    set(fig4, 'Position', [0 0 1000 600])
    print(fig4,'-djpeg', 'HCaccuracy.jpeg')
    print(fig4,'-deps', 'HCaccuracy.eps')
    
    fig5 = figure(5);
    set(fig5, 'Position', [0 0 1000 600])
    print(fig5,'-djpeg', 'LCaccuracy.jpeg')
    print(fig5,'-deps', 'LCaccuracy.eps')
    
    fig6 = figure(6);
    set(fig6, 'Position', [0 0 1000 600])
    print(fig6,'-djpeg', 'SourceRTs.jpeg')
    print(fig6,'-deps', 'SourceRTs.eps')
    
    fig7 = figure(7);
    set(fig7, 'Position', [0 0 1000 600])
    print(fig7,'-djpeg', 'OrderRTs.jpeg')
    print(fig7,'-deps', 'OrderRTs.eps')
    
    fig8 = figure(8);
    set(fig8, 'Position', [0 0 1000 600])
    print(fig8,'-djpeg', 'correct_HC_RTs.jpeg')
    print(fig8,'-deps', 'correct_HC_RTs.eps')
    
end
% fig6 = figure(6);
% set(fig6, 'Position', [0 0 1000 600])
% print(fig6,'-djpeg', 'CTMbyAcc.jpeg')

close all



