% this function takes the bdf-file from the TCP EEG study and gives out the
% codes and associated sample points for the whole test epoch (which is
% always the first (pleasantness judgment) and second exemplar (memory judgment) in each pair)
% Matthias Gruber July 2010


function [trl, event] = trialfun_whole_test_epoch_TCP(cfg)



% read the header information and the events from the data
% this should always be done using the generic read_header
% and read_event functions
hdr   = read_header(cfg.dataset);
event = read_event(cfg.dataset); %add again when everyhting is copied in
% here

% search for "STATUS" events
triggers = [event(find(strcmp('STATUS', {event.type}))).value]';

% add
sample   = [event(find(strcmp('STATUS', {event.type}))).sample]';

triggers_samples(:,1) = triggers(:,1);
triggers_samples(:,2) = sample(:,1);

% determine the number of samples before and after the trigger
% pretrig  = -cfg.trialdef.pre  * hdr.Fs;
% posttrig =  cfg.trialdef.post * hdr.Fs;

% determine the number of samples before and after the trigger (1024 Hz sampling rate)
% pretrig  = -512; %  512 sampling points =   500 ms
% posttrig = 6656; % 6656 sampling points =  6500 ms

pretrig  = -1024; %  512 sampling points =   500 ms
posttrig = 4096; % 6656 sampling points =  6500 ms

%%% After running the following codes, two variables (i.e., mod_triggers" will
%%% and "mod_sample) will be generated. These two variables will contain the modified trigger and sample codes, respectively, excluding 
%%% non-paired trigger and sample codes.
%%% Frank (2010-7-23)

tmp_trig1 = find(triggers > 100 & triggers < 1000);

RT.PN.New.R = 0;
RT.PN.New.K = 0;
RT.PN.New.N = 0;
RT.PN.CT.R  = 0;
RT.PN.CT.K  = 0;
RT.PN.CT.N  = 0;
RT.PN.ICT.R = 0;
RT.PN.ICT.K = 0;
RT.PN.ICT.N = 0;
RT.M.New.R  = 0;
RT.M.New.K  = 0;
RT.M.New.N  = 0;
RT.M.CT.R   = 0;
RT.M.CT.K   = 0;
RT.M.CT.N   = 0;
RT.M.ICT.R  = 0;
RT.M.ICT.K  = 0;
RT.M.ICT.N  = 0;

PN_RT        = 0;
M_RT         = 0;
PN_RT_CTR    = 0;
M_RT_CTR     = 0;
PN_RT_CTK    = 0;
M_RT_CTK     = 0;
PN_RT_CTN    = 0;
M_RT_CTN     = 0;
PN_RT_ICTR   = 0;
M_RT_ICTR    = 0;
PN_RT_ICTK   = 0;
M_RT_ICTK    = 0;
PN_RT_ICTN   = 0;
M_RT_ICTN    = 0;
PN_RT_NewR   = 0;
M_RT_NewR    = 0;
PN_RT_NewK   = 0;
M_RT_NewK    = 0;
PN_RT_NewN   = 0;
M_RT_NewN    = 0;

for i = 1:length(tmp_trig1)
    if triggers(tmp_trig1(i)) < 200 && triggers(tmp_trig1(i)+1) > 2
        tmp_trig2(i) = 99;
        tmp_sample(i) = NaN;
    elseif triggers(tmp_trig1(i)) > 200 && triggers(tmp_trig1(i)+1) > 3
        tmp_trig2(i) = 999;
        tmp_sample(i) = NaN;
    else
        tmp_trig2(i) = triggers(tmp_trig1(i)+1);
        tmp_sample(i) = sample(tmp_trig1(i)+1);
    end
end

final_test_triggers = [triggers(tmp_trig1) tmp_trig2'];
final_test_sample = [sample(tmp_trig1) tmp_sample'];


counter = 0;
tmp = [];
for i = 1:length(final_test_triggers)
    if i == 1
        tmp_col1 = final_test_triggers(i,1);
        tmp_col2 = final_test_triggers(i,2);
        tmp_sam1 = final_test_sample(i,1);
        tmp_sam2 = final_test_sample(i,2);
        continue;
    end
    
    if final_test_triggers(i) == final_test_triggers(i-1)
        tmp_col1 = [tmp_col1 final_test_triggers(i,1)];
        tmp_col2 = [tmp_col2 final_test_triggers(i,2)];
        tmp_sam1 = [tmp_sam1 final_test_sample(i,1)];
        tmp_sam2 = [tmp_sam2 final_test_sample(i,2)];
    else
        counter = counter + 1;
        triggers_col1{counter} = tmp_col1;
        triggers_col2{counter} = tmp_col2;
        sam_col1{counter} = tmp_sam1;
        sam_col2{counter} = tmp_sam2;
        tmp_col1 = final_test_triggers(i,1);
        tmp_col2 = final_test_triggers(i,2);
        tmp_sam1 = final_test_sample(i,1);
        tmp_sam2 = final_test_sample(i,2);
    end
    
    if i == length(final_test_triggers)
        counter = counter + 1;
        triggers_col1{counter} = tmp_col1;
        triggers_col2{counter} = tmp_col2;
        sam_col1{counter} = tmp_sam1;
        sam_col2{counter} = tmp_sam2;
    end
end

mod_triggers1 = [];
mod_triggers2 = [];
mod_sample1 = [];
mod_sample2 = [];
for i = 1:length(triggers_col1)
   if mod(length(triggers_col1{i}),2) == 0
       mod_triggers1 = [mod_triggers1; (triggers_col1{i})'];
       mod_triggers2 = [mod_triggers2; (triggers_col2{i})'];
       mod_sample1 = [mod_sample1; (sam_col1{i})'];
       mod_sample2 = [mod_sample2; (sam_col2{i})'];
   end
end

mod_trigger = [mod_triggers1 mod_triggers2 ];
mod_sample = [mod_sample1 mod_sample2];

% for test_cycles_start = first_test(:,1)
trl=[0 0 0 0];


% trl=[]; % this has to be amended according to smaple, prestim etc.

for j = 1:2:(length(mod_trigger)-1)
    trg1 = mod_trigger(j,1); % code for pleasantness judgment condition (actually corresponds with memory judgment)
    trg2 = mod_trigger((j+1),2); % code for memory response 
    
    % 201 CT for R,K,N
    if trg1==201 && trg2==1
        code = 2011;
        trlbegin = mod_sample(j,1) + pretrig;
        trlend   = mod_sample(j,1) + posttrig;
        offset   = pretrig;
        newtrl   = [trlbegin trlend offset code];
        trl      = [trl; newtrl];
        
        PN_RT1   = mod_sample(j,2) - mod_sample(j,1);
        PN_RT_CTR    = [PN_RT_CTR; PN_RT1];
        RT.PN.CT.R = PN_RT_CTR;
        M_RT1    = mod_sample(j+1,2) - mod_sample(j+1,1);
        M_RT_CTR     = [M_RT_CTR; M_RT1];
        RT.M.CT.R  = M_RT_CTR;
    elseif trg1==201 && trg2==2
        code = 2012;
        trlbegin = mod_sample(j,1) + pretrig;
        trlend   = mod_sample(j,1) + posttrig;
        offset   = pretrig;
        newtrl   = [trlbegin trlend offset code];
        trl      = [trl; newtrl];
        
        PN_RT1   = mod_sample(j,2) - mod_sample(j,1);
        PN_RT_CTK    = [PN_RT_CTK; PN_RT1];
        RT.PN.CT.K = PN_RT_CTK;
        M_RT1    = mod_sample(j+1,2) - mod_sample(j+1,1);
        M_RT_CTK     = [M_RT_CTK; M_RT1];
        RT.M.CT.K  = M_RT_CTK;
    elseif trg1==201 && trg2==3
        code = 2013;
        trlbegin = mod_sample(j,1) + pretrig;
        trlend   = mod_sample(j,1) + posttrig;
        offset   = pretrig;
        newtrl   = [trlbegin trlend offset code];
        trl      = [trl; newtrl];
        
        PN_RT1   = mod_sample(j,2) - mod_sample(j,1);
        PN_RT_CTN    = [PN_RT_CTN; PN_RT1];
        RT.PN.CT.N = PN_RT_CTN;
        M_RT1    = mod_sample(j+1,2) - mod_sample(j+1,1);
        M_RT_CTN     = [M_RT_CTN; M_RT1];
        RT.M.CT.N  = M_RT_CTN;
        
    % 221/222 ICT incongruent trials for R,K,N
    elseif (trg1==221 && trg2==1) || (trg1==222 && trg2==1) 
        code = 2021;
        trlbegin = mod_sample(j,1) + pretrig;
        trlend   = mod_sample(j,1) + posttrig;
        offset   = pretrig;
        newtrl   = [trlbegin trlend offset code];
        trl      = [trl; newtrl];
        
        PN_RT1   = mod_sample(j,2) - mod_sample(j,1);
        PN_RT_ICTR    = [PN_RT_ICTR; PN_RT1];
        RT.PN.ICT.R = PN_RT_ICTR;
        M_RT1    = mod_sample(j+1,2) - mod_sample(j+1,1);
        M_RT_ICTR     = [M_RT_ICTR; M_RT1];
        RT.M.ICT.R  = M_RT_ICTR;
    elseif (trg1==221 && trg2==2) || (trg1==222 && trg2==2) 
        code = 2022;
        trlbegin = mod_sample(j,1) + pretrig;
        trlend   = mod_sample(j,1) + posttrig;
        offset   = pretrig;
        newtrl   = [trlbegin trlend offset code];
        trl      = [trl; newtrl];
        
        PN_RT1   = mod_sample(j,2) - mod_sample(j,1);
        PN_RT_ICTK    = [PN_RT_ICTK; PN_RT1];
        RT.PN.ICT.K = PN_RT_ICTK;
        M_RT1    = mod_sample(j+1,2) - mod_sample(j+1,1);
        M_RT_ICTK     = [M_RT_ICTK; M_RT1];
        RT.M.ICT.K  = M_RT_ICTK;
    elseif (trg1==221 && trg2==3) || (trg1==222 && trg2==3) 
        code = 2023;
        trlbegin = mod_sample(j,1) + pretrig;
        trlend   = mod_sample(j,1) + posttrig;
        offset   = pretrig;
        newtrl   = [trlbegin trlend offset code];
        trl      = [trl; newtrl];  
        
        PN_RT1   = mod_sample(j,2) - mod_sample(j,1);
        PN_RT_ICTN    = [PN_RT_ICTN; PN_RT1];
        RT.PN.ICT.N = PN_RT_ICTN;
        M_RT1    = mod_sample(j+1,2) - mod_sample(j+1,1);
        M_RT_ICTN     = [M_RT_ICTN; M_RT1];
        RT.M.ICT.N  = M_RT_ICTN;  
        
    % 203 New trials for R,K,N response (FAs and CR)
    elseif (trg1==203 && trg2==1)
        code = 2031;
        trlbegin = mod_sample(j,1) + pretrig;
        trlend   = mod_sample(j,1) + posttrig;
        offset   = pretrig;
        newtrl   = [trlbegin trlend offset code];
        trl      = [trl; newtrl];
        
        PN_RT1   = mod_sample(j,2) - mod_sample(j,1);
        PN_RT_NewR    = [PN_RT_NewR; PN_RT1];
        RT.PN.New.R = PN_RT_NewR;
        M_RT1    = mod_sample(j+1,2) - mod_sample(j+1,1);
        M_RT_NewR     = [M_RT_NewR; M_RT1];
        RT.M.New.R  = M_RT_NewR;
    elseif (trg1==203 && trg2==2)
        code = 2032;
        trlbegin = mod_sample(j,1) + pretrig;
        trlend   = mod_sample(j,1) + posttrig;
        offset   = pretrig;
        newtrl   = [trlbegin trlend offset code];
        trl      = [trl; newtrl];
        
        PN_RT1   = mod_sample(j,2) - mod_sample(j,1);
        PN_RT_NewK    = [PN_RT_NewK; PN_RT1];
        RT.PN.New.K = PN_RT_NewK;
        M_RT1    = mod_sample(j+1,2) - mod_sample(j+1,1);
        M_RT_NewK     = [M_RT_NewK; M_RT1];
        RT.M.New.K  = M_RT_NewK;
    elseif (trg1==203 && trg2==3)
        code = 2033;
        trlbegin = mod_sample(j,1) + pretrig;
        trlend   = mod_sample(j,1) + posttrig;
        offset   = pretrig;
        newtrl   = [trlbegin trlend offset code];
        trl      = [trl; newtrl];
        
        PN_RT1   = mod_sample(j,2) - mod_sample(j,1);
        PN_RT_NewN    = [PN_RT_NewN; PN_RT1];
        RT.PN.New.N = PN_RT_NewN;
        M_RT1    = mod_sample(j+1,2) - mod_sample(j+1,1);
        M_RT_NewN     = [M_RT_NewN; M_RT1];
        RT.M.New.N = M_RT_NewN;
    end    
   
end

trl(1,:) = [];

RT.PN.New.R(1,:) = [];
RT.PN.New.K(1,:) = [];
RT.PN.New.N(1,:) = [];
RT.PN.CT.R(1,:) = [];
RT.PN.CT.K(1,:) = [];
RT.PN.CT.N(1,:) = [];
RT.PN.ICT.R(1,:) = [];
RT.PN.ICT.K(1,:) = [];
RT.PN.ICT.N(1,:) = [];
RT.M.New.R(1,:) = [];
RT.M.New.K(1,:) = [];
RT.M.New.N(1,:) = [];
RT.M.CT.R(1,:) = [];
RT.M.CT.K(1,:) = [];
RT.M.CT.N(1,:) = [];
RT.M.ICT.R(1,:) = [];
RT.M.ICT.K(1,:) = [];
RT.M.ICT.N(1,:) = [];

RT_data_M = [mean(RT.M.CT.R) mean(RT.M.CT.K) mean(RT.M.CT.N) mean(RT.M.ICT.R) mean(RT.M.ICT.K) mean(RT.M.ICT.N) mean(RT.M.New.R) mean(RT.M.New.K) mean(RT.M.New.N)];
RT_data_M = (RT_data_M ./ 1024);

%RT_data_PN = [mean(RT.PN.CT.R) mean(RT.PN.CT.K) mean(RT.PN.CT.N) mean(RT.PN.ICT.R) mean(RT.PN.ICT.K) mean(RT.PN.ICT.N) mean(RT.PN.New.R) mean(RT.PN.New.K) mean(RT.PN.New.N)];
%RT_data_PN = (RT_data_PN ./ 1024);


save('RT.mat', 'RT', 'RT_data_M');




