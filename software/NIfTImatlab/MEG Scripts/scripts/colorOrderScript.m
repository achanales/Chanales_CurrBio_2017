function BlockOrder = colorOrderScript(~)
BlockOrder = [];


while size(BlockOrder,2)<4
    
    clear all
    BlockOrder=[];
    count = 0;
    load colorsamples.mat
    
    colorSwitchIDX{:,1}=5:20;
    colorSwitchIDX{:,2}=6:21;
    colorSwitchIDX{:,3}=7:22;
    colorSwitchIDX{:,4}=8:23;
    colorSwitchIDX{:,5}=[9:24];
    colorSwitchIDX{:,6}=[1 10:24];
    colorSwitchIDX{:,7}=[1:2 11:24];
    colorSwitchIDX{:,8}=[1:3 12:24];
    colorSwitchIDX{:,9}=[1:4 13:24];
    colorSwitchIDX{:,10}=[1:5 14:24];
    colorSwitchIDX{:,11}=[1:6 15:24];
    colorSwitchIDX{:,12}=[1:7 16:24];
    colorSwitchIDX{:,13}=[1:8 17:24];
    colorSwitchIDX{:,14}=[1:9 18:24];
    colorSwitchIDX{:,15}=[1:10 19:24];
    colorSwitchIDX{:,16}=[1:11 20:24];
    colorSwitchIDX{:,17}=[1:12 21:24];
    colorSwitchIDX{:,18}=[1:13 22:24];
    colorSwitchIDX{:,19}=[1:14 23:24];
    colorSwitchIDX{:,20}=[1:15 24];
    colorSwitchIDX{:,21}=[1:16];
    colorSwitchIDX{:,22}=[2:17];
    colorSwitchIDX{:,23}=[3:18];
    colorSwitchIDX{:,24}=[4:19];
    colorSwitchIDXold=colorSwitchIDX;
    
    for iOrder = 1:4
        
        %generate random numbers
        randnum=randperm(24);
        
        %pick 1
        tmp_perm=randnum(1);
        
        %set that as the first block color
        blockOrder=tmp_perm;
        nextTrial=[];
        count = 0;
        
        
        for i = 2:24
            
            tmpnum = randperm(length(colorSwitchIDX{1,blockOrder(i-1)}));
            nextTrial = colorSwitchIDX{1,blockOrder(i-1)}(tmpnum(1));
            
            while find(nextTrial==blockOrder)
                tmpnum = randperm(length(colorSwitchIDX{1,blockOrder(i-1)}));
                nextTrial = colorSwitchIDX{1,blockOrder(i-1)}(tmpnum(1));
                count = count + 1;
                
                if count==100
                    break
                end
                
            end
            
            if count==100
                break
            end
            
            blockOrder = [blockOrder; nextTrial];
            colorSwitchIDX{1,blockOrder(i-1)}(tmpnum(1))=[];
            
        end
        
        if count==100
            break
        end
        
        colorSwitchIDXold=colorSwitchIDX;
        BlockOrder(:,iOrder) = blockOrder;
        
        
    end
    
end

BlockOrder = BlockOrder(:);

tmp = [];

for irep = 1:length(BlockOrder)
    
    tmp = [tmp; repmat(BlockOrder(irep),6,1)];
    
end

BlockOrder=tmp;

end





