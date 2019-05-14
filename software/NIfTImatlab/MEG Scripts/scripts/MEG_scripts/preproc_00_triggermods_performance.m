% so far, only take memory fractal, epoch: -100ms until 3000ms
% directory = '/data/laurakelly...'

clear all;

% find all codes
% get all trials that are in EEG file (check if all codes are there and
% that it looks normal (should be something around 1750 codes)
isub = {'53' '55' '57'};

%                      

for i = 1:length(isub)
    
cfg = [];
cfg.dataset = ['/Users/aheusser/Desktop/TCP_EEG/raw/TCP_2',isub{i},'.bdf'];   %strcat(directory,'TCP_207.bdf');
cfg.trialdef.eventtype = '?';
ft_definetrial(cfg); % no output variable neccessary here, just look at the output in the Matlab screen


% get codoes of interest 
% here: memory fractal with corresponding code for R/K/N
% use TCP_test-specific trialfun for memory fractal
%clear all;

cfg = [];
cfg.dataset = ['/Users/aheusser/Desktop/TCP_EEG/raw/TCP_2',isub{i},'.bdf'];
% trial fun changed to
% pretrig  = -200;
% posttrig = 2070;
% cfg.trialfun   =  'trialfun_test_fractals_frank_triggers_TCP'; % create trialfun only to use at first trigger (pleasantness judgment at test)
cfg.trialfun   =  'trialfun_whole_test_epoch_TCP'; % create trialfun only to use at first trigger (pleasantness judgment at test)
cfg.isub = isub;

cfg = ft_definetrial(cfg); % now you do want to use an output variable for definetrial, since you need its output
trl = cfg.trl;
save(strcat('trl_s',isub{i}),'trl') % only safe trl to save memory

% get memory performance
% use codes from trl-file
D.CTR  = length( find(trl(:,4)==2011) );
D.CTK  = length( find(trl(:,4)==2012) );
D.CTN  = length( find(trl(:,4)==2013) );

D.ICTR = length( find(trl(:,4)==2021) );
D.ICTK = length( find(trl(:,4)==2022) );
D.ICTN = length( find(trl(:,4)==2023) );

D.NewR = length( find(trl(:,4)==2031) );
D.NewK = length( find(trl(:,4)==2032) );
D.NewN = length( find(trl(:,4)==2033) );

mem_perf = [ D.CTR D.CTK D.CTN D.ICTR D.ICTK D.ICTN D.NewR D.NewK D.NewN ];

save(strcat('mem_perf_s',isub{i}),'mem_perf')

load('RT.mat')

NAN = isnan(RT.PN.CT.R);
RT.PN.CT.R(NAN) = [];
NAN = isnan(RT.PN.CT.K);
RT.PN.CT.K(NAN) = [];
NAN = isnan(RT.PN.CT.N);
RT.PN.CT.N(NAN) = [];

NAN = isnan(RT.PN.ICT.R);
RT.PN.ICT.R(NAN) = [];
NAN = isnan(RT.PN.ICT.K);
RT.PN.ICT.K(NAN) = [];
NAN = isnan(RT.PN.ICT.N);
RT.PN.ICT.N(NAN) = [];

NAN = isnan(RT.PN.New.R);
RT.PN.New.R(NAN) = [];
NAN = isnan(RT.PN.New.K);
RT.PN.New.K(NAN) = [];
NAN = isnan(RT.PN.New.N);
RT.PN.New.N(NAN) = [];


PN_RT.CTR = sum(RT.PN.CT.R)/length(RT.PN.CT.R);
PN_RT.CTK = sum(RT.PN.CT.K)/length(RT.PN.CT.K);
PN_RT.CTN = sum(RT.PN.CT.N)/length(RT.PN.CT.N);

PN_RT.ICTR = sum(RT.PN.ICT.R)/length(RT.PN.ICT.R);
PN_RT.ICTK = sum(RT.PN.ICT.K)/length(RT.PN.ICT.K);
PN_RT.ICTN = sum(RT.PN.ICT.N)/length(RT.PN.ICT.N);

PN_RT.NewR = sum(RT.PN.New.R)/length(RT.PN.New.R);
PN_RT.NewK = sum(RT.PN.New.K)/length(RT.PN.New.K);
PN_RT.NewN = sum(RT.PN.New.N)/length(RT.PN.New.N);

RKN_RT = [mean(RT.M.CT.R) mean(RT.M.CT.K) mean(RT.M.CT.N) mean(RT.M.ICT.R) mean(RT.M.ICT.K) mean(RT.M.ICT.N) mean(RT.M.New.R) mean(RT.M.New.K) mean(RT.M.New.N)];
RKN_RT = RKN_RT ./1024;

PN_RT = [PN_RT.CTR PN_RT.CTK PN_RT.CTN PN_RT.ICTR PN_RT.ICTK PN_RT.ICTN PN_RT.NewR PN_RT.NewK PN_RT.NewN];
PN_RT = (PN_RT ./ 1024);

save(strcat('RT_s',num2str(isub{1})),'RT', 'PN_RT', 'RKN_RT')

clear D NAN PN_RT RKN_RT RT RT_data_M

end


