% Time frequency analyes of memory fractal "memfr" on which R/K/N judgment was made
clear all;
% across CTR trials
isub = {'55' '57'};

for i = 1:length(isub)
    
load(strcat('data_memfr_bdrcmr_s',isub{i},'.mat'));
CTR_trials = find( (data_memfr_bdrcmr.trl(:,4)) == 2011 );
CTR_trl = data_memfr_bdrcmr.trl(CTR_trials,:);
data_CTR=data_memfr_bdrcmr;
data_CTR=rmfield(data_CTR, 'trial');
data_CTR=rmfield(data_CTR, 'trl');
data_CTR.trl=CTR_trl;
data_CTR.cfg=rmfield(data_CTR.cfg, 'trl');
data_CTR.cfg.trl=CTR_trl;
data_CTR.trial=data_memfr_bdrcmr.trial(CTR_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method     = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwa_CTR   = ft_freqanalysis(cfg,data_CTR)
save(strcat('TFRwa_CTR_s',isub{i}),'TFRwa_CTR')


% across CTKN
load(strcat('data_memfr_bdrcmr_s',isub{i},'.mat'));
CTK_trials  = find( (data_memfr_bdrcmr.trl(:,4) == 2012) );
CTN_trials  = find( (data_memfr_bdrcmr.trl(:,4) == 2013) );
CTKN_trials = cat(1,CTK_trials, CTN_trials);

CTKN_trl = data_memfr_bdrcmr.trl(CTKN_trials,:);
data_CTKN=data_memfr_bdrcmr;
data_CTKN=rmfield(data_CTKN, 'trial');
data_CTKN=rmfield(data_CTKN, 'trl');
data_CTKN.trl=CTKN_trl;
data_CTKN.cfg=rmfield(data_CTKN.cfg, 'trl');
data_CTKN.cfg.trl=CTKN_trl;
data_CTKN.trial=data_memfr_bdrcmr.trial(CTKN_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method  = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwa_CTKN   = ft_freqanalysis(cfg,data_CTKN)
save(strcat('TFRwa_CTKN_s',isub{i}),'TFRwa_CTKN')



% across ICTR trials
load(strcat('data_memfr_bdrcmr_s',isub{i},'.mat'));
ICTR_trials = find( (data_memfr_bdrcmr.trl(:,4)) == 2021 );
ICTR_trl = data_memfr_bdrcmr.trl(ICTR_trials,:);
data_ICTR=data_memfr_bdrcmr;
data_ICTR=rmfield(data_ICTR, 'trial');
data_ICTR=rmfield(data_ICTR, 'trl');
data_ICTR.trl=ICTR_trl;
data_ICTR.cfg=rmfield(data_ICTR.cfg, 'trl');
data_ICTR.cfg.trl=ICTR_trl;
data_ICTR.trial=data_memfr_bdrcmr.trial(ICTR_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method  = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwa_ICTR   = ft_freqanalysis(cfg,data_ICTR)
save(strcat('TFRwa_ICTR_s',isub{i}),'TFRwa_ICTR')


% across ICTKN
load(strcat('data_memfr_bdrcmr_s',isub{i},'.mat'));
ICTK_trials  = find( (data_memfr_bdrcmr.trl(:,4) == 2022) );
ICTN_trials  = find( (data_memfr_bdrcmr.trl(:,4) == 2023) );
ICTKN_trials = cat(1,ICTK_trials, ICTN_trials);

ICTKN_trl = data_memfr_bdrcmr.trl(ICTKN_trials,:);
data_ICTKN=data_memfr_bdrcmr;
data_ICTKN=rmfield(data_ICTKN, 'trial');
data_ICTKN=rmfield(data_ICTKN, 'trl');
data_ICTKN.trl=ICTKN_trl;
data_ICTKN.cfg=rmfield(data_ICTKN.cfg, 'trl');
data_ICTKN.cfg.trl=ICTKN_trl;
data_ICTKN.trial=data_memfr_bdrcmr.trial(ICTKN_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method  = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwa_ICTKN   = ft_freqanalysis(cfg,data_ICTKN)
save(strcat('TFRwa_ICTKN_s',isub{i}),'TFRwa_ICTKN')


% across FARK
load(strcat('data_memfr_bdrcmr_s',isub{i},'.mat'));
FAR_trials  = find( (data_memfr_bdrcmr.trl(:,4) == 2031) );
FAK_trials  = find( (data_memfr_bdrcmr.trl(:,4) == 2032) );
FARK_trials = cat(1,FAR_trials, FAK_trials);

FARK_trl = data_memfr_bdrcmr.trl(FARK_trials,:);
data_FARK=data_memfr_bdrcmr;
data_FARK=rmfield(data_FARK, 'trial');
data_FARK=rmfield(data_FARK, 'trl');
data_FARK.trl=FARK_trl;
data_FARK.cfg=rmfield(data_FARK.cfg, 'trl');
data_FARK.cfg.trl=FARK_trl;
data_FARK.trial=data_memfr_bdrcmr.trial(FARK_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method  = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwa_FARK   = ft_freqanalysis(cfg,data_FARK)
save(strcat('TFRwa_FARK_s',isub{i}),'TFRwa_FARK')


% across CR trials
load(strcat('data_memfr_bdrcmr_s',isub{i},'.mat'));
CR_trials = find( (data_memfr_bdrcmr.trl(:,4)) == 2033 );
CR_trl = data_memfr_bdrcmr.trl(CR_trials,:);
data_CR=data_memfr_bdrcmr;
data_CR=rmfield(data_CR, 'trial');
data_CR=rmfield(data_CR, 'trl');
data_CR.trl=CR_trl;
data_CR.cfg=rmfield(data_CR.cfg, 'trl');
data_CR.cfg.trl=CR_trl;
data_CR.trial=data_memfr_bdrcmr.trial(CR_trials);

cfg = [];
cfg.output  = 'pow';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method  = 'wltconvol';  % morlet wavlet analysis 
cfg.width      = 6; % Important parameter: 5 cycles per morlet
cfg.foi          = 3:1:40; % analysis 2 to 30 Hz in steps of 2 Hz
cfg.toi          = -1.0: 0.01 : 3.0; % time window "slides" from -0.2 to 1.5 sec in steps of 0.01 sec (10 ms)
TFRwa_CR   = ft_freqanalysis(cfg,data_CR)
save(strcat('TFRwa_CR_s',isub{i}),'TFRwa_CR')

TFRwa_CTRminCR = TFRwa_CTR;
TFRwa_CTRminCR.powspctrm  = TFRwa_CTR.powspctrm - TFRwa_CR.powspctrm;

TFRwa_ICTRminCR = TFRwa_ICTR;
TFRwa_ICTRminCR.powspctrm  = TFRwa_ICTR.powspctrm - TFRwa_CR.powspctrm;

TFRwa_CTRminICTR = TFRwa_CTR;
TFRwa_CTRminICTR.powspctrm  = TFRwa_CTR.powspctrm - TFRwa_ICTR.powspctrm;

TFRwa_CTRminCTKN = TFRwa_CTR;
TFRwa_CTRminCTKN.powspctrm  = TFRwa_CTR.powspctrm - TFRwa_CTKN.powspctrm;

TFRwa_ICTRminICTKN = TFRwa_ICTR;
TFRwa_ICTRminICTKN.powspctrm  = TFRwa_ICTR.powspctrm - TFRwa_ICTKN.powspctrm;


save(strcat('TFRwa_CTRminCR_s',isub{i}),'TFRwa_CTRminCR');
save(strcat('TFRwa_ICTRminCR_s',isub{i}),'TFRwa_ICTRminCR');
save(strcat('TFRwa_CTRminICTR_s',isub{i}),'TFRwa_CTRminICTR');
save(strcat('TFRwa_CTRminCTKN_s',isub{i}),'TFRwa_CTRminCTKN');
save(strcat('TFRwa_ICTRminICTKN_s',isub{i}),'TFRwa_ICTRminICTKN');

end

% 
% 
% Grandaverage Time-Frequency data
% Created by Andy Heusser, Dynamic Memory Lab
% Nov 30, 2010




% rename structures (with subject number) first in mat-filess
clear all;

isub = {'53' '55' '57'};
icontrast = {'CTR' 'CTKN' 'ICTR' 'ICTKN' 'FARK' 'CR' 'CTRminCR' 'ICTRminCR' 'CTRminICTR' 'CTRminCTKN' 'ICTRminICTKN'};

for i = 1:length(isub)
    for j = 1:length(icontrast)
        
        load(strcat('TFRwa_',icontrast{j},'_s',isub{i},'.mat'));
        
        eval(strcat(strcat('TFRwa_',icontrast{j},'_s',isub{i}),strcat(' = TFRwa_',icontrast{j})));
        
        save(strcat('TFRwa_',icontrast{j},'_s',isub{i},'.mat'),strcat('TFRwa_',icontrast{j},'_s',isub{i}));
        
    end
    
    
    
end
% 
% 
% % load in all subjects/contrasts
% clear all;
% 
% isub = {'01' '02' '04' '05' '07' '08' '09' '10' '11' '12' '13' '22' '23' '24' '25' '26' '27' '28' '29' '30' '33'};
% icontrast = {'CTR' 'CTKN' 'ICTR' 'ICTKN' 'FARK' 'CR' 'CTRminCR' 'ICTRminCR' 'CTRminICTR' 'CTRminCTKN' 'ICTRminICTKN'};
% 
% for i = 1:length(isub)
%     for j = 1:length(icontrast)
%         
%         load(strcat('TFRwa_',icontrast{j},'_s',isub{i},'.mat'));
%         
%     end
% end
% 
% 
% 
% %FT_FREQGRANDAVERAGE computes the average powerspectrum or time-frequency spectrum
% %over multiple subjects
% for a = 1:length(icontrast)
%     
%     
%     cfg = [];
%     cfg.keepindividual = 'no';
%     cfg.foilim         = 'all';
%     cfg.toilim         = 'all';
%     eval_stamp = [(strcat(icontrast{a},'_grandavg_TFR = ft_freqgrandaverage(cfg,TFRwa_',icontrast{a},'_s01, TFRwa_',icontrast{a},'_s02, TFRwa_',icontrast{a},'_s04, TFRwa_',icontrast{a},'_s05, TFRwa_',icontrast{a},'_s07, TFRwa_',icontrast{a},'_s08, TFRwa_',icontrast{a},'_s09, TFRwa_',icontrast{a},'_s10, TFRwa_',icontrast{a},'_s11, TFRwa_',icontrast{a},'_s12, TFRwa_',icontrast{a},'_s13,TFRwa_',icontrast{a},'_s22,TFRwa_',icontrast{a},'_s24,TFRwa_',icontrast{a},'_s25,TFRwa_',icontrast{a},'_s26,TFRwa_',icontrast{a},'_s27,TFRwa_',icontrast{a},'_s28,TFRwa_',icontrast{a},'_s29,TFRwa_',icontrast{a},'_s30,TFRwa_',icontrast{a},'_s33)'))];
%     eval(eval_stamp)
%     
%     save(strcat(icontrast{a},'_grandavg_TFR'),strcat(icontrast{a},'_grandavg_TFR'));
%     
% end
% 
% %Grand Average of all trials together
for b = 1:length(isub)
    
    
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
    eval_stamp = [(strcat('s',isub{b},'_alltrials_TFR = ft_freqgrandaverage(cfg,TFRwa_CTR_s',isub{b},',TFRwa_CTKN_s',isub{b},',TFRwa_ICTR_s',isub{b},',TFRwa_ICTKN_s',isub{b},',TFRwa_FARK_s',isub{b},',TFRwa_CR_s',isub{b},')'))];
    eval(eval_stamp)
    
    save(strcat('s',isub{b},'_alltrials_TFR'),strcat('s',isub{b},'_alltrials_TFR'));
    
end
% 
% alltrials_grandavg_TFR = ft_freqgrandaverage(cfg,s01_alltrials_TFR, s02_alltrials_TFR, s04_alltrials_TFR, s05_alltrials_TFR, s07_alltrials_TFR, s08_alltrials_TFR, s09_alltrials_TFR, s10_alltrials_TFR, s11_alltrials_TFR, s12_alltrials_TFR, s13_alltrials_TFR,s22_alltrials_TFR,s23_alltrials_TFR,s24_alltrials_TFR,s25_alltrials_TFR,s26_alltrials_TFR,s27_alltrials_TFR,s28_alltrials_TFR,s29_alltrials_TFR,s30_alltrials_TFR,s33_alltrials_TFR);
% 
% alltrials_grandavg_TFR_no23 = ft_freqgrandaverage(cfg,s01_alltrials_TFR, s02_alltrials_TFR, s04_alltrials_TFR, s05_alltrials_TFR, s07_alltrials_TFR, s08_alltrials_TFR, s09_alltrials_TFR, s10_alltrials_TFR, s11_alltrials_TFR, s12_alltrials_TFR, s13_alltrials_TFR,s22_alltrials_TFR,s24_alltrials_TFR,s25_alltrials_TFR,s26_alltrials_TFR,s27_alltrials_TFR,s28_alltrials_TFR,s29_alltrials_TFR,s30_alltrials_TFR,s33_alltrials_TFR);
% 
% 
% %01_alltrials_TFR = ft_freqgrandaverage(cfg,TFRwa_CTR_s01,TFRwa_CTKN_s01,TFRwa_ICTR_s01,TFRwa_ICTKN_s01,TFRwa_FARK_s01,TFRwa_CR_s01);
% 
% % CTRminICTR_HIGH_TFR = ft_freqgrandaverage(cfg, TFRwa_CTRminICTR_s01, TFRwa_CTRminICTR_s02, TFRwa_CTRminICTR_s05, TFRwa_CTRminICTR_s07, TFRwa_CTRminICTR_s09, TFRwa_CTRminICTR_s12,TFRwa_CTRminICTR_s13,TFRwa_CTRminICTR_s22,TFRwa_CTRminICTR_s26,TFRwa_CTRminICTR_s27);
% % CTRminICTR_LOW_TFR = ft_freqgrandaverage(cfg, TFRwa_CTRminICTR_s04, TFRwa_CTRminICTR_s08, TFRwa_CTRminICTR_s10, TFRwa_CTRminICTR_s11,TFRwa_CTRminICTR_s24,TFRwa_CTRminICTR_s25, TFRwa_CTRminICTR_s28,TFRwa_CTRminICTR_s29, TFRwa_CTRminICTR_s30, TFRwa_CTRminICTR_s33);
% % 
% % save CTRminICTR_HIGH_TFR CTRminICTR_HIGH_TFR
% % save CTRminICTR_LOW_TFR CTRminICTR_LOW_TFR
% % 
% % CTRminICTR_median_split_TFR = CTRminICTR_HIGH_TFR;
% % CTRminICTR_median_split_TFR.powspctrm = CTRminICTR_HIGH_TFR.powspctrm - CTRminICTR_LOW_TFR.powspctrm;
% % 
% 
% %VIEW YOUR RESULTS
% 
% 
% % load CTKN_grandavg_TFR_10subjects.mat;
% % 
% % % Display
% % 
% all channels
figure;
cfg=[];
cfg.interactive = 'yes';
cfg.layout    = 'biosemi64.lay';
%cfg.ylim = [ 4 20 ];
%cfg.zlim = [-500 500 ]
%cfg.baseline = [-0.5 0.0];
% cfg.baseline = [3.8 4.0];
cfg.colorbar = 'yes';
ft_multiplotTFR(cfg, CTRminICTR_grandavg_TFR); 

% % % 3 - 4 sec topoplot
% % cfg=[];
% % cfg.xlim = [ 3 4 ];
% % % cfg.ylim = [ 5 8 ];
% % cfg.ylim = [ 8 12 ];
% % % cfg.baseline = [-0.2 0.0];
% % cfg.layout    = 'biosemi64.lay';
% % cfg.colorbar = 'yes';
% % clf;
% % ft_topoplotTFR(cfg, grandavg_TFR_10subjects);
% % 
% % 
% % 
% % % parietal alpha in 3-4 second interval
% % 
figure;
cfg=[];
%cfg.channel = 'FCz';
cfg.xlim = [-.5 : 0.1 : 3.0 ];
% cfg.ylim = [ 5 8 ];
cfg.ylim = [9 12];
%cfg.zlim = [-500 500 ]
cfg.layout    = 'biosemi64.lay';
%cfg.colorbar = 'yes';
%cfg.interactive = 'yes';
% clf;
ft_topoplotTFR(cfg, CTRminCTKN_grandavg_TFR);
% clear all;

%  
%  cfg = [];
%  cfg.keepindividual = 'no';
%  cfg.foilim         = 'all';
%  cfg.toilim         = 'all';
%  ICTRminICTKN_V1V2_5subs_grandavg_TFR = ft_freqgrandaverage(cfg, TFRwa_ICTRminICTKN_s01,TFRwa_ICTRminICTKN_s02,TFRwa_ICTRminICTKN_s04,TFRwa_ICTRminICTKN_s36,TFRwa_ICTRminICTKN_s37,TFRwa_ICTRminICTKN_s38);
% 
% % 
% 
% 
%     cfg = [];
%     cfg.keepindividual = 'no';
%     cfg.foilim         = 'all';
%     cfg.toilim         = 'all';
%    V1_grandavg_TFR = ft_freqgrandaverage(cfg,TFRwa_CTRminICTR_s01,TFRwa_CTRminICTR_s02,TFRwa_CTRminICTR_s04,TFRwa_CTRminICTR_s05,TFRwa_CTRminICTR_s07,TFRwa_CTRminICTR_s08, TFRwa_CTRminICTR_s09,TFRwa_CTRminICTR_s10,TFRwa_CTRminICTR_s11,TFRwa_CTRminICTR_s12,TFRwa_CTRminICTR_s13,TFRwa_CTRminICTR_s22,TFRwa_CTRminICTR_s23,TFRwa_CTRminICTR_s24,TFRwa_CTRminICTR_s25,TFRwa_CTRminICTR_s26,TFRwa_CTRminICTR_s27,TFRwa_CTRminICTR_s28, TFRwa_CTRminICTR_s29,TFRwa_CTRminICTR_s30,TFRwa_CTRminICTR_s33)
%    
%    
%     cfg = [];
%     cfg.keepindividual = 'no';
%     cfg.foilim         = 'all';
%     cfg.toilim         = 'all';
%    V2_grandavg_TFR = ft_freqgrandaverage(cfg,TFRwa_CTRminICTR_s36,TFRwa_CTRminICTR_s37,TFRwa_CTRminICTR_s38,TFRwa_CTRminICTR_s39,TFRwa_CTRminICTR_s41,TFRwa_CTRminICTR_s42)
%    
%    
%    V1V2_grandavg_TFR = V1_grandavg_TFR;
%    V1V2_grandavg_TFR.powspctrm = ((V1_grandavg_TFR.powspctrm + V2_grandavg_TFR.powspctrm) / 2);
%    
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
   V1_CTRminICTR_grandavg_TFR = ft_freqgrandaverage(cfg,TFRwa_CTRminICTR_s01,TFRwa_CTRminICTR_s02,TFRwa_CTRminICTR_s04,TFRwa_CTRminICTR_s05,TFRwa_CTRminICTR_s07,TFRwa_CTRminICTR_s08, TFRwa_CTRminICTR_s09,TFRwa_CTRminICTR_s10,TFRwa_CTRminICTR_s11,TFRwa_CTRminICTR_s12,TFRwa_CTRminICTR_s22,TFRwa_CTRminICTR_s23,TFRwa_CTRminICTR_s24,TFRwa_CTRminICTR_s25,TFRwa_CTRminICTR_s26,TFRwa_CTRminICTR_s27,TFRwa_CTRminICTR_s28, TFRwa_CTRminICTR_s29,TFRwa_CTRminICTR_s30,TFRwa_CTRminICTR_s33);
   
   
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
    CTRminICTR_grandavg_TFR = ft_freqgrandaverage(cfg,TFRwa_CTRminICTR_s01,TFRwa_CTRminICTR_s02,TFRwa_CTRminICTR_s04,TFRwa_CTRminICTR_s07,TFRwa_CTRminICTR_s08, TFRwa_CTRminICTR_s09,TFRwa_CTRminICTR_s10,TFRwa_CTRminICTR_s11,TFRwa_CTRminICTR_s12,TFRwa_CTRminICTR_s22,TFRwa_CTRminICTR_s23,TFRwa_CTRminICTR_s36,TFRwa_CTRminICTR_s37,TFRwa_CTRminICTR_s38,TFRwa_CTRminICTR_s39,TFRwa_CTRminICTR_s42,TFRwa_CTRminICTR_s44,TFRwa_CTRminICTR_s45,TFRwa_CTRminICTR_s46, TFRwa_CTRminICTR_s48,TFRwa_CTRminICTR_s49, TFRwa_CTRminICTR_s50);
   
    
       cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
    CTRminCTKN_grandavg_TFR = ft_freqgrandaverage(cfg,TFRwa_CTRminCTKN_s01,TFRwa_CTRminCTKN_s02,TFRwa_CTRminCTKN_s04,TFRwa_CTRminCTKN_s07,TFRwa_CTRminCTKN_s08, TFRwa_CTRminCTKN_s09,TFRwa_CTRminCTKN_s10,TFRwa_CTRminCTKN_s11,TFRwa_CTRminCTKN_s12,TFRwa_CTRminCTKN_s22,TFRwa_CTRminCTKN_s36,TFRwa_CTRminCTKN_s37,TFRwa_CTRminCTKN_s38,TFRwa_CTRminCTKN_s39,TFRwa_CTRminCTKN_s42,TFRwa_CTRminCTKN_s44,TFRwa_CTRminCTKN_s45,TFRwa_CTRminCTKN_s46, TFRwa_CTRminCTKN_s48,TFRwa_CTRminCTKN_s49);
   
    
           cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
    ICTRminICTKN_grandavg_TFR = ft_freqgrandaverage(cfg,TFRwa_ICTRminICTKN_s01,TFRwa_ICTRminICTKN_s02,TFRwa_ICTRminICTKN_s04,TFRwa_ICTRminICTKN_s07,TFRwa_ICTRminICTKN_s08, TFRwa_ICTRminICTKN_s09,TFRwa_ICTRminICTKN_s10,TFRwa_ICTRminICTKN_s11,TFRwa_ICTRminICTKN_s12,TFRwa_ICTRminICTKN_s22,TFRwa_ICTRminICTKN_s36,TFRwa_ICTRminICTKN_s37,TFRwa_ICTRminICTKN_s38,TFRwa_ICTRminICTKN_s39,TFRwa_ICTRminICTKN_s42,TFRwa_ICTRminICTKN_s44,TFRwa_ICTRminICTKN_s45,TFRwa_ICTRminICTKN_s46, TFRwa_ICTRminICTKN_s48,TFRwa_ICTRminICTKN_s49);
   