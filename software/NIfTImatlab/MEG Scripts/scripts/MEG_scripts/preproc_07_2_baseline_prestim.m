%Baseline correct before Time-Frequency Analysis

clear all;

isub = {'34' '35' '36' '37' '38' };

for i = 1:length(isub)

load(strcat('data_memfr_bdrcmr_s',isub{i},'.mat'));
cfg = [];

cfg.blc = 'yes';
cfg.blcwindow = [-1 0.0];

data_memfr_bdrcmrb = ft_preprocessing(cfg, data_memfr_bdrcmr); 

data_memfr_bdrcmrb.trl = data_memfr_bdrcmr.trl;
data_memfr_bdrcmrb.cfg.trl = data_memfr_bdrcmr.cfg.trl;

save(strcat('data_memfr_bdrcmrb_s',isub{i}),'data_memfr_bdrcmrb')

end