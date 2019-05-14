%Color - Order Memory Tradeoff Analysis

cd /Volumes/davachilab/MEGbound/Data/V6/

sub = {'03' '04' '06' '07' '10' '11' '12' '13' '14' '15' '16' '17' '19' '20' '22' '25' '26' '29' '32' '33' '45' '47' '48' '54'};
blocks = 1:16;
tmp = [];
OrderAccfSource = [];

for isub = 1:length(sub)
    
    tmp = [];
    
    for iblock = 1:length(blocks)
        
        tmpMemVec = [];
        
    cd(['/Volumes/davachilab/MEGbound/Data/V6/' sub{isub}])    

%load in behavioral data for sub mem analysis
load(['encodingDataFileSub' sub{isub} 'Block' num2str(blocks(iblock))])
load(['testDataFileSub' sub{isub} 'Block' num2str(blocks(iblock))])

% make a vector representing memory accuracy
memVec = zeros(23,1);
memVec(strmatch('h',[testDataFile(1:end,8)]))=1;
memVec(strmatch('j',[testDataFile(1:end,8)]))=2;
memVec(strmatch('k',[testDataFile(1:end,8)]))=3;
memVec(strmatch('l',[testDataFile(1:end,8)]))=4;
memVec(1)=[];

memVec(:,2)=cell2mat(testDataFile(2:end,12)); %#ok<COLND>

% calculate subsequent memory for each test item
for imem=1:length(memVec)
    
    if memVec(imem,1)==1&&memVec(imem,2)==0||memVec(imem,1)==4&&memVec(imem,2)==1
        
        memVec(imem,3)=1;
        
    elseif memVec(imem,1)==2&&memVec(imem,2)==0||memVec(imem,1)==3&&memVec(imem,2)==1
        
        memVec(imem,3)=2;
        
    elseif memVec(imem,1)==1&&memVec(imem,2)==1||memVec(imem,1)==4&&memVec(imem,2)==0
        
        memVec(imem,3)=3;
        
    elseif memVec(imem,1)==2&&memVec(imem,2)==1||memVec(imem,1)==3&&memVec(imem,2)==0
        
        memVec(imem,3)=4;
        
    end
    
end


% make the order condition labels unique
memVec(12:end,3)=memVec(12:end,3)+4;

memVec=[0 0 0; memVec];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Subsequent Memory Condition Labels%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 1 = Source HC correct
% 2 = Source LC correct
% 3 = Source HC incorrect
% 4 = Source LC incorrect
% 5 = Order HC correct 1st item
% 6 = Order LC correct 1st item
% 7 = Order HC incorrect 1st item
% 8 = Order LC incorrect 1st item
% 9 = Order HC correct 2nd item
% 10 = Order LC correct 2nd item
% 11 = Order HC incorrect 2nd item
% 12 = Order LC incorrect 2nd item

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for imem = 1:length(testDataFile)
    
    if imem==1
       
    
    elseif imem<12
        
        tmpMemVec(encodingDataFile{strncmp(testDataFile{imem,2},[encodingDataFile{2:end,2}],3),1}+1)=memVec(imem,3);
        
    
    elseif imem>=12
        
        tmpMemVec(encodingDataFile{strncmp(testDataFile{imem,3},[encodingDataFile{2:end,2}],3),1}+1)=memVec(imem,3);
        tmpMemVec(encodingDataFile{strncmp(testDataFile{imem,4},[encodingDataFile{2:end,2}],3),1}+1)=memVec(imem,3)+4;
        
    end
     
end

tmpMemVec=tmpMemVec';

bIdx = 1:6:36;
bIdx(1)=[];
nbIdx = 4:6:36;
tmpMemVec(bIdx,2)=tmpMemVec(bIdx-2,1);
tmpMemVec(nbIdx,2)=tmpMemVec(nbIdx-2,1);

nbOrderIdx1 = [2:6:36];
nbOrderIdx2 = [6:6:36];

bOrderIdx1 = [5:6:36];
bOrderIdx1(6)=[];
bOrderIdx2 = [3:6:36];
bOrderIdx1(1)=[];

tmpMemVec(nbOrderIdx1,2)=tmpMemVec(nbOrderIdx1+2,1);
tmpMemVec(nbOrderIdx2,2)=tmpMemVec(nbOrderIdx2-2,1);

tmpMemVec(bOrderIdx1,2)=tmpMemVec(bOrderIdx1+2,1);
tmpMemVec(bOrderIdx2,2)=tmpMemVec(bOrderIdx2-2,1);

tmp = [tmp; tmpMemVec];

    end
    
tmp = [repmat([1:6]',96,1) tmp];

OrderAccForCorrectSourceB = tmp(tmp(:,1)==1&tmp(:,2)==1,3);
OrderAccForIncorrectSourceB = tmp(tmp(:,1)==1&(tmp(:,2)==3|tmp(:,2)==4|tmp(:,2)==2),3);
OrderAccForCorrectSourceNB = tmp(tmp(:,1)==4&(tmp(:,2)==1),3);
OrderAccForIncorrectSourceNB = tmp(tmp(:,1)==4&(tmp(:,2)==3|tmp(:,2)==4|tmp(:,2)==2),3);

tmp1 = sum(OrderAccForCorrectSourceB==5|OrderAccForCorrectSourceB==6)/length(OrderAccForCorrectSourceB);
tmp2 = sum(OrderAccForIncorrectSourceB==5|OrderAccForIncorrectSourceB==6)/length(OrderAccForIncorrectSourceB);

tmp3 = sum(OrderAccForCorrectSourceNB==5|OrderAccForCorrectSourceNB==6)/length(OrderAccForCorrectSourceNB);
tmp4 = sum(OrderAccForIncorrectSourceNB==5|OrderAccForIncorrectSourceNB==6)/length(OrderAccForIncorrectSourceNB);

OrderAccfSource = [OrderAccfSource; tmp1 tmp2 tmp3 tmp4];



end