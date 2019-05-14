%createTestSeq
%This script creates the retrieval test structure for MEGbound pilot
%01-04-2013.  First, it creates 3 source memory trials.  Then, It creates 8
%temporal order trials where subjects have to indicate intact order or
%rearranged order.  Half of the trials will be intact and half will be
%rearranged.

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
    
    BencodingColor = encodingSeq(cell2mat(encodingSeq(:,3))==1,4);
    
    
    Btest_neighbors_lures1 = [1 1 1 0 0]';
    Btest_neighbors_lures2 = [1 1 0 0 0]';
    NBtest_neighbors_lures = [1 1 1 0 0 0]';
    Btest_neighbors_lures_rand = [];
    NBtest_neighbors_lures_rand = [];
    
    for iperm = 1:16
        
        if mod(iperm,2)==0
            Btest_neighbors_lures_rand = [Btest_neighbors_lures_rand; Btest_neighbors_lures1(randperm(5))];
            NBtest_neighbors_lures_rand = [NBtest_neighbors_lures_rand; NBtest_neighbors_lures(randperm(6))];
        else
            Btest_neighbors_lures_rand = [Btest_neighbors_lures_rand; Btest_neighbors_lures2(randperm(5))];
            NBtest_neighbors_lures_rand = [NBtest_neighbors_lures_rand; NBtest_neighbors_lures(randperm(6))];
        end
        
    end
    
    
    NBtestList = [NBitem NBtoc NBtoi num2cell([ones(6,1); ones(6,1)*2; ones(6,1)*3; ones(6,1)*4; ones(6,1)*5; ones(6,1)*6; ones(6,1)*7; ones(6,1)*8; ones(6,1)*9; ones(6,1)*10; ones(6,1)*11; ones(6,1)*12; ones(6,1)*13; ones(6,1)*14; ones(6,1)*15; ones(6,1)*16]) repmat({'NB'},96,1) NBencodingColor num2cell(NBtest_neighbors_lures_rand)];
    
    BtestList = [Bitem Btoc Btoi num2cell([ones(5,1); ones(5,1)*2; ones(5,1)*3; ones(5,1)*4; ones(5,1)*5; ones(5,1)*6; ones(5,1)*7; ones(5,1)*8; ones(5,1)*9; ones(5,1)*10; ones(5,1)*11; ones(5,1)*12; ones(5,1)*13; ones(5,1)*14; ones(5,1)*15; ones(5,1)*16]) repmat({'B'},80,1) BencodingColor num2cell(Btest_neighbors_lures_rand)];
    
    
    NBsourceList = [];
    NBsource_idx = zeros(1,length(NBtestList));
    BsourceList = [];
    Bsource_idx = zeros(1,length(BtestList));
    
    for isource = 1:length(NBtestList)
        
        if NBtestList{isource,7}==2
            
            NBsourceList = [NBsourceList; NBtestList(isource,:)];
            NBsource_idx(isource) = 1;
            NBtestList{isource,7}=3;
            
        end
        
        
    end
    
    for isource = 1:length(BtestList)
        
        if BtestList{isource,7}==2
            
            BsourceList = [BsourceList; BtestList(isource,:)];
            Bsource_idx(isource) = 1;
            BtestList{isource,7}=3;
        end
        
        
    end
    
    % account for encoding time and randomize the test order
    
    BtestList11 = BtestList(1:2,:);
    NBtestList11 = NBtestList(1:3,:);
    
    testList11 = [BtestList11; NBtestList11];
    testList11rand = testList11(randperm(5),:);
    
    BtestList12 = BtestList(3:5,:);
    NBtestList12 = NBtestList(4:6,:);
    
    testList12 = [BtestList12; NBtestList12];
    testList12rand = testList12(randperm(6),:);
    
    %sourceList1 = [BsourceList(1,:); NBsourceList(1:2,:)];
    %sourceList1 = sourceList1(randperm(3),:);
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
    
    %     sourceList2 = [BsourceList(2,:); NBsourceList(3:4,:)];
    %     sourceList2 = sourceList2(randperm(3),:);
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
    
    %     sourceList3 = [BsourceList(3,:); NBsourceList(5:6,:)];
    %     sourceList3 = sourceList3(randperm(3),:);
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
    
    %     sourceList4 = [BsourceList(4,:); NBsourceList(7:8,:)];
    %     sourceList4 = sourceList4(randperm(3),:);
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
    
    %     sourceList5 = [BsourceList(5,:); NBsourceList(9:10,:)];
    %     sourceList5 = sourceList5(randperm(3),:);
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
    
    %     sourceList6 = [BsourceList(6,:); NBsourceList(11:12,:)];
    %     sourceList6 = sourceList6(randperm(3),:);
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
    
    %     sourceList7 = [BsourceList(7,:); NBsourceList(13:14,:)];
    %     sourceList7 = sourceList7(randperm(3),:);
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
    
    %     sourceList8 = [BsourceList(8,:); NBsourceList(15:16,:)];
    %     sourceList8 = sourceList8(randperm(3),:);
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
    
    %     sourceList9 = [BsourceList(9,:); NBsourceList(17:18,:)];
    %     sourceList9 = sourceList9(randperm(3),:);
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
    
    %     sourceList10 = [BsourceList(10,:); NBsourceList(19:20,:)];
    %     sourceList10 = sourceList10(randperm(3),:);
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
    
    %     sourceList11 = [BsourceList(11,:); NBsourceList(21:22,:)];
    %     sourceList11 = sourceList11(randperm(3),:);
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
    
    %     sourceList12 = [BsourceList(12,:); NBsourceList(23:24,:)];
    %     sourceList12 = sourceList12(randperm(3),:);
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
    
    %     sourceList13 = [BsourceList(13,:); NBsourceList(25:26,:)];
    %     sourceList13 = sourceList13(randperm(3),:);
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
    
    %     sourceList14 = [BsourceList(14,:); NBsourceList(27:28,:)];
    %     sourceList14 = sourceList14(randperm(3),:);
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
    
    %     sourceList15 = [BsourceList(15,:); NBsourceList(29:30,:)];
    %     sourceList15 = sourceList15(randperm(3),:);
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
    
    %     sourceList16 = [BsourceList(16,:); NBsourceList(31:32,:)];
    %     sourceList16 = sourceList16(randperm(3),:);
    testList16 = [testList161rand; testList162rand];
    
    
    %%%%%%%%%%%
    Btest_neighbors_lures1 = [1 1 1 0 0]';
    Btest_neighbors_lures2 = [1 1 0 0 0]';
    NBtest_neighbors_lures = [1 1 1 0 0 0]';
    Btest_neighbors_lures_rand = [];
    NBtest_neighbors_lures_rand = [];
    
    for iperm = 1:16
        
        if mod(iperm,2)==0
            Btest_neighbors_lures_rand = [Btest_neighbors_lures_rand; Btest_neighbors_lures1(randperm(5))];
            NBtest_neighbors_lures_rand = [NBtest_neighbors_lures_rand; NBtest_neighbors_lures(randperm(6))];
        else
            Btest_neighbors_lures_rand = [Btest_neighbors_lures_rand; Btest_neighbors_lures2(randperm(5))];
            NBtest_neighbors_lures_rand = [NBtest_neighbors_lures_rand; NBtest_neighbors_lures(randperm(6))];
        end
        
    end
    
    
    NBtestList = [NBitem NBtoc NBtoi num2cell([ones(6,1); ones(6,1)*2; ones(6,1)*3; ones(6,1)*4; ones(6,1)*5; ones(6,1)*6; ones(6,1)*7; ones(6,1)*8; ones(6,1)*9; ones(6,1)*10; ones(6,1)*11; ones(6,1)*12; ones(6,1)*13; ones(6,1)*14; ones(6,1)*15; ones(6,1)*16]) repmat({'NB'},96,1) NBencodingColor num2cell(NBtest_neighbors_lures_rand)];
    
    BtestList = [Bitem Btoc Btoi num2cell([ones(5,1); ones(5,1)*2; ones(5,1)*3; ones(5,1)*4; ones(5,1)*5; ones(5,1)*6; ones(5,1)*7; ones(5,1)*8; ones(5,1)*9; ones(5,1)*10; ones(5,1)*11; ones(5,1)*12; ones(5,1)*13; ones(5,1)*14; ones(5,1)*15; ones(5,1)*16]) repmat({'B'},80,1) BencodingColor num2cell(Btest_neighbors_lures_rand)];
    
    
    NBsourceList = [];
    NBsource_idx = zeros(1,length(NBtestList));
    BsourceList = [];
    Bsource_idx = zeros(1,length(BtestList));
    
    for isource = 1:length(NBtestList)
        
        if NBtestList{isource,7}==2
            
            NBsourceList = [NBsourceList; NBtestList(isource,:)];
            NBsource_idx(isource) = 1;
            NBtestList{isource,7}=3;
            
        end
        
        
    end
    
    for isource = 1:length(BtestList)
        
        if BtestList{isource,7}==2
            
            BsourceList = [BsourceList; BtestList(isource,:)];
            Bsource_idx(isource) = 1;
            BtestList{isource,7}=3;
        end
        
        
    end
    
    
    
    
    BtestList11b = BtestList(1:2,:);
    NBtestList11b = NBtestList(1:3,:);
    
    testList11b = [BtestList11b; NBtestList11b];
    testList11brand = testList11b(randperm(5),:);
    
    BtestList12 = BtestList(3:5,:);
    NBtestList12 = NBtestList(4:6,:);
    
    testList12b = [BtestList12; NBtestList12];
    testList12brand = testList12b(randperm(6),:);
    
    %sourceList1 = [BsourceList(1,:); NBsourceList(1:2,:)];
    %sourceList1 = sourceList1(randperm(3),:);
    testList11a = [testList11brand; testList12brand];
    
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
    
    %     sourceList2 = [BsourceList(2,:); NBsourceList(3:4,:)];
    %     sourceList2 = sourceList2(randperm(3),:);
    testList21 = [testList21rand; testList22rand];
    
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
    
    %     sourceList3 = [BsourceList(3,:); NBsourceList(5:6,:)];
    %     sourceList3 = sourceList3(randperm(3),:);
    testList31 = [testList31rand; testList32rand];
    
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
    
    %     sourceList4 = [BsourceList(4,:); NBsourceList(7:8,:)];
    %     sourceList4 = sourceList4(randperm(3),:);
    testList41 = [testList41rand; testList42rand];
    
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
    
    %     sourceList5 = [BsourceList(5,:); NBsourceList(9:10,:)];
    %     sourceList5 = sourceList5(randperm(3),:);
    testList51 = [testList51rand; testList52rand];
    
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
    
    %     sourceList6 = [BsourceList(6,:); NBsourceList(11:12,:)];
    %     sourceList6 = sourceList6(randperm(3),:);
    testList61 = [testList61rand; testList62rand];
    
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
    
    %     sourceList7 = [BsourceList(7,:); NBsourceList(13:14,:)];
    %     sourceList7 = sourceList7(randperm(3),:);
    testList71 = [testList71rand; testList72rand];
    
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
    
    %     sourceList8 = [BsourceList(8,:); NBsourceList(15:16,:)];
    %     sourceList8 = sourceList8(randperm(3),:);
    testList81 = [testList81rand; testList82rand];
    
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
    
    %     sourceList9 = [BsourceList(9,:); NBsourceList(17:18,:)];
    %     sourceList9 = sourceList9(randperm(3),:);
    testList91 = [testList91rand; testList92rand];
    
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
    
    %     sourceList10 = [BsourceList(10,:); NBsourceList(19:20,:)];
    %     sourceList10 = sourceList10(randperm(3),:);
    testList101 = [testList101rand; testList102rand];
    
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
    
    %     sourceList11 = [BsourceList(11,:); NBsourceList(21:22,:)];
    %     sourceList11 = sourceList11(randperm(3),:);
    testList111 = [testList111rand; testList112rand];
    
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
    
    %     sourceList12 = [BsourceList(12,:); NBsourceList(23:24,:)];
    %     sourceList12 = sourceList12(randperm(3),:);
    testList121 = [testList121rand; testList122rand];
    
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
    
    %     sourceList13 = [BsourceList(13,:); NBsourceList(25:26,:)];
    %     sourceList13 = sourceList13(randperm(3),:);
    testList131 = [testList131rand; testList132rand];
    
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
    
    %     sourceList14 = [BsourceList(14,:); NBsourceList(27:28,:)];
    %     sourceList14 = sourceList14(randperm(3),:);
    testList141 = [testList141rand; testList142rand];
    
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
    
    %     sourceList15 = [BsourceList(15,:); NBsourceList(29:30,:)];
    %     sourceList15 = sourceList15(randperm(3),:);
    testList151 = [testList151rand; testList152rand];
    
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
    
    %     sourceList16 = [BsourceList(16,:); NBsourceList(31:32,:)];
    %     sourceList16 = sourceList16(randperm(3),:);
    testList161 = [testList161rand; testList162rand];
    
    testSeq = [testList1; testList11a; testList2; testList21;...
        testList3; testList31;...
        testList4; testList41; testList5; testList51;...
        testList6; testList61; testList7; testList71;...
        testList8; testList81; testList9; testList91;...
        testList10; testList101; testList11; testList111;...
        testList12; testList121; testList13; testList131;...
        testList14; testList141; testList15; testList151;...
        testList16; testList161];
    
    colorOrder1 = unique(cell2mat(encodingSeq(1:33,4)),'stable');
    colorOrder2 = unique(cell2mat(encodingSeq(34:66,4)),'stable');
    colorOrder3 = unique(cell2mat(encodingSeq(67:99,4)),'stable');
    colorOrder4 = unique(cell2mat(encodingSeq(100:132,4)),'stable');
    colorOrder5 = unique(cell2mat(encodingSeq(133:165,4)),'stable');
    colorOrder6 = unique(cell2mat(encodingSeq(166:198,4)),'stable');
    colorOrder7 = unique(cell2mat(encodingSeq(199:231,4)),'stable');
    colorOrder8 = unique(cell2mat(encodingSeq(232:264,4)),'stable');
    colorOrder9 = unique(cell2mat(encodingSeq(265:297,4)),'stable');
    colorOrder10 = unique(cell2mat(encodingSeq(298:330,4)),'stable');
    colorOrder11= unique(cell2mat(encodingSeq(331:363,4)),'stable');
    colorOrder12 = unique(cell2mat(encodingSeq(364:396,4)),'stable');
    colorOrder13 = unique(cell2mat(encodingSeq(397:429,4)),'stable');
    colorOrder14 = unique(cell2mat(encodingSeq(430:462,4)),'stable');
    colorOrder15 = unique(cell2mat(encodingSeq(463:495,4)),'stable');
    colorOrder16 = unique(cell2mat(encodingSeq(496:528,4)),'stable');
    
    colorOrderQ1 = [colorOrder1; colorOrder2; colorOrder3; colorOrder4];
    colorOrderQ2 = [colorOrder5; colorOrder6; colorOrder7; colorOrder8];
    colorOrderQ3 = [colorOrder9; colorOrder10; colorOrder11; colorOrder12];
    colorOrderQ4 = [colorOrder13; colorOrder14; colorOrder15; colorOrder16];
    
    BcolorLurePosition1Array = [1 1 1 1];
    NBcolorLurePosition1Array = [1 1 1 1];
    
    BcolorLurePosition2Array = [1 -1 1 -1];
    NBcolorLurePosition2Array = [1 -1 1 -1];
    
    BcolorLurePosition3Array = [1 -1 1 -1];
    NBcolorLurePosition3Array = [1 -1 1 -1];
    
    BcolorLurePosition4Array = [1 -1 1 -1];
    NBcolorLurePosition4Array = [1 -1 1 -1];
    
    BcolorLurePosition5Array = [1 -1 1 -1];
    NBcolorLurePosition5Array = [1 -1 1 -1];
    
    BcolorLurePosition6Array = [-1 -1 -1 -1];
    NBcolorLurePosition6Array = [-1 -1 -1 -1];
    
    BcolorLurePositionVec = [];
    NBcolorLurePositionVec = [];
    BLureColorVec = [];
    NBLureColorVec = [];
    
    for iColorCB = 1:4
        
        tmp = [];
        correntColorOrder = [];
        blockCounter = [0 4 8 12];
        
        trialCounter = 1;
        BcolorPosition = [];
        NBcolorPosition = [];
        BcontextColor = [];
        NBcontextColor = [];
        
        for iList = 1:4
            
            
            eval(['tmp = [tmp; testList' num2str(blockCounter(iColorCB)+iList) '];'])
            eval(['currentColorOrder = colorOrderQ' num2str(iColorCB) ';'])
            
            
        end
        
        BcolorLurePosition1ArrayShuffled = BcolorLurePosition1Array(randperm(4));
        NBcolorLurePosition1ArrayShuffled = NBcolorLurePosition1Array(randperm(4));
        
        BcolorLurePosition2ArrayShuffled = BcolorLurePosition2Array(randperm(4));
        NBcolorLurePosition2ArrayShuffled = NBcolorLurePosition2Array(randperm(4));
        
        BcolorLurePosition3ArrayShuffled = BcolorLurePosition3Array(randperm(4));
        NBcolorLurePosition3ArrayShuffled = NBcolorLurePosition3Array(randperm(4));
        
        BcolorLurePosition4ArrayShuffled = BcolorLurePosition4Array(randperm(4));
        NBcolorLurePosition4ArrayShuffled = NBcolorLurePosition4Array(randperm(4));
        
        BcolorLurePosition5ArrayShuffled = BcolorLurePosition5Array(randperm(4));
        NBcolorLurePosition5ArrayShuffled = NBcolorLurePosition5Array(randperm(4));
        
        BcolorLurePosition6ArrayShuffled = BcolorLurePosition6Array(randperm(4));
        NBcolorLurePosition6ArrayShuffled = NBcolorLurePosition6Array(randperm(4));
        
        
        blockCounter = 1;
        trialCounter = 1;
        BcolorPosition = [];
        NBcolorPosition = [];
        BcontextColor = [];
        NBcontextColor = [];
        B1_counter = 1;
        B2_counter = 1;
        B3_counter = 1;
        B4_counter = 1;
        B5_counter = 1;
        B6_counter = 1;
        NB1_counter = 1;
        NB2_counter = 1;
        NB3_counter = 1;
        NB4_counter = 1;
        NB5_counter = 1;
        NB6_counter = 1;
        BcolorLurePosition = [];
        NBcolorLurePosition = [];
        BLureColor = [];
        NBLureColor = [];
        
        for itrial = 1:44
            
            colorPos = mod(find(tmp{itrial,6}==currentColorOrder),6);
            if colorPos==0
                colorPos=6;
            end
            
            
            if strcmp(tmp{itrial,5},'B')
                
                BcontextColor(length(BcontextColor)+1) =  tmp{itrial,6};
                BcolorPosition(length(BcolorPosition)+1) = colorPos;
                
                if BcolorPosition(length(BcolorPosition))==1
                    
                    BcolorLurePosition(length(BcontextColor))= BcolorLurePosition1ArrayShuffled(B1_counter);
                    BLureColor(length(BcontextColor))= currentColorOrder(find(currentColorOrder==BcontextColor(length(BcolorLurePosition)))+BcolorLurePosition(length(BcontextColor)));
                    B1_counter = B1_counter + 1;
                    
                elseif BcolorPosition(length(BcolorPosition))==2
                    
                    BcolorLurePosition(length(BcontextColor))= BcolorLurePosition2ArrayShuffled(B2_counter);
                    BLureColor(length(BcontextColor))= currentColorOrder(find(currentColorOrder==BcontextColor(length(BcolorLurePosition)))+BcolorLurePosition(length(BcontextColor)));
                    B2_counter = B2_counter + 1;
                    
                elseif BcolorPosition(length(BcolorPosition))==3
                    
                    BcolorLurePosition(length(BcontextColor))= BcolorLurePosition3ArrayShuffled(B3_counter);
                    BLureColor(length(BcontextColor))= currentColorOrder(find(currentColorOrder==BcontextColor(length(BcolorLurePosition)))+BcolorLurePosition(length(BcontextColor)));
                    B3_counter = B3_counter + 1;
                    
                elseif BcolorPosition(length(BcolorPosition))==4
                    
                    BcolorLurePosition(length(BcontextColor))= BcolorLurePosition4ArrayShuffled(B4_counter);
                    BLureColor(length(BcontextColor))= currentColorOrder(find(currentColorOrder==BcontextColor(length(BcolorLurePosition)))+BcolorLurePosition(length(BcontextColor)));
                    B4_counter = B4_counter + 1;
                    
                elseif BcolorPosition(length(BcolorPosition))==5
                    
                    BcolorLurePosition(length(BcontextColor))= BcolorLurePosition5ArrayShuffled(B5_counter);
                    BLureColor(length(BcontextColor))= currentColorOrder(find(currentColorOrder==BcontextColor(length(BcolorLurePosition)))+BcolorLurePosition(length(BcontextColor)));
                    B5_counter = B5_counter + 1;
                    
                elseif BcolorPosition(length(BcolorPosition))==6
                    
                    BcolorLurePosition(length(BcontextColor))= BcolorLurePosition6ArrayShuffled(B6_counter);
                    BLureColor(length(BcontextColor))= currentColorOrder(find(currentColorOrder==BcontextColor(length(BcolorLurePosition)))+BcolorLurePosition(length(BcontextColor)));
                    B6_counter = B6_counter + 1;
                    
                end
                
            end
            
            
            if strcmp(tmp{itrial,5},'NB')
                
                NBcontextColor(length(NBcontextColor)+1) =  tmp{itrial,6};
                NBcolorPosition(length(NBcolorPosition)+1) = colorPos;
                
                if NBcolorPosition(length(NBcolorPosition))==1
                    
                    NBcolorLurePosition(length(NBcontextColor))= NBcolorLurePosition1ArrayShuffled(NB1_counter);
                    NBLureColor(length(NBcontextColor))= currentColorOrder(find(currentColorOrder==NBcontextColor(length(NBcolorLurePosition)))+NBcolorLurePosition(length(NBcontextColor)));
                    NB1_counter = NB1_counter + 1;
                    
                elseif NBcolorPosition(length(NBcolorPosition))==2
                    
                    NBcolorLurePosition(length(NBcontextColor))= NBcolorLurePosition2ArrayShuffled(NB2_counter);
                    NBLureColor(length(NBcontextColor))= currentColorOrder(find(currentColorOrder==NBcontextColor(length(NBcolorLurePosition)))+NBcolorLurePosition(length(NBcontextColor)));
                    NB2_counter = NB2_counter + 1;
                    
                elseif NBcolorPosition(length(NBcolorPosition))==3
                    
                    NBcolorLurePosition(length(NBcontextColor))= NBcolorLurePosition3ArrayShuffled(NB3_counter);
                    NBLureColor(length(NBcontextColor))= currentColorOrder(find(currentColorOrder==NBcontextColor(length(NBcolorLurePosition)))+NBcolorLurePosition(length(NBcontextColor)));
                    NB3_counter = NB3_counter + 1;
                    
                elseif NBcolorPosition(length(NBcolorPosition))==4
                    
                    NBcolorLurePosition(length(NBcontextColor))= NBcolorLurePosition4ArrayShuffled(NB4_counter);
                    NBLureColor(length(NBcontextColor))= currentColorOrder(find(currentColorOrder==NBcontextColor(length(NBcolorLurePosition)))+NBcolorLurePosition(length(NBcontextColor)));
                    NB4_counter = NB4_counter + 1;
                    
                elseif NBcolorPosition(length(NBcolorPosition))==5
                    
                    NBcolorLurePosition(length(NBcontextColor))= NBcolorLurePosition5ArrayShuffled(NB5_counter);
                    NBLureColor(length(NBcontextColor))= currentColorOrder(find(currentColorOrder==NBcontextColor(length(NBcolorLurePosition)))+NBcolorLurePosition(length(NBcontextColor)));
                    NB5_counter = NB5_counter + 1;
                    
                elseif NBcolorPosition(length(NBcolorPosition))==6
                    
                    NBcolorLurePosition(length(NBcontextColor))= NBcolorLurePosition6ArrayShuffled(NB6_counter);
                    NBLureColor(length(NBcontextColor))= currentColorOrder(find(currentColorOrder==NBcontextColor(length(NBcolorLurePosition)))+NBcolorLurePosition(length(NBcontextColor)));
                    NB6_counter = NB6_counter + 1;
                    
                end
                
            end
            
            
            
        end
        
        BcolorLurePositionVec = [BcolorLurePositionVec; BcolorLurePosition];
        NBcolorLurePositionVec = [NBcolorLurePositionVec; NBcolorLurePosition];
        BLureColorVec = [BLureColorVec; BLureColor];
        NBLureColorVec = [NBLureColorVec; NBLureColor];
    end
    
    
    BcolorLurePositionVec = reshape(BcolorLurePositionVec',80,1);
    NBcolorLurePositionVec = reshape(NBcolorLurePositionVec',96,1);
    BLureColorVec = reshape(BLureColorVec',80,1);
    NBLureColorVec = reshape(NBLureColorVec',96,1);
    
    B_counter = 1;
    NB_counter = 1;
    
    
    for iTest = 1:16
        
        eval(['tmp = testList' num2str(iTest) ';'])
        
        for iLure = 1:11
            
            if strcmp(tmp{iLure,5},'B')
                
                tmp{iLure,8}= BcolorLurePositionVec(B_counter);
                tmp{iLure,9}= BLureColorVec(B_counter);
                B_counter = B_counter +1;
                
            end
            
            if strcmp(tmp{iLure,5},'NB')
                
                tmp{iLure,8}= NBcolorLurePositionVec(NB_counter);
                tmp{iLure,9}= NBLureColorVec(NB_counter);
                NB_counter = NB_counter +1;
                
            end
            
        end
        
        eval(['testList' num2str(iTest) '=tmp;'])
        
        
    end
    
    testSeq = [testList1; [testList11a num2cell(zeros(11,1)) num2cell(zeros(11,1))]; testList2; [testList21 num2cell(zeros(11,1)) num2cell(zeros(11,1))];...
        testList3; [testList31 num2cell(zeros(11,1)) num2cell(zeros(11,1))];...
        testList4; [testList41 num2cell(zeros(11,1)) num2cell(zeros(11,1))]; testList5; [testList51 num2cell(zeros(11,1)) num2cell(zeros(11,1))];...
        testList6; [testList61 num2cell(zeros(11,1)) num2cell(zeros(11,1))]; testList7; [testList71 num2cell(zeros(11,1)) num2cell(zeros(11,1))];...
        testList8; [testList81 num2cell(zeros(11,1)) num2cell(zeros(11,1))]; testList9; [testList91 num2cell(zeros(11,1)) num2cell(zeros(11,1))];...
        testList10; [testList101 num2cell(zeros(11,1)) num2cell(zeros(11,1))]; testList11; [testList111 num2cell(zeros(11,1)) num2cell(zeros(11,1))];...
        testList12; [testList121 num2cell(zeros(11,1)) num2cell(zeros(11,1))]; testList13; [testList131 num2cell(zeros(11,1)) num2cell(zeros(11,1))];...
        testList14; [testList141 num2cell(zeros(11,1)) num2cell(zeros(11,1))]; testList15; [testList151 num2cell(zeros(11,1)) num2cell(zeros(11,1))];...
        testList16; [testList161 num2cell(zeros(11,1)) num2cell(zeros(11,1))]];
    
    
    
    testSeq_tmp1 = testSeq(:,7);
    testSeq_tmp2 = testSeq(:,8);
    testSeq_tmp3 = testSeq(:,9);
    
    testSeq(:,7)=testSeq_tmp3;
    testSeq(:,9)=testSeq_tmp2;
    testSeq(:,8)=testSeq_tmp1;
    
    save(['testSeq_16block_V7_',num2str(isub)],'testSeq')
    
end