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
    
    
    Btest_neighbors_lures = [2 1 1 0 0]';
    NBtest_neighbors_lures = [2 2 1 1 0 0]';
    Btest_neighbors_lures_rand = [];
    NBtest_neighbors_lures_rand = [];
    
    for iperm = 1:16
        
        Btest_neighbors_lures_rand = [Btest_neighbors_lures_rand; Btest_neighbors_lures(randperm(5))];
        NBtest_neighbors_lures_rand = [NBtest_neighbors_lures_rand; NBtest_neighbors_lures(randperm(6))];
        
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
    
    sourceList1 = [BsourceList(1,:); NBsourceList(1:2,:)];
    sourceList1 = sourceList1(randperm(3),:);
    testList1 = [sourceList1;  testList11rand; testList12rand];
    
    
    
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
    
    sourceList2 = [BsourceList(2,:); NBsourceList(3:4,:)];
    sourceList2 = sourceList2(randperm(3),:);
    testList2 = [sourceList2; testList21rand; testList22rand];
    
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
    
    sourceList3 = [BsourceList(3,:); NBsourceList(5:6,:)];
    sourceList3 = sourceList3(randperm(3),:);
    testList3 = [sourceList3; testList31rand; testList32rand];
    
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
    
    sourceList4 = [BsourceList(4,:); NBsourceList(7:8,:)];
    sourceList4 = sourceList4(randperm(3),:);
    testList4 = [sourceList4; testList41rand; testList42rand];
    
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
    
    sourceList5 = [BsourceList(5,:); NBsourceList(9:10,:)];
    sourceList5 = sourceList5(randperm(3),:);
    testList5 = [sourceList5; testList51rand; testList52rand];
    
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
    
    sourceList6 = [BsourceList(6,:); NBsourceList(11:12,:)];
    sourceList6 = sourceList6(randperm(3),:);
    testList6 = [sourceList6; testList61rand; testList62rand];
    
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
    
    sourceList7 = [BsourceList(7,:); NBsourceList(13:14,:)];
    sourceList7 = sourceList7(randperm(3),:);
    testList7 = [sourceList7; testList71rand; testList72rand];
    
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
    
    sourceList8 = [BsourceList(8,:); NBsourceList(15:16,:)];
    sourceList8 = sourceList8(randperm(3),:);
    testList8 = [sourceList8; testList81rand; testList82rand];
    
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
    
    sourceList9 = [BsourceList(9,:); NBsourceList(17:18,:)];
    sourceList9 = sourceList9(randperm(3),:);
    testList9 = [sourceList9; testList91rand; testList92rand];
    
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
    
    sourceList10 = [BsourceList(10,:); NBsourceList(19:20,:)];
    sourceList10 = sourceList10(randperm(3),:);
    testList10 = [sourceList10; testList101rand; testList102rand];
    
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
    
    sourceList11 = [BsourceList(11,:); NBsourceList(21:22,:)];
    sourceList11 = sourceList11(randperm(3),:);
    testList11 = [sourceList11; testList111rand; testList112rand];
    
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
    
    sourceList12 = [BsourceList(12,:); NBsourceList(23:24,:)];
    sourceList12 = sourceList12(randperm(3),:);
    testList12 = [sourceList12; testList121rand; testList122rand];
    
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
    
    sourceList13 = [BsourceList(13,:); NBsourceList(25:26,:)];
    sourceList13 = sourceList13(randperm(3),:);
    testList13 = [sourceList13; testList131rand; testList132rand];
    
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
    
    sourceList14 = [BsourceList(14,:); NBsourceList(27:28,:)];
    sourceList14 = sourceList14(randperm(3),:);
    testList14 = [sourceList14; testList141rand; testList142rand];
    
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
    
    sourceList15 = [BsourceList(15,:); NBsourceList(29:30,:)];
    sourceList15 = sourceList15(randperm(3),:);
    testList15 = [sourceList15; testList151rand; testList152rand];
    
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
    
    sourceList16 = [BsourceList(16,:); NBsourceList(31:32,:)];
    sourceList16 = sourceList16(randperm(3),:);
    testList16 = [sourceList16; testList161rand; testList162rand];
    
    % new_items = 577:672;
    % new_items = new_items([randperm(96)]);
    % new_items_list = cell(96,6);
    %
    %
    % for inew = 1:96
    % new_items_list{inew,1}=[num2str(new_items(inew)) '.bmp'];
    % new_items_list{inew,2}=' ';
    % new_items_list{inew,3}=' ';
    % new_items_list{inew,4}=0;
    % new_items_list{inew,5}='N';
    % new_items_list{inew,6}=0;
    % end
    %
    % testList1 = [testList1; new_items_list(1:6,:)];
    % testList1 = testList1(randperm(17),:);
    %
    % testList2 = [testList2; new_items_list(7:12,:)];
    % testList2 = testList2(randperm(17),:);
    %
    % testList3 = [testList3; new_items_list(13:18,:)];
    % testList3 = testList3(randperm(17),:);
    %
    % testList4 = [testList4; new_items_list(19:24,:);];
    % testList4 = testList4(randperm(17),:);
    %
    % testList5 = [testList5; new_items_list(25:30,:)];
    % testList5 = testList5(randperm(17),:);
    %
    % testList6 = [testList6; new_items_list(31:36,:);];
    % testList6 = testList6(randperm(17),:);
    %
    % testList7 = [testList7; new_items_list(37:42,:);];
    % testList7 = testList7(randperm(17),:);
    %
    % testList8 = [testList8; new_items_list(43:48,:)];
    % testList8 = testList8(randperm(17),:);
    %
    % testList9 = [testList9; new_items_list(49:54,:)];
    % testList9 = testList9(randperm(17),:);
    %
    % testList10 = [testList10; new_items_list(55:60,:)];
    % testList10 = testList10(randperm(17),:);
    %
    % testList11 = [testList11; new_items_list(61:66,:)];
    % testList11 = testList11(randperm(17),:);
    %
    % testList12 = [testList12; new_items_list(67:72,:)];
    % testList12 = testList12(randperm(17),:);
    %
    % testList13 = [testList13; new_items_list(73:78,:)];
    % testList13 = testList13(randperm(17),:);
    %
    % testList14 = [testList14; new_items_list(79:84,:)];
    % testList14 = testList14(randperm(17),:);
    %
    % testList15 = [testList15; new_items_list(85:90,:)];
    % testList15 = testList15(randperm(17),:);
    %
    % testList16 = [testList16; new_items_list(91:96,:)];
    % testList16 = testList16(randperm(17),:);
    
    testSeq = [testList1; testList2; ...
        testList3; ...
        testList4; testList5; ...
        testList6; testList7; ...
        testList8; testList9; ...
        testList10; testList11; ...
        testList12; testList13; ...
        testList14; testList15; ...
        testList16];
    
    % removeThese = cell2mat(testSeq(:,7))==3;
    % testSeqtmp = [];
    %
    % for iremove = 1:length(testSeq)
    %
    %     if removeThese(iremove)==0
    %
    %         testSeqtmp = [testSeqtmp; testSeq(iremove,:)];
    %
    %     end
    %
    % end
    %
    % testSeq = testSeqtmp;
    
    Bsource_TO_idx = cell2mat(testSeq(:,7))==3&strcmpi('B',testSeq(:,5));
    NBsource_TO_idx = cell2mat(testSeq(:,7))==3&strcmpi('NB',testSeq(:,5));
    Bvec = [1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0];
    NBvec = [ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    Bvec = Bvec(:,randperm(16));
    NBvec = NBvec(:,randperm(32));
    Bcounter = 1;
    NBcounter = 1;
    %add code here that changes the 3's into 0 and 1's.
    for iagain = 1:length(testSeq)
        
        if Bsource_TO_idx(iagain)==1
            
            testSeq{iagain,7}=Bvec(Bcounter);
            Bcounter = Bcounter+1;
            
        end
        
        if NBsource_TO_idx(iagain)==1
            
            testSeq{iagain,7}=NBvec(NBcounter);
            NBcounter = NBcounter+1;
            
        end
        
    end
    
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
    
    for iseq = 1:length(testSeq)
        
        if testSeq{iseq,4}==1&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder1(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder1(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==2&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder2(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder2(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==3&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder3(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder3(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==4&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder4(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder4(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==5&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder5(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder5(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==6&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder6(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder6(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==7&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder7(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder7(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==8&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder8(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder8(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==9&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder9(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder9(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==10&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder10(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder10(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==11&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder11(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder11(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==12&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder12(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder12(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==13&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder13(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder13(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==14&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder14(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder14(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==15&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder15(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder15(randNum);
                
            end
            
        end
        
        if testSeq{iseq,4}==16&&testSeq{iseq,7}==2
            
            randNum = randperm(6,1);
            testSeq{iseq,8}= colorOrder16(randNum);
            
            while testSeq{iseq,6}==testSeq{iseq,8}||abs(testSeq{iseq,6}-testSeq{iseq,8})<=3
                
                randNum = randperm(6,1);
                testSeq{iseq,8}= colorOrder16(randNum);
                
            end
            
        end
        
    end
    
    testSeq_tmp1 = testSeq(:,7);
    testSeq_tmp2 = testSeq(:,8);
    
    testSeq(:,7)=testSeq_tmp2;
    testSeq(:,8)=testSeq_tmp1;
    
    save(['testSeq_16block_V6_',num2str(isub)],'testSeq')
    
end





