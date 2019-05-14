% Time frequency analyes of memory fractal "memfr" on which R/K/N judgment was made
clear all;
% across CTR trials
isub = {'01' '02' '04' '07' '08' '09' '10' '11' '12' '24' '27' '28' '36' '38' '39' '41' '42' '44' '45' '47' '48' '49' '50' '53' '55' '57'};

for i = 1:length(isub)
    
load(strcat('data_memfr_bdrcmrb_s',isub{i},'.mat'));
CTR_trials = find( (data_memfr_bdrcmrb.trl(:,4)) == 2011 );
CTR_trl = data_memfr_bdrcmrb.trl(CTR_trials,:);
data_CTR=data_memfr_bdrcmrb;
data_CTR=rmfield(data_CTR, 'trial');
data_CTR=rmfield(data_CTR, 'trl');
data_CTR.trl=CTR_trl;
data_CTR.cfg=rmfield(data_CTR.cfg, 'trl');
data_CTR.cfg.trl=CTR_trl;
data_CTR.trial=data_memfr_bdrcmrb.trial(CTR_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method     = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwab_CTR   = ft_freqanalysis(cfg,data_CTR)
save(strcat('TFRwab_CTR_s',isub{i}),'TFRwab_CTR')


% across CTKN
load(strcat('data_memfr_bdrcmrb_s',isub{i},'.mat'));
CTK_trials  = find( (data_memfr_bdrcmrb.trl(:,4) == 2012) );
CTN_trials  = find( (data_memfr_bdrcmrb.trl(:,4) == 2013) );
CTKN_trials = cat(1,CTK_trials, CTN_trials);

CTKN_trl = data_memfr_bdrcmrb.trl(CTKN_trials,:);
data_CTKN=data_memfr_bdrcmrb;
data_CTKN=rmfield(data_CTKN, 'trial');
data_CTKN=rmfield(data_CTKN, 'trl');
data_CTKN.trl=CTKN_trl;
data_CTKN.cfg=rmfield(data_CTKN.cfg, 'trl');
data_CTKN.cfg.trl=CTKN_trl;
data_CTKN.trial=data_memfr_bdrcmrb.trial(CTKN_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method  = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwab_CTKN   = ft_freqanalysis(cfg,data_CTKN)
save(strcat('TFRwab_CTKN_s',isub{i}),'TFRwab_CTKN')



% across ICTR trials
load(strcat('data_memfr_bdrcmrb_s',isub{i},'.mat'));
ICTR_trials = find( (data_memfr_bdrcmrb.trl(:,4)) == 2021 );
ICTR_trl = data_memfr_bdrcmrb.trl(ICTR_trials,:);
data_ICTR=data_memfr_bdrcmrb;
data_ICTR=rmfield(data_ICTR, 'trial');
data_ICTR=rmfield(data_ICTR, 'trl');
data_ICTR.trl=ICTR_trl;
data_ICTR.cfg=rmfield(data_ICTR.cfg, 'trl');
data_ICTR.cfg.trl=ICTR_trl;
data_ICTR.trial=data_memfr_bdrcmrb.trial(ICTR_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method  = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwab_ICTR   = ft_freqanalysis(cfg,data_ICTR)
save(strcat('TFRwab_ICTR_s',isub{i}),'TFRwab_ICTR')


% across ICTKN
load(strcat('data_memfr_bdrcmrb_s',isub{i},'.mat'));
ICTK_trials  = find( (data_memfr_bdrcmrb.trl(:,4) == 2022) );
ICTN_trials  = find( (data_memfr_bdrcmrb.trl(:,4) == 2023) );
ICTKN_trials = cat(1,ICTK_trials, ICTN_trials);

ICTKN_trl = data_memfr_bdrcmrb.trl(ICTKN_trials,:);
data_ICTKN=data_memfr_bdrcmrb;
data_ICTKN=rmfield(data_ICTKN, 'trial');
data_ICTKN=rmfield(data_ICTKN, 'trl');
data_ICTKN.trl=ICTKN_trl;
data_ICTKN.cfg=rmfield(data_ICTKN.cfg, 'trl');
data_ICTKN.cfg.trl=ICTKN_trl;
data_ICTKN.trial=data_memfr_bdrcmrb.trial(ICTKN_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method  = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwab_ICTKN   = ft_freqanalysis(cfg,data_ICTKN)
save(strcat('TFRwab_ICTKN_s',isub{i}),'TFRwab_ICTKN')


% across FARK
load(strcat('data_memfr_bdrcmrb_s',isub{i},'.mat'));
FAR_trials  = find( (data_memfr_bdrcmrb.trl(:,4) == 2031) );
FAK_trials  = find( (data_memfr_bdrcmrb.trl(:,4) == 2032) );
FARK_trials = cat(1,FAR_trials, FAK_trials);

FARK_trl = data_memfr_bdrcmrb.trl(FARK_trials,:);
data_FARK=data_memfr_bdrcmrb;
data_FARK=rmfield(data_FARK, 'trial');
data_FARK=rmfield(data_FARK, 'trl');
data_FARK.trl=FARK_trl;
data_FARK.cfg=rmfield(data_FARK.cfg, 'trl');
data_FARK.cfg.trl=FARK_trl;
data_FARK.trial=data_memfr_bdrcmrb.trial(FARK_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method  = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwab_FARK   = ft_freqanalysis(cfg,data_FARK)
save(strcat('TFRwab_FARK_s',isub{i}),'TFRwab_FARK')


% across CR trials
load(strcat('data_memfr_bdrcmrb_s',isub{i},'.mat'));
CR_trials = find( (data_memfr_bdrcmrb.trl(:,4)) == 2033 );
CR_trl = data_memfr_bdrcmrb.trl(CR_trials,:);
data_CR=data_memfr_bdrcmrb;
data_CR=rmfield(data_CR, 'trial');
data_CR=rmfield(data_CR, 'trl');
data_CR.trl=CR_trl;
data_CR.cfg=rmfield(data_CR.cfg, 'trl');
data_CR.cfg.trl=CR_trl;
data_CR.trial=data_memfr_bdrcmrb.trial(CR_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method  = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwab_CR   = ft_freqanalysis(cfg,data_CR)
save(strcat('TFRwab_CR_s',isub{i}),'TFRwab_CR')

TFRwab_CTRminCR = TFRwab_CTR;
TFRwab_CTRminCR.powspctrm  = TFRwab_CTR.powspctrm - TFRwab_CR.powspctrm;

TFRwab_ICTRminCR = TFRwab_ICTR;
TFRwab_ICTRminCR.powspctrm  = TFRwab_ICTR.powspctrm - TFRwab_CR.powspctrm;

TFRwab_CTRminICTR = TFRwab_CTR;
TFRwab_CTRminICTR.powspctrm  = TFRwab_CTR.powspctrm - TFRwab_ICTR.powspctrm;

TFRwab_CTRminCTKN = TFRwab_CTR;
TFRwab_CTRminCTKN.powspctrm  = TFRwab_CTR.powspctrm - TFRwab_CTKN.powspctrm;

TFRwab_ICTRminICTKN = TFRwab_ICTR;
TFRwab_ICTRminICTKN.powspctrm  = TFRwab_ICTR.powspctrm - TFRwab_ICTKN.powspctrm;


save(strcat('TFRwab_CTRminCR_s',isub{i}),'TFRwab_CTRminCR');
save(strcat('TFRwab_ICTRminCR_s',isub{i}),'TFRwab_ICTRminCR');
save(strcat('TFRwab_CTRminICTR_s',isub{i}),'TFRwab_CTRminICTR');
save(strcat('TFRwab_CTRminCTKN_s',isub{i}),'TFRwab_CTRminCTKN');
save(strcat('TFRwab_ICTRminICTKN_s',isub{i}),'TFRwab_ICTRminICTKN');



end

