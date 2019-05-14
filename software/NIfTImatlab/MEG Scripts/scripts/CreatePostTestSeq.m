%Create Post Test

cd /Volumes/davachilab/MEGbound_v1.1/Task

for isub = 1:12
    
    while 1
    
    load(['encodingSeq',num2str(isub)])
    
    encodingSeq = [encodingSeq num2cell([1:576]')];
    
    Btrialidx = cell2mat(encodingSeq(:,3))==1;
    
    NBtrialidx = cell2mat(encodingSeq(:,3))==3;
    
    Btrials = encodingSeq(Btrialidx,:);
    
    NBtrials = encodingSeq(NBtrialidx,:);
    
    PostTestTrials = [Btrials; NBtrials];
    
    PostTestTrialsRand = PostTestTrials(randperm(192),:);
    
    postTestSeq = PostTestTrialsRand;
    
    if sum(cell2mat(PostTestTrialsRand(1:48,8))>504)==0
        break
    end
    
    end
    
    save(['postTestSeq',num2str(isub)],'postTestSeq')
    
end
        
