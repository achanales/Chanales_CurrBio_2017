% Grandaverage Time-Frequency data
% Created by Andy Heusser, Dynamic Memory Lab
% Nov 30, 2010




% rename structures (with subject number) first in mat-filess
clear all;

isub = {'01' '02' '04' '05' '07' '08' '09' '10' '11' '12' '13' '22' '23' '24' '25' '26' '27' '28' '29' '30' '33'};
icontrast = {'CTR' 'CTKN' 'ICTR' 'ICTKN' 'FARK' 'CR' 'CTRminCR' 'ICTRminCR' 'CTRminICTR' 'CTRminCTKN' 'ICTRminICTKN'};

for i = 1:length(isub)
    for j = 1:length(icontrast)
        
        load(strcat('TFRwa_',icontrast{j},'_s',isub{i},'.mat'));
        
        eval(strcat(strcat('TFRwa_',icontrast{j},'_s',isub{i}),strcat(' = TFRwa_',icontrast{j})));
        
        save(strcat('TFRwa_',icontrast{j},'_s',isub{i},'.mat'),strcat('TFRwa_',icontrast{j},'_s',isub{i}));
        
    end
    
    
    
end


% load in all subjects/contrasts
clear all;

isub = {'01' '02' '04' '07' '08' '09' '10' '11' '12' '24' '27' '28' '36' '38' '39' '42' '44' '45' '48' '49' '50' '53' '55' '57'};
icontrast = {'CTR' 'CTKN' 'ICTR' 'ICTKN' 'FARK' 'CR' 'CTRminCR' 'ICTRminCR' 'CTRminICTR' 'CTRminCTKN' 'ICTRminICTKN'};

for i = 1:length(isub)
    for j = 1:length(icontrast)
        
        load(strcat('TFRwa_',icontrast{j},'_s',isub{i},'.mat'));
        
    end
end

for a = 1:length(icontrast)
    
    
    cfg = [];
    cfg.keepindividual = 'yes';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
    eval_stamp = [(strcat(icontrast{a},'_ind_grandavg_TFR = ft_freqgrandaverage(cfg,TFRwa_',icontrast{a},'_s01, TFRwa_',icontrast{a},'_s02, TFRwa_',icontrast{a},'_s04, TFRwa_',icontrast{a},'_s07, TFRwa_',icontrast{a},'_s08, TFRwa_',icontrast{a},'_s09, TFRwa_',icontrast{a},'_s10, TFRwa_',icontrast{a},'_s11, TFRwa_',icontrast{a},'_s12, TFRwa_',icontrast{a},'_s24,TFRwa_',icontrast{a},'_s27,TFRwa_',icontrast{a},'_s28,TFRwa_',icontrast{a},'_s36, TFRwa_',icontrast{a},'_s38, TFRwa_',icontrast{a},'_s39, TFRwa_',icontrast{a},'_s42, TFRwa_',icontrast{a},'_s44, TFRwa_',icontrast{a},'_s45, TFRwa_',icontrast{a},'_s48, TFRwa_',icontrast{a},'_s49, TFRwa_',icontrast{a},'_s50,TFRwa_',icontrast{a},'_s53,TFRwa_',icontrast{a},'_s55,TFRwa_',icontrast{a},'_s57)'))];
    eval(eval_stamp)
    
    save(strcat(icontrast{a},'_ind_grandavg_TFR'),strcat(icontrast{a},'_ind_grandavg_TFR'));
    
end

%FT_FREQGRANDAVERAGE computes the average powerspectrum or time-frequency spectrum
%over multiple subjects
for a = 1:length(icontrast)
    
    
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
    eval_stamp = [(strcat(icontrast{a},'_V1_grandavg_TFR = ft_freqgrandaverage(cfg,TFRwa_',icontrast{a},'_s01, TFRwa_',icontrast{a},'_s02, TFRwa_',icontrast{a},'_s04, TFRwa_',icontrast{a},'_s07, TFRwa_',icontrast{a},'_s08, TFRwa_',icontrast{a},'_s09, TFRwa_',icontrast{a},'_s10, TFRwa_',icontrast{a},'_s11, TFRwa_',icontrast{a},'_s12, TFRwa_',icontrast{a},'_s24, TFRwa_',icontrast{a},'_s27,TFRwa_',icontrast{a},'_s28)'))];
    eval(eval_stamp)
    
    save(strcat(icontrast{a},'_V1_grandavg_TFR'),strcat(icontrast{a},'_V1_grandavg_TFR'));
    
end


%Same thing for version 2

for a = 1:length(icontrast)
    
    
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
    eval_stamp = [(strcat(icontrast{a},'_V2_grandavg_TFR = ft_freqgrandaverage(cfg,TFRwa_',icontrast{a},'_s36, TFRwa_',icontrast{a},'_s38, TFRwa_',icontrast{a},'_s39, TFRwa_',icontrast{a},'_s42, TFRwa_',icontrast{a},'_s44, TFRwa_',icontrast{a},'_s45, TFRwa_',icontrast{a},'_s48, TFRwa_',icontrast{a},'_s49, TFRwa_',icontrast{a},'_s50,TFRwa_',icontrast{a},'_s53,TFRwa_',icontrast{a},'_s55,TFRwa_',icontrast{a},'_s57)'))];
    eval(eval_stamp)
    
    save(strcat(icontrast{a},'_V2_grandavg_TFR'),strcat(icontrast{a},'_V2_grandavg_TFR'));
    
end

%Grand Average of all trials together
for b = 1:length(isub)
    
    
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
    eval_stamp = [(strcat('s',isub{b},'_alltrials_TFR = ft_freqgrandaverage(cfg,TFRwa_CTR_s',isub{b},',TFRwa_CTKN_s',isub{b},',TFRwa_ICTR_s',isub{b},',TFRwa_ICTKN_s',isub{b},',TFRwa_FARK_s',isub{b},',TFRwa_CR_s',isub{b},')'))];
    eval(eval_stamp)
    
    save(strcat('s',isub{b},'_alltrials_TFR'),strcat('s',isub{b},'_alltrials_TFR'));
    
end

alltrials_grandavg_TFR = ft_freqgrandaverage(cfg,s01_alltrials_TFR, s02_alltrials_TFR, s04_alltrials_TFR, s05_alltrials_TFR, s07_alltrials_TFR, s08_alltrials_TFR, s09_alltrials_TFR, s10_alltrials_TFR, s11_alltrials_TFR, s12_alltrials_TFR, s13_alltrials_TFR,s22_alltrials_TFR,s23_alltrials_TFR,s24_alltrials_TFR,s25_alltrials_TFR,s26_alltrials_TFR,s27_alltrials_TFR,s28_alltrials_TFR,s29_alltrials_TFR,s30_alltrials_TFR,s33_alltrials_TFR);

alltrials_grandavg_TFR_no23 = ft_freqgrandaverage(cfg,s01_alltrials_TFR, s02_alltrials_TFR, s04_alltrials_TFR, s05_alltrials_TFR, s07_alltrials_TFR, s08_alltrials_TFR, s09_alltrials_TFR, s10_alltrials_TFR, s11_alltrials_TFR, s12_alltrials_TFR, s13_alltrials_TFR,s22_alltrials_TFR,s24_alltrials_TFR,s25_alltrials_TFR,s26_alltrials_TFR,s27_alltrials_TFR,s28_alltrials_TFR,s29_alltrials_TFR,s30_alltrials_TFR,s33_alltrials_TFR);


%01_alltrials_TFR = ft_freqgrandaverage(cfg,TFRwa_CTR_s01,TFRwa_CTKN_s01,TFRwa_ICTR_s01,TFRwa_ICTKN_s01,TFRwa_FARK_s01,TFRwa_CR_s01);

% CTRminICTR_HIGH_TFR = ft_freqgrandaverage(cfg, TFRwa_CTRminICTR_s01, TFRwa_CTRminICTR_s02, TFRwa_CTRminICTR_s05, TFRwa_CTRminICTR_s07, TFRwa_CTRminICTR_s09, TFRwa_CTRminICTR_s12,TFRwa_CTRminICTR_s13,TFRwa_CTRminICTR_s22,TFRwa_CTRminICTR_s26,TFRwa_CTRminICTR_s27);
% CTRminICTR_LOW_TFR = ft_freqgrandaverage(cfg, TFRwa_CTRminICTR_s04, TFRwa_CTRminICTR_s08, TFRwa_CTRminICTR_s10, TFRwa_CTRminICTR_s11,TFRwa_CTRminICTR_s24,TFRwa_CTRminICTR_s25, TFRwa_CTRminICTR_s28,TFRwa_CTRminICTR_s29, TFRwa_CTRminICTR_s30, TFRwa_CTRminICTR_s33);
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
% all channels
figure;
cfg=[];
cfg.interactive = 'yes';
cfg.layout    = 'biosemi64.lay';
%cfg.ylim = [ 4 12 ];
cfg.zlim = [-500 500];
%cfg.xlim = [5 40];
%cfg.baseline = [-0.2 0.0];
% cfg.baseline = [3.8 4.0];
cfg.colorbar = 'yes';
ft_multiplotTFR(cfg,interaction_pattern); 
% 
% 3 - 4 sec topoplot
cfg=[];
cfg.xlim = [ -.9:.3:1.8 ];
% cfg.ylim = [ 5 8 ];
cfg.ylim = [ 4 30 ];
%cfg.zlim = [-500 500];
% cfg.baseline = [-0.2 0.0];
cfg.layout    = 'biosemi64.lay';
%cfg.colorbar = 'yes';
clf;
ft_topoplotTFR(cfg, CTRminICTR_pattern);
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
