%createTestSeq
clear all; 

for isub = 1:12

cd /Volumes/davachilab/heusser/MEGbound_v1.1/Encoding/
    
load(['/Volumes/davachilab/MEGbound/Encoding/encodingSeq',num2str(isub),'.mat'])

encodingSeq([1 2 144 145 146 288 289 290 432 433 434 576],:)=[];

NBitem = encodingSeq(cell2mat(encodingSeq(:,3))==3,1);

NBtoc = encodingSeq(cell2mat(encodingSeq(:,3))==4,1);

NBtoi = encodingSeq(cell2mat(encodingSeq(:,3))==5,1);

Bitem = encodingSeq(cell2mat(encodingSeq(:,3))==6,1);

Btoc = encodingSeq(cell2mat(encodingSeq(:,3))==1,1);

Btoi = encodingSeq(cell2mat(encodingSeq(:,3))==2,1);

NBtestList = [NBitem NBtoc NBtoi num2cell([ones(24,1); ones(24,1)*2; ones(24,1)*3; ones(24,1)*4]) repmat({'NB'},96,1)];
BtestList = [Bitem Btoc Btoi num2cell([ones(23,1); ones(23,1)*2; ones(23,1)*3; ones(23,1)*4]) repmat({'B'},92,1)];

% account for encoding time and randomize the test order

BtestList11 = BtestList(1:11,:);
NBtestList11 = NBtestList(1:12,:);

testList11 = [BtestList11; NBtestList11];
testList11rand = testList11(randperm(23),:);

BtestList12 = BtestList(12:23,:);
NBtestList12 = NBtestList(13:24,:);

testList12 = [BtestList12; NBtestList12];
testList12rand = testList12(randperm(24),:);

testList1 = [testList11rand; testList12rand];

%
%

BtestList21 = BtestList(24:34,:);
NBtestList21 = NBtestList(25:36,:);

testList21 = [BtestList21; NBtestList21];
testList21rand = testList21(randperm(23),:);

BtestList22 = BtestList(35:46,:);
NBtestList22 = NBtestList(37:48,:);

testList22 = [BtestList22; NBtestList22];
testList22rand = testList22(randperm(24),:);

testList2 = [testList21rand; testList22rand];

%
%

BtestList31 = BtestList(47:57,:);
NBtestList31 = NBtestList(49:60,:);

testList31 = [BtestList31; NBtestList31];
testList31rand = testList31(randperm(23),:);

BtestList32 = BtestList(58:69,:);
NBtestList32 = NBtestList(61:72,:);

testList32 = [BtestList32; NBtestList32];
testList32rand = testList32(randperm(24),:);

testList3 = [testList31rand; testList32rand];

%
%

BtestList41 = BtestList(70:80,:);
NBtestList41 = NBtestList(73:84,:);

testList41 = [BtestList41; NBtestList41];
testList41rand = testList41(randperm(23),:);

BtestList42 = BtestList(81:92,:);
NBtestList42 = NBtestList(85:96,:);

testList42 = [BtestList42; NBtestList42];
testList42rand = testList42(randperm(24),:);

testList4 = [testList41rand; testList42rand];

testSeq = [testList1; testList2; testList3; testList4];

save(['testSeq',num2str(isub)],'testSeq')

end





