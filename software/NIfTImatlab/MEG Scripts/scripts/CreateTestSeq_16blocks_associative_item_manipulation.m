%createTestSeq
%This script creates the retrieval test structure for MEGbound pilot
%02-25-2013.  First, it creates 11 source memory trials.  Then, It creates
%11
%temporal order trials where subjects have to indicate intact order or
%rearranged order.  Half of the trials will be intact and half will be
%rearranged.

clear all;

for isub = 1:12
    
    cd /Volumes/davachilab/MEGbound/Encoding/
    
    load(['/MEGbound/Encoding/encodingSeq',num2str(isub),'.mat'])
    
    encodingSeq([1:6 37:42 73:78 109:114 145:150 181:186 217:222 253:258 289:end],:)=[];
    
    pos1 = encodingSeq(cell2mat(encodingSeq(:,3))==1,:);
    
    
    save(['testSeq_16block_V8_',num2str(isub)],'testSeq')
    
end