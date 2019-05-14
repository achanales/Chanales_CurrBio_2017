% Time frequency analyes of memory fractal "memfr" on which R/K/N judgment was made
clear all;
% across CTR trials
isub = {'34' '35' '36' '37' '38'};

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
save((strcat('TFRwab_CTR_s',isub{i})),'TFRwab_CTR')


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
save((strcat('TFRwab_CTKN_s',isub{i})),'TFRwab_CTKN')



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
save((strcat('TFRwab_ICTR_s',isub{i})),'TFRwab_ICTR')


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
save((strcat('TFRwab_ICTKN_s',isub{i})),'TFRwab_ICTKN')


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
save((strcat('TFRwab_FARK_s',isub{i})),'TFRwab_FARK')


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
save((strcat('TFRwab_CR_s',isub{i})),'TFRwab_CR')

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


save((strcat('TFRwab_CTRminCR_s',isub{i})),'TFRwab_CTRminCR');
save((strcat('TFRwab_ICTRminCR_s',isub{i})),'TFRwab_ICTRminCR');
save((strcat('TFRwab_CTRminICTR_s',isub{i})),'TFRwab_CTRminICTR');
save((strcat('TFRwab_CTRminCTKN_s',isub{i})),'TFRwab_CTRminCTKN');
save((strcat('TFRwab_ICTRminICTKN_s',isub{i})),'TFRwab_ICTRminICTKN');



end


% Grandaverage Time-Frequency data
% Created by Andy Heusser, Dynamic Memory Lab
% Nov 30, 2010



% rename structures (with subject number) first in mat-filess
clear all;

isub = {'01' '02' '04' '05' '07' '08' '09' '10' '11' '12' '13' '22' '23' '24' '25' '26' '27' '28' '29' '30' '33'};
icontrast = {'CTR' 'CTKN' 'ICTR' 'ICTKN' 'FARK' 'CR' 'CTRminCR' 'ICTRminCR' 'CTRminICTR' 'CTRminCTKN' 'ICTRminICTKN'};

for i = 1:length(isub)
    for j = 1:length(icontrast)
        
        load(strcat('TFRwab_',icontrast{j},'_s',isub{i},'.mat'));
        
        eval(strcat(strcat('TFRwab_',icontrast{j},'_s',isub{i}),strcat(' = TFRwab_',icontrast{j})));
        
        save((strcat('TFRwab_',icontrast{j},'_s',isub{i},'.mat')),strcat('TFRwab_',icontrast{j},'_s',isub{i}));
        
    end
    
    
    
end


% load in all subjects/contrasts
clear all;

isub = {'01' '02' '04' '05' '07' '08' '09' '10' '11' '12' '13' '22' '23' '24' '25' '26' '27' '28' '29' '30' '33'};
icontrast = {'CTR' 'CTKN' 'ICTR' 'ICTKN' 'FARK' 'CR' 'CTRminCR' 'ICTRminCR' 'CTRminICTR' 'CTRminCTKN' 'ICTRminICTKN'};

for i = 1:length(isub)
    for j = 1:length(icontrast)
        
        load(strcat('TFRwab_',icontrast{j},'_s',isub{i},'.mat'));
        
    end
end



%FT_FREQGRANDAVERAGE computes the average powerspectrum or time-frequency spectrum
%over multiple subjects
for a = 1:length(icontrast)
    
    
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
    eval_stamp = [(strcat(icontrast{a},'_baseline_grandavg_TFR = ft_freqgrandaverage(cfg,TFRwab_',icontrast{a},'_s01, TFRwab_',icontrast{a},'_s02, TFRwab_',icontrast{a},'_s04, TFRwab_',icontrast{a},'_s05, TFRwab_',icontrast{a},'_s07, TFRwab_',icontrast{a},'_s08, TFRwab_',icontrast{a},'_s09, TFRwab_',icontrast{a},'_s10, TFRwab_',icontrast{a},'_s11, TFRwab_',icontrast{a},'_s12, TFRwab_',icontrast{a},'_s13,TFRwab_',icontrast{a},'_s22,TFRwab_',icontrast{a},'_s24,TFRwab_',icontrast{a},'_s25,TFRwab_',icontrast{a},'_s26,TFRwab_',icontrast{a},'_s27,TFRwab_',icontrast{a},'_s28,TFRwab_',icontrast{a},'_s29,TFRwab_',icontrast{a},'_s30,TFRwab_',icontrast{a},'_s33)'))];
    eval(eval_stamp)
    
    save(strcat(icontrast{a},'_baseline_grandavg_TFR'),strcat(icontrast{a},'_baseline_grandavg_TFR'));
    
end

%Grand Average of all trials together
for b = 1:length(isub)
    
    
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
    eval_stamp = [(strcat('s',isub{b},'_baseline_alltrials_TFR = ft_freqgrandaverage(cfg,TFRwab_CTR_s',isub{b},',TFRwab_CTKN_s',isub{b},',TFRwab_ICTR_s',isub{b},',TFRwab_ICTKN_s',isub{b},',TFRwab_FARK_s',isub{b},',TFRwab_CR_s',isub{b},')'))];
    eval(eval_stamp)
    
    save(strcat('s',isub{b},'_baseline_alltrials_TFR'),strcat('s',isub{b},'_baseline_alltrials_TFR'));
    
end

baseline_alltrials_grandavg_TFR = ft_freqgrandaverage(cfg,s01_baseline_alltrials_TFR, s02_baseline_alltrials_TFR, s04_baseline_alltrials_TFR, s05_baseline_alltrials_TFR, s07_baseline_alltrials_TFR, s08_baseline_alltrials_TFR, s09_baseline_alltrials_TFR, s10_baseline_alltrials_TFR, s11_baseline_alltrials_TFR, s12_baseline_alltrials_TFR, s13_baseline_alltrials_TFR,s22_baseline_alltrials_TFR,s23_baseline_alltrials_TFR,s24_baseline_alltrials_TFR,s25_baseline_alltrials_TFR,s26_baseline_alltrials_TFR,s27_baseline_alltrials_TFR,s28_baseline_alltrials_TFR,s29_baseline_alltrials_TFR,s30_baseline_alltrials_TFR,s33_baseline_alltrials_TFR);

baseline_alltrials_grandavg_TFR_no23 = ft_freqgrandaverage(cfg,s01_baseline_alltrials_TFR, s02_baseline_alltrials_TFR, s04_baseline_alltrials_TFR, s05_baseline_alltrials_TFR, s07_baseline_alltrials_TFR, s08_baseline_alltrials_TFR, s09_baseline_alltrials_TFR, s10_baseline_alltrials_TFR, s11_baseline_alltrials_TFR, s12_baseline_alltrials_TFR, s13_baseline_alltrials_TFR,s22_baseline_alltrials_TFR,s24_baseline_alltrials_TFR,s25_baseline_alltrials_TFR,s26_baseline_alltrials_TFR,s27_baseline_alltrials_TFR,s28_baseline_alltrials_TFR,s29_baseline_alltrials_TFR,s30_baseline_alltrials_TFR,s33_baseline_alltrials_TFR);


%01_alltrials_TFR = ft_freqgrandaverage(cfg,TFRwab_CTR_s01,TFRwab_CTKN_s01,TFRwab_ICTR_s01,TFRwab_ICTKN_s01,TFRwab_FARK_s01,TFRwab_CR_s01);

% CTRminICTR_HIGH_TFR = ft_freqgrandaverage(cfg, TFRwab_CTRminICTR_s01, TFRwab_CTRminICTR_s02, TFRwab_CTRminICTR_s05, TFRwab_CTRminICTR_s07, TFRwab_CTRminICTR_s09, TFRwab_CTRminICTR_s12,TFRwab_CTRminICTR_s13,TFRwab_CTRminICTR_s22,TFRwab_CTRminICTR_s26,TFRwab_CTRminICTR_s27);
% CTRminICTR_LOW_TFR = ft_freqgrandaverage(cfg, TFRwab_CTRminICTR_s04, TFRwab_CTRminICTR_s08, TFRwab_CTRminICTR_s10, TFRwab_CTRminICTR_s11,TFRwab_CTRminICTR_s24,TFRwab_CTRminICTR_s25, TFRwab_CTRminICTR_s28,TFRwab_CTRminICTR_s29, TFRwab_CTRminICTR_s30, TFRwab_CTRminICTR_s33);
% 
% save CTRminICTR_HIGH_TFR CTRminICTR_HIGH_TFR
% save CTRminICTR_LOW_TFR CTRminICTR_LOW_TFR
% 
% CTRminICTR_median_split_TFR = CTRminICTR_HIGH_TFR;
% CTRminICTR_median_split_TFR.powspctrm = CTRminICTR_HIGH_TFR.powspctrm - CTRminICTR_LOW_TFR.powspctrm;
% 

%VIEW YOUR RESULTS


% load CTKN_grandavg_TFR_10subjects.mat;
% 
% % Display
% 
% % all channels


figure;
cfg=[];
cfg.interactive = 'yes';
cfg.layout    = 'biosemi64.lay';
%cfg.ylim = [ 4 8 ];
%cfg.xlim = [0.0 2];
cfg.zlim = [-1000 1000 ];
%cfg.baseline = [-0.2 0.0];
% cfg.baseline = [3.8 4.0];
cfg.colorbar = 'yes';
ft_multiplotTFR(cfg, CTRminICTR_HIGH_TFR); 
% 
% % 3 - 4 sec topoplot
icon = {'[-.3 -.2]' '[-.2 -.1]' '[-.1 0]' '[0 .1]' '[.1 .2]' '[.2 .3]' '[.3 .4]' '[.4 .5]' '[.5 .6]' '[.6 .7]' '[.7 .8]' '[.8 .9]' '[.9 1]' '[1 1.1]' '[1.1 1.2]' '[1.2 1.3]' '[1.3 1.4]' '[1.4 1.5]' '[1.5 1.6]' '[1.6 1.7]' '[1.7 1.8]' '[1.8 1.9]' '[1.9 2.0]'};
for i = 1:length(icon)

figure;
 cfg=[];
 eval(strcat('cfg.xlim = [ ',icon{i},' ]'));
 % cfg.ylim = [ 5 8 ];
 cfg.ylim = [4 8];
 cfg.zlim = [ 0 500 ];
 % cfg.baseline = [-0.2 0.0];
 cfg.layout    = 'biosemi64.lay';
 cfg.colorbar = 'yes';
 clf;
 ft_topoplotTFR(cfg, CTRminICTR_HIGH_TFR);
 
end

% 
% 
% 
% % parietal alpha in 3-4 second interval
% 
% cfg=[];
% cfg.channel = 'POz';
% % cfg.xlim = [ 4.5 4.8 ];
% % cfg.ylim = [ 5 8 ];
% % cfg.ylim = [ 9 12 ];
% cfg.layout    = 'biosemi64.lay';
% cfg.colorbar = 'yes';
% cfg.interactive = 'yes';
% % clf;
% ft_singleplotTFR(cfg, grandavg_TFR_10subjects);

