%createTestSeq
clear all; 

for isub = 1:12

cd /Volumes/davachilab/MEGbound/Encoding/
    
load(['/MEGbound/Encoding/encodingSeq',num2str(isub),'.mat'])

encodingSeq([1 36 37 108 109 72 73 144 145 180 181 216 217 252 253 288 289 324 325 360 361 396 397 432 433 468 469 504 505 540 541 576],:)=[];

NBitem1 = encodingSeq(cell2mat(encodingSeq(:,3))==2,1);

NBitem2 = encodingSeq(cell2mat(encodingSeq(:,3))==3,1);

NBencodingColor = encodingSeq(cell2mat(encodingSeq(:,3))==3,4);

NBitem3 = encodingSeq(cell2mat(encodingSeq(:,3))==4,1);

NBitem4 = encodingSeq(cell2mat(encodingSeq(:,3))==5,1);

Bitem1 = encodingSeq(cell2mat(encodingSeq(:,3))==6,1);

Bitem2 = encodingSeq(cell2mat(encodingSeq(:,3))==1,1);

BencodingColor = encodingSeq(cell2mat(encodingSeq(:,3))==6,4);

NBtestList1 = [NBitem1 NBitem2 num2cell([ones(6,1); ones(6,1)*2; ones(6,1)*3; ones(6,1)*4; ones(6,1)*5; ones(6,1)*6; ones(6,1)*7; ones(6,1)*8; ones(6,1)*9; ones(6,1)*10; ones(6,1)*11; ones(6,1)*12; ones(6,1)*13; ones(6,1)*14; ones(6,1)*15; ones(6,1)*16]) repmat({'NB'},96,1) num2cell(ones(96,1)) NBencodingColor];

NBtestList2 = [NBitem3 NBitem4 num2cell([ones(6,1); ones(6,1)*2; ones(6,1)*3; ones(6,1)*4; ones(6,1)*5; ones(6,1)*6; ones(6,1)*7; ones(6,1)*8; ones(6,1)*9; ones(6,1)*10; ones(6,1)*11; ones(6,1)*12; ones(6,1)*13; ones(6,1)*14; ones(6,1)*15; ones(6,1)*16]) repmat({'NB'},96,1) num2cell(ones(96,1)*2) NBencodingColor];

BtestList = [Bitem1 Bitem2 num2cell([ones(5,1); ones(5,1)*2; ones(5,1)*3; ones(5,1)*4; ones(5,1)*5; ones(5,1)*6; ones(5,1)*7; ones(5,1)*8; ones(5,1)*9; ones(5,1)*10; ones(5,1)*11; ones(5,1)*12; ones(5,1)*13; ones(5,1)*14; ones(5,1)*15; ones(5,1)*16]) repmat({'B'},80,1) num2cell(nan(80,1)) BencodingColor];

% account for encoding time and randomize the test order

BtestList11 = BtestList(1:2,:);
NBtestList11 = [NBtestList1(1:3,:); NBtestList2(1:3,:)];

testList11 = [BtestList11; NBtestList11];
testList11rand = testList11(randperm(8),:);

BtestList12 = BtestList(3:5,:);
NBtestList12 = [NBtestList1(4:6,:); NBtestList2(4:6,:)];

testList12 = [BtestList12; NBtestList12];
testList12rand = testList12(randperm(9),:);

testList1 = [testList11rand; testList12rand];

%
%

BtestList21 = BtestList(6:7,:);
NBtestList21 = [NBtestList1(7:9,:); NBtestList2(7:9,:)];

testList21 = [BtestList21; NBtestList21];
testList21rand = testList21(randperm(8),:);

BtestList22 = BtestList(8:10,:);
NBtestList22 = [NBtestList1(10:12,:); NBtestList2(10:12,:)];

testList22 = [BtestList22; NBtestList22];
testList22rand = testList22(randperm(9),:);

testList2 = [testList21rand; testList22rand];

%
%

BtestList31 = BtestList(11:12,:);
NBtestList31 = [NBtestList1(13:15,:); NBtestList2(13:15,:)];

testList31 = [BtestList31; NBtestList31];
testList31rand = testList31(randperm(8),:);

BtestList32 = BtestList(13:15,:);
NBtestList32 = [NBtestList1(16:18,:); NBtestList2(16:18,:)];

testList32 = [BtestList32; NBtestList32];
testList32rand = testList32(randperm(9),:);

testList3 = [testList31rand; testList32rand];

%
%

BtestList41 = BtestList(16:17,:);
NBtestList41 = [NBtestList1(19:21,:); NBtestList2(19:21,:)];

testList41 = [BtestList41; NBtestList41];
testList41rand = testList41(randperm(8),:);

BtestList42 = BtestList(18:20,:);
NBtestList42 = [NBtestList1(22:24,:); NBtestList2(22:24,:)];

testList42 = [BtestList42; NBtestList42];
testList42rand = testList42(randperm(9),:);

testList4 = [testList41rand; testList42rand];

%
%

BtestList51 = BtestList(21:22,:);
NBtestList51 = [NBtestList1(25:27,:); NBtestList2(25:27,:)];

testList51 = [BtestList51; NBtestList51];
testList51rand = testList51(randperm(8),:);

BtestList52 = BtestList(23:25,:);
NBtestList52 = [NBtestList1(28:30,:); NBtestList2(28:30,:)];

testList52 = [BtestList52; NBtestList52];
testList52rand = testList52(randperm(9),:);

testList5 = [testList51rand; testList52rand];

%
%

BtestList61 = BtestList(26:27,:);
NBtestList61 = [NBtestList1(31:33,:); NBtestList2(31:33,:)];

testList61 = [BtestList61; NBtestList61];
testList61rand = testList61(randperm(8),:);

BtestList62 = BtestList(28:30,:);
NBtestList62 = [NBtestList1(34:36,:); NBtestList2(34:36,:)];

testList62 = [BtestList62; NBtestList62];
testList62rand = testList62(randperm(9),:);

testList6 = [testList61rand; testList62rand];

%
%

BtestList71 = BtestList(31:32,:);
NBtestList71 = [NBtestList1(37:39,:); NBtestList2(37:39,:)];

testList71 = [BtestList71; NBtestList71];
testList71rand = testList71(randperm(8),:);

BtestList72 = BtestList(33:35,:);
NBtestList72 = [NBtestList1(40:42,:); NBtestList2(40:42,:)];

testList72 = [BtestList72; NBtestList72];
testList72rand = testList72(randperm(9),:);

testList7 = [testList71rand; testList72rand];

%
%

BtestList81 = BtestList(36:37,:);
NBtestList81 = [NBtestList1(43:45,:); NBtestList2(43:45,:)];

testList81 = [BtestList81; NBtestList81];
testList81rand = testList81(randperm(8),:);

BtestList82 = BtestList(38:40,:);
NBtestList82 = [NBtestList1(46:48,:); NBtestList2(46:48,:)];

testList82 = [BtestList82; NBtestList82];
testList82rand = testList82(randperm(9),:);

testList8 = [testList81rand; testList82rand];

%
%

BtestList91 = BtestList(41:42,:);
NBtestList91 = [NBtestList1(49:51,:); NBtestList2(49:51,:)];

testList91 = [BtestList91; NBtestList91];
testList91rand = testList91(randperm(8),:);

BtestList92 = BtestList(43:45,:);
NBtestList92 = [NBtestList1(52:54,:); NBtestList2(52:54,:)];

testList92 = [BtestList92; NBtestList92];
testList92rand = testList92(randperm(9),:);

testList9 = [testList91rand; testList92rand];

%
%

BtestList101 = BtestList(46:47,:);
NBtestList101 = [NBtestList1(55:57,:); NBtestList2(55:57,:)];

testList101 = [BtestList101; NBtestList101];
testList101rand = testList101(randperm(8),:);

BtestList102 = BtestList(48:50,:);
NBtestList102 = [NBtestList1(58:60,:); NBtestList2(58:60,:)];

testList102 = [BtestList102; NBtestList102];
testList102rand = testList102(randperm(9),:);

testList10 = [testList101rand; testList102rand];

%
%

BtestList111 = BtestList(51:52,:);
NBtestList111 = [NBtestList1(61:63,:); NBtestList2(61:63,:)];

testList111 = [BtestList111; NBtestList111];
testList111rand = testList111(randperm(8),:);

BtestList112 = BtestList(53:55,:);
NBtestList112 = [NBtestList1(64:66,:); NBtestList2(64:66,:)];

testList112 = [BtestList112; NBtestList112];
testList112rand = testList112(randperm(9),:);

testList11 = [testList111rand; testList112rand];

%
%

BtestList121 = BtestList(56:57,:);
NBtestList121 = [NBtestList1(67:69,:); NBtestList2(67:69,:)];

testList121 = [BtestList121; NBtestList121];
testList121rand = testList121(randperm(8),:);

BtestList122 = BtestList(58:60,:);
NBtestList122 = [NBtestList1(70:72,:); NBtestList2(70:72,:)];

testList122 = [BtestList122; NBtestList122];
testList122rand = testList122(randperm(9),:);

testList12 = [testList121rand; testList122rand];

%
%

BtestList131 = BtestList(61:62,:);
NBtestList131 = [NBtestList1(73:75,:); NBtestList2(73:75,:)];

testList131 = [BtestList131; NBtestList131];
testList131rand = testList131(randperm(8),:);

BtestList132 = BtestList(63:65,:);
NBtestList132 = [NBtestList1(76:78,:); NBtestList2(76:78,:)];

testList132 = [BtestList132; NBtestList132];
testList132rand = testList132(randperm(9),:);

testList13 = [testList131rand; testList132rand];

%
%

BtestList141 = BtestList(66:67,:);
NBtestList141 = [NBtestList1(79:81,:); NBtestList2(79:81,:)];

testList141 = [BtestList141; NBtestList141];
testList141rand = testList141(randperm(8),:);

BtestList142 = BtestList(68:70,:);
NBtestList142 = [NBtestList1(82:84,:); NBtestList2(82:84,:)];

testList142 = [BtestList142; NBtestList142];
testList142rand = testList142(randperm(9),:);

testList14 = [testList141rand; testList142rand];

%
%

BtestList151 = BtestList(71:72,:);
NBtestList151 = [NBtestList1(85:87,:); NBtestList2(85:87,:)];

testList151 = [BtestList151; NBtestList151];
testList151rand = testList151(randperm(8),:);

BtestList152 = BtestList(73:75,:);
NBtestList152 = [NBtestList1(88:90,:); NBtestList2(88:90,:)];

testList152 = [BtestList152; NBtestList152];
testList152rand = testList152(randperm(9),:);

testList15 = [testList151rand; testList152rand];

%
%

BtestList161 = BtestList(76:77,:);
NBtestList161 = [NBtestList1(91:93,:); NBtestList2(91:93,:)];

testList161 = [BtestList161; NBtestList161];
testList161rand = testList161(randperm(8),:);

BtestList162 = BtestList(78:80,:);
NBtestList162 = [NBtestList1(94:96,:); NBtestList2(94:96,:)];

testList162 = [BtestList162; NBtestList162];
testList162rand = testList162(randperm(9),:);

testList16 = [testList161rand; testList162rand];

testSeq = [testList1; testList2; ... 
    testList3; ...
    testList4; testList5; ... 
    testList6; testList7; ...
    testList8; testList9; ...
    testList10; testList11; ... 
    testList12; testList13; ... 
    testList14; testList15; ...
    testList16];

save(['testSeq_16block_V3_',num2str(isub)],'testSeq')

end





