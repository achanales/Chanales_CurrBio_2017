clear all;

isub = {'53' '55' '57'};

for i = 1:length(isub)


load(strcat('trl_s',isub{i},'.mat'));
cfg = [];
cfg.dataset = ['/Users/aheusser/Desktop/TCP_EEG/raw/TCP_2',isub{i},'.bdf'];
cfg.trl=trl;
cfg.continuous = 'yes'; %this is how data is recorded!! do I still need that here?

% "B" Baseline correction across trials
cfg.blc = 'yes'; % baseline correction across trial, if you don't do it, I cannot see single trials in manual_artefactrejection
cfg.channel = { 'all', '-Status', '-EXG7', '-EXG8' }; % 'gui' to select

% cfg.blcwindow = [-0.1 0]; % prestimulus baseline correction
% cfg.padding = 10; ???? for high-pass filtering for later
% frequency-analyses, but also low-pass (e.g. 20Hz) for ERPs

% Rereferencing to mastoid electrodes
% cfg.reref       = 'yes';
% cfg.refchannel  = {'EXG1', 'EXG2'}; % the average of the two mastoid channels is used as the new reference

data_memfr_b = ft_preprocessing(cfg); %loading in, loading montage, (filtering), baseline correction, re-referencing, notch filter

% "D" Downsample data to speed up further analyses (256Hz)
cfg = [];
cfg.resamplefs = 512; %512 Hz for real analyses
cfg.detrend    = 'no';
data_memfr_bd = ft_resampledata(cfg, data_memfr_b);

data_memfr_bd.cfg.trl = data_memfr_bd.cfg.previous.trl;

% save loaded in and downsampled data
save(strcat('data_memfr_bd_s',isub{i}),'data_memfr_bd')

end