% so far, only take memory fractal, epoch: -100ms until 3000ms
% directory = '/data/laurakelly...'

clear all;

% find all codes
% get all trials that are in EEG file (check if all codes are there and
% that it looks normal (should be something around 1750 codes)
isub = { '40' };

for i = 1:length(isub)
    
cfg = [];
cfg.dataset = ['TCP_2',isub{i},'.bdf'];   %strcat(directory,'TCP_207.bdf');
cfg.trialdef.eventtype = '?';
ft_definetrial(cfg); % no output variable neccessary here, just look at the output in the Matlab screen


% get codoes of interest 
% here: memory fractal with corresponding code for R/K/N
% use TCP_test-specific trialfun for memory fractal
%clear all;

cfg = [];
cfg.dataset = ['TCP_2',isub{i},'.bdf'];
% trial fun changed to
% pretrig  = -200;
% posttrig = 2070;
% cfg.trialfun   =  'trialfun_test_fractals_frank_triggers_TCP'; % create trialfun only to use at first trigger (pleasantness judgment at test)

cfg.trialfun   =  'trialfun_whole_test_epoch_TCP'; % create trialfun only to use at first trigger (pleasantness judgment at test)


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

end