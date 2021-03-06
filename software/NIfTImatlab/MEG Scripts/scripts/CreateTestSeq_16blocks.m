%createTestSeq
clear all; 

for isub = 1:12

cd /Volumes/davachilab/MEGbound/Encoding/
    
load(['/MEGbound/Encoding/encodingSeq',num2str(isub),'.mat'])

encodingSeq([1 2 36 37 38 108 109 110 72 73 74 144 145 146 180 181 182 216 217 218 252 253 254 288 289 290 324 325 326 360 361 362 396 397 398 432 433 434 468 469 470 504 505 506 540 541 542 576],:)=[];

NBitem = encodingSeq(cell2mat(encodingSeq(:,3))==3,1);

NBencodingColor = encodingSeq(cell2mat(encodingSeq(:,3))==3,4);

NBtoc = encodingSeq(cell2mat(encodingSeq(:,3))==4,1);

NBtoi = encodingSeq(cell2mat(encodingSeq(:,3))==5,1);

Bitem = encodingSeq(cell2mat(encodingSeq(:,3))==6,1);

Btoc = encodingSeq(cell2mat(encodingSeq(:,3))==1,1);

Btoi = encodingSeq(cell2mat(encodingSeq(:,3))==2,1);

BencodingColor = encodingSeq(cell2mat(encodingSeq(:,3))==6,4);

NBtestList = [NBitem NBtoc NBtoi num2cell([ones(6,1); ones(6,1)*2; ones(6,1)*3; ones(6,1)*4; ones(6,1)*5; ones(6,1)*6; ones(6,1)*7; ones(6,1)*8; ones(6,1)*9; ones(6,1)*10; ones(6,1)*11; ones(6,1)*12; ones(6,1)*13; ones(6,1)*14; ones(6,1)*15; ones(6,1)*16]) repmat({'NB'},96,1) NBencodingColor];

BtestList = [Bitem Btoc Btoi num2cell([ones(5,1); ones(5,1)*2; ones(5,1)*3; ones(5,1)*4; ones(5,1)*5; ones(5,1)*6; ones(5,1)*7; ones(5,1)*8; ones(5,1)*9; ones(5,1)*10; ones(5,1)*11; ones(5,1)*12; ones(5,1)*13; ones(5,1)*14; ones(5,1)*15; ones(5,1)*16]) repmat({'B'},80,1) BencodingColor];

% account for encoding time and randomize the test order

BtestList11 = BtestList(1:2,:);
NBtestList11 = NBtestList(1:3,:);

testList11 = [BtestList11; NBtestList11];
testList11rand = testList11(randperm(5),:);

BtestList12 = BtestList(3:5,:);
NBtestList12 = NBtestList(4:6,:);

testList12 = [BtestList12; NBtestList12];
testList12rand = testList12(randperm(6),:);

testList1 = [testList11rand; testList12rand];

%
%

BtestList21 = BtestList(6:7,:);
NBtestList21 = NBtestList(7:9,:);

testList21 = [BtestList21; NBtestList21];
testList21rand = testList21(randperm(5),:);

BtestList22 = BtestList(8:10,:);
NBtestList22 = NBtestList(10:12,:);

testList22 = [BtestList22; NBtestList22];
testList22rand = testList22(randperm(6),:);

testList2 = [testList21rand; testList22rand];

%
%

BtestList31 = BtestList(11:12,:);
NBtestList31 = NBtestList(13:15,:);

testList31 = [BtestList31; NBtestList31];
testList31rand = testList31(randperm(5),:);

BtestList32 = BtestList(13:15,:);
NBtestList32 = NBtestList(16:18,:);

testList32 = [BtestList32; NBtestList32];
testList32rand = testList32(randperm(6),:);

testList3 = [testList31rand; testList32rand];

%
%

BtestList41 = BtestList(16:17,:);
NBtestList41 = NBtestList(19:21,:);

testList41 = [BtestList41; NBtestList41];
testList41rand = testList41(randperm(5),:);

BtestList42 = BtestList(18:20,:);
NBtestList42 = NBtestList(22:24,:);

testList42 = [BtestList42; NBtestList42];
testList42rand = testList42(randperm(6),:);

testList4 = [testList41rand; testList42rand];

%
%

BtestList51 = BtestList(21:22,:);
NBtestList51 = NBtestList(25:27,:);

testList51 = [BtestList51; NBtestList51];
testList51rand = testList51(randperm(5),:);

BtestList52 = BtestList(23:25,:);
NBtestList52 = NBtestList(28:30,:);

testList52 = [BtestList52; NBtestList52];
testList52rand = testList52(randperm(6),:);

testList5 = [testList51rand; testList52rand];

%
%

BtestList61 = BtestList(26:27,:);
NBtestList61 = NBtestList(31:33,:);

testList61 = [BtestList61; NBtestList61];
testList61rand = testList61(randperm(5),:);

BtestList62 = BtestList(28:30,:);
NBtestList62 = NBtestList(34:36,:);

testList62 = [BtestList62; NBtestList62];
testList62rand = testList62(randperm(6),:);

testList6 = [testList61rand; testList62rand];

%
%

BtestList71 = BtestList(31:32,:);
NBtestList71 = NBtestList(37:39,:);

testList71 = [BtestList71; NBtestList71];
testList71rand = testList71(randperm(5),:);

BtestList72 = BtestList(33:35,:);
NBtestList72 = NBtestList(40:42,:);

testList72 = [BtestList72; NBtestList72];
testList72rand = testList72(randperm(6),:);

testList7 = [testList71rand; testList72rand];

%
%

BtestList81 = BtestList(36:37,:);
NBtestList81 = NBtestList(43:45,:);

testList81 = [BtestList81; NBtestList81];
testList81rand = testList81(randperm(5),:);

BtestList82 = BtestList(38:40,:);
NBtestList82 = NBtestList(46:48,:);

testList82 = [BtestList82; NBtestList82];
testList82rand = testList82(randperm(6),:);

testList8 = [testList81rand; testList82rand];

%
%

BtestList91 = BtestList(41:42,:);
NBtestList91 = NBtestList(49:51,:);

testList91 = [BtestList91; NBtestList91];
testList91rand = testList91(randperm(5),:);

BtestList92 = BtestList(43:45,:);
NBtestList92 = NBtestList(52:54,:);

testList92 = [BtestList92; NBtestList92];
testList92rand = testList92(randperm(6),:);

testList9 = [testList91rand; testList92rand];

%
%

BtestList101 = BtestList(46:47,:);
NBtestList101 = NBtestList(55:57,:);

testList101 = [BtestList101; NBtestList101];
testList101rand = testList101(randperm(5),:);

BtestList102 = BtestList(48:50,:);
NBtestList102 = NBtestList(58:60,:);

testList102 = [BtestList102; NBtestList102];
testList102rand = testList102(randperm(6),:);

testList10 = [testList101rand; testList102rand];

%
%

BtestList111 = BtestList(51:52,:);
NBtestList111 = NBtestList(61:63,:);

testList111 = [BtestList111; NBtestList111];
testList111rand = testList111(randperm(5),:);

BtestList112 = BtestList(53:55,:);
NBtestList112 = NBtestList(64:66,:);

testList112 = [BtestList112; NBtestList112];
testList112rand = testList112(randperm(6),:);

testList11 = [testList111rand; testList112rand];

%
%

BtestList121 = BtestList(56:57,:);
NBtestList121 = NBtestList(67:69,:);

testList121 = [BtestList121; NBtestList121];
testList121rand = testList121(randperm(5),:);

BtestList122 = BtestList(58:60,:);
NBtestList122 = NBtestList(70:72,:);

testList122 = [BtestList122; NBtestList122];
testList122rand = testList122(randperm(6),:);

testList12 = [testList121rand; testList122rand];

%
%

BtestList131 = BtestList(61:62,:);
NBtestList131 = NBtestList(73:75,:);

testList131 = [BtestList131; NBtestList131];
testList131rand = testList131(randperm(5),:);

BtestList132 = BtestList(63:65,:);
NBtestList132 = NBtestList(76:78,:);

testList132 = [BtestList132; NBtestList132];
testList132rand = testList132(randperm(6),:);

testList13 = [testList131rand; testList132rand];

%
%

BtestList141 = BtestList(66:67,:);
NBtestList141 = NBtestList(79:81,:);

testList141 = [BtestList141; NBtestList141];
testList141rand = testList141(randperm(5),:);

BtestList142 = BtestList(68:70,:);
NBtestList142 = NBtestList(82:84,:);

testList142 = [BtestList142; NBtestList142];
testList142rand = testList142(randperm(6),:);

testList14 = [testList141rand; testList142rand];

%
%

BtestList151 = BtestList(71:72,:);
NBtestList151 = NBtestList(85:87,:);

testList151 = [BtestList151; NBtestList151];
testList151rand = testList151(randperm(5),:);

BtestList152 = BtestList(73:75,:);
NBtestList152 = NBtestList(88:90,:);

testList152 = [BtestList152; NBtestList152];
testList152rand = testList152(randperm(6),:);

testList15 = [testList151rand; testList152rand];

%
%

BtestList161 = BtestList(76:77,:);
NBtestList161 = NBtestList(91:93,:);

testList161 = [BtestList161; NBtestList161];
testList161rand = testList161(randperm(5),:);

BtestList162 = BtestList(78:80,:);
NBtestList162 = NBtestList(94:96,:);

testList162 = [BtestList162; NBtestList162];
testList162rand = testList162(randperm(6),:);

testList16 = [testList161rand; testList162rand];

new_items = 577:672;
new_items = new_items([randperm(96)]);
new_items_list = cell(96,6);


for inew = 1:96
new_items_list{inew,1}=[num2str(new_items(inew)) '.bmp'];
new_items_list{inew,2}=' ';
new_items_list{inew,3}=' ';
new_items_list{inew,4}=0;
new_items_list{inew,5}='N';
new_items_list{inew,6}=0;
end

testList1 = [testList1; new_items_list(1:6,:)];
testList1 = testList1(randperm(17),:);

testList2 = [testList2; new_items_list(7:12,:)];
testList2 = testList2(randperm(17),:);

testList3 = [testList3; new_items_list(13:18,:)];
testList3 = testList3(randperm(17),:);

testList4 = [testList4; new_items_list(19:24,:);];
testList4 = testList4(randperm(17),:);

testList5 = [testList5; new_items_list(25:30,:)];
testList5 = testList5(randperm(17),:);

testList6 = [testList6; new_items_list(31:36,:);];
testList6 = testList6(randperm(17),:);

testList7 = [testList7; new_items_list(37:42,:);];
testList7 = testList7(randperm(17),:);

testList8 = [testList8; new_items_list(43:48,:)];
testList8 = testList8(randperm(17),:);

testList9 = [testList9; new_items_list(49:54,:)];
testList9 = testList9(randperm(17),:);

testList10 = [testList10; new_items_list(55:60,:)];
testList10 = testList10(randperm(17),:);

testList11 = [testList11; new_items_list(61:66,:)];
testList11 = testList11(randperm(17),:);

testList12 = [testList12; new_items_list(67:72,:)];
testList12 = testList12(randperm(17),:);

testList13 = [testList13; new_items_list(73:78,:)];
testList13 = testList13(randperm(17),:);

testList14 = [testList14; new_items_list(79:84,:)];
testList14 = testList14(randperm(17),:);

testList15 = [testList15; new_items_list(85:90,:)];
testList15 = testList15(randperm(17),:);

testList16 = [testList16; new_items_list(91:96,:)];
testList16 = testList16(randperm(17),:);

testSeq = [testList1; testList2; ... 
    testList3; ...
    testList4; testList5; ... 
    testList6; testList7; ...
    testList8; testList9; ...
    testList10; testList11; ... 
    testList12; testList13; ... 
    testList14; testList15; ...
    testList16];

save(['testSeq_16block',num2str(isub)],'testSeq')

end





