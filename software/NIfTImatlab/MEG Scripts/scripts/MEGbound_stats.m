%Group Stats on MEGbound GroupData.mat

load /Volumes/davachilab/MEGbound/Data/V6/group24_onlygoodsubs/GroupData.mat

[h p CI stats] = ttest(GroupData.Encoding.RT.B,GroupData.Encoding.RT.NB)

for itest1 = 1:6
    
    for itest2 = 1:6
        
        eval(['tmp1 = GroupData.Encoding.RTs.pos' num2str(itest1) ';'])
        eval(['tmp2 = GroupData.Encoding.RTs.pos' num2str(itest2) ';'])
        
        [~,ttest_pos(itest1,itest2),~,] = ttest(tmp1,tmp2);
        
    end
    
end

[h p CI stats] = ttest(GroupData.Test.Order.Acc.B,GroupData.Test.Order.Acc.NB)

[h p CI stats] = ttest(GroupData.Test.Source.Acc.B,GroupData.Test.Source.Acc.NB)

[h p CI stats] = ttest(GroupData.Test.Order.RT.B,GroupData.Test.Order.RT.NB)



[h p CI stats] = ttest(GroupData.Test.Order.RT.B.correct,GroupData.Test.Order.RT.NB.correct)

[h p CI stats] = ttest(GroupData.Test.Order.RT.B.incorrect,GroupData.Test.Order.RT.NB.incorrect)


[h p CI stats] = ttest(GroupData.Test.Source.RT.B.correct,GroupData.Test.Source.RT.NB.correct)

[h p CI stats] = ttest(GroupData.Test.Source.RT.B.incorrect,GroupData.Test.Source.RT.NB.incorrect)
