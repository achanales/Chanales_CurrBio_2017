% Time frequency analyes of memory fractal "memfr" on which R/K/N judgment was made
clear all;
% across CTR trials
isub = {'36' '38' '39' '42' '44' '45' '48' '49' '50' '53' '55' '57'};
%'01' '02' '04' '05' '07' '08' '09' '10' '11' '12' '13' '22' '23' '25' '26'
%
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
cfg.output  = 'fourier';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method     = 'mtmconvol'; % multitaper analysis
cfg.keeptrials = 'yes';
cfg.taper = 'hanning';
cfg.foi        = 3:1:40; % analysis 30 to 80 Hz in steps of 1 Hz
cfg.t_ftimwin  = 5 ./ cfg.foi;
cfg.tapsmofrq  = 0.4 * cfg.foi; % the higher the number, the more smoothing, but respect Shannon number
cfg.toi          = -0.5: 0.01 : 6.5; 
TFRmuitc_CTR   = ft_freqanalysis(cfg,data_CTR);
save(strcat('TFRmuitc_CTR_s',isub{i}),'TFRmuitc_CTR')

clear TFRmuitc_CTR

% across CTKN
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
cfg.output  = 'fourier';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method     = 'mtmconvol'; % multitaper analysis
cfg.keeptrials = 'yes';
cfg.taper = 'hanning';
cfg.foi        = 3:1:40; % analysis 30 to 80 Hz in steps of 1 Hz
cfg.t_ftimwin  = 5 ./ cfg.foi;
cfg.tapsmofrq  = 0.4 * cfg.foi; % the higher the number, the more smoothing, but respect Shannon number
cfg.toi          = -0.5: 0.01 : 6.5; 
TFRmuitc_CTKN   = ft_freqanalysis(cfg,data_CTKN);
save(strcat('TFRmuitc_CTKN_s',isub{i}),'TFRmuitc_CTKN')

clear TFRmuitc_CTKN

% across ICTR trials
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
cfg.output  = 'fourier';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method     = 'mtmconvol'; % multitaper analysis
cfg.keeptrials = 'yes';
cfg.taper = 'hanning';
cfg.foi        = 3:1:40; % analysis 30 to 80 Hz in steps of 1 Hz
cfg.t_ftimwin  = 5 ./ cfg.foi;
cfg.tapsmofrq  = 0.4 * cfg.foi; % the higher the number, the more smoothing, but respect Shannon number
cfg.toi          = -0.5: 0.01 : 6.5; 
TFRmuitc_ICTR   = ft_freqanalysis(cfg,data_ICTR);
save(strcat('TFRmuitc_ICTR_s',isub{i}),'TFRmuitc_ICTR')

clear TFRmuitc_ICTR

% across ICTKN
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
cfg.output  = 'fourier';
cfg.channel = { 'all', '-EXG1', '-EXG2'};
cfg.method     = 'mtmconvol'; % multitaper analysis
cfg.keeptrials = 'yes';
cfg.taper = 'hanning';
cfg.foi        = 3:1:40; % analysis 30 to 80 Hz in steps of 1 Hz
cfg.t_ftimwin  = 5 ./ cfg.foi;
cfg.tapsmofrq  = 0.4 * cfg.foi; % the higher the number, the more smoothing, but respect Shannon number
cfg.toi          = -0.5: 0.01 : 6.5; 
TFRmuitc_ICTKN   = ft_freqanalysis(cfg,data_ICTKN);
save(strcat('TFRmuitc_ICTKN_s',isub{i}),'TFRmuitc_ICTKN')

clear TFRmuitc_ICTKN

clear data_memfr_bdrcmr

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Calculate Intertrial Phase Coherence


%Calculate matrix of complex numbers for every time-frequency point for
%each electrode
load(strcat('TFRmuitc_CTR_s',isub{i}),'TFRmuitc_CTR');

%Create a matrix of absolute values of the complex number for each
%time-frequency point for each electrode
TFRmuitc_CTR_abs_complexnumbers = TFRmuitc_CTR;
TFRmuitc_CTR_abs_complexnumbers.fourierspctrm = abs(TFRmuitc_CTR.fourierspctrm);

%Divide each complex number by its absolute value to normalize magnitude
TFRmuitc_CTR_norm_complexnumbers = TFRmuitc_CTR_abs_complexnumbers;
TFRmuitc_CTR_norm_complexnumbers.fourierspctrm = TFRmuitc_CTR.fourierspctrm ./  TFRmuitc_CTR_abs_complexnumbers.fourierspctrm; 

%Create matrix to hold ITC info
CTR_ITC_map = zeros(64,38,701);

%Average normalized complex numbers across trials
for ichan = 1:length(TFRmuitc_CTR.label)
      
    CTR_ITC_map(ichan,:,:) = mean(TFRmuitc_CTR_norm_complexnumbers.fourierspctrm(:,ichan,:,:));
    
end

%Take absolute value of averaged complex numbers
CTR_ITC_map = abs(CTR_ITC_map);

%Save
save(strcat('CTR_ITC_map_s',isub{i}), 'CTR_ITC_map')

clear TFRmuitc_CTR

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


load(strcat('TFRmuitc_ICTR_s',isub{i}),'TFRmuitc_ICTR');


%Create a matrix of absolute values of the complex number for each
%time-frequency point for each eleICTRode
TFRmuitc_ICTR_abs_complexnumbers = TFRmuitc_ICTR;
TFRmuitc_ICTR_abs_complexnumbers.fourierspctrm = abs(TFRmuitc_ICTR.fourierspctrm);

%Divide each complex number by its absolute value to normalize magnitude
TFRmuitc_ICTR_norm_complexnumbers = TFRmuitc_ICTR_abs_complexnumbers;
TFRmuitc_ICTR_norm_complexnumbers.fourierspctrm = TFRmuitc_ICTR.fourierspctrm ./  TFRmuitc_ICTR_abs_complexnumbers.fourierspctrm; 

%Create matrix to hold ITC info
ICTR_ITC_map = zeros(64,38,701);

%Average normalized complex numbers across trials
for ichan = 1:length(TFRmuitc_ICTR.label)
      
    ICTR_ITC_map(ichan,:,:) = mean(TFRmuitc_ICTR_norm_complexnumbers.fourierspctrm(:,ichan,:,:));
    
end

%Take absolute value of averaged complex numbers
ICTR_ITC_map = abs(ICTR_ITC_map);

%Save
save(strcat('ICTR_ITC_map_s',isub{i}), 'ICTR_ITC_map')

clear TFRmuitc_ICTR


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(strcat('TFRmuitc_CTKN_s',isub{i}),'TFRmuitc_CTKN');

%Create a matrix of absolute values of the complex number for each
%time-frequency point for each eleCTKNode
TFRmuitc_CTKN_abs_complexnumbers = TFRmuitc_CTKN;
TFRmuitc_CTKN_abs_complexnumbers.fourierspctrm = abs(TFRmuitc_CTKN.fourierspctrm);

%Divide each complex number by its absolute value to normalize magnitude
TFRmuitc_CTKN_norm_complexnumbers = TFRmuitc_CTKN_abs_complexnumbers;
TFRmuitc_CTKN_norm_complexnumbers.fourierspctrm = TFRmuitc_CTKN.fourierspctrm ./  TFRmuitc_CTKN_abs_complexnumbers.fourierspctrm; 

%Create matrix to hold ITC info
CTKN_ITC_map = zeros(64,38,701);

%Average normalized complex numbers across trials
for ichan = 1:length(TFRmuitc_CTKN.label)
      
    CTKN_ITC_map(ichan,:,:) = mean(TFRmuitc_CTKN_norm_complexnumbers.fourierspctrm(:,ichan,:,:));
    
end

%Take absolute value of averaged complex numbers
CTKN_ITC_map = abs(CTKN_ITC_map);

%Save
save(strcat('CTKN_ITC_map_s',isub{i}),'CTKN_ITC_map');

clear TFRmuitc_CTKN


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(strcat('TFRmuitc_ICTKN_s',isub{i}),'TFRmuitc_ICTKN');

%Create a matrix of absolute values of the complex number for each
%time-frequency point for each eleICTKNode
TFRmuitc_ICTKN_abs_complexnumbers = TFRmuitc_ICTKN;
TFRmuitc_ICTKN_abs_complexnumbers.fourierspctrm = abs(TFRmuitc_ICTKN.fourierspctrm);

%Divide each complex number by its absolute value to normalize magnitude
TFRmuitc_ICTKN_norm_complexnumbers = TFRmuitc_ICTKN_abs_complexnumbers;
TFRmuitc_ICTKN_norm_complexnumbers.fourierspctrm = TFRmuitc_ICTKN.fourierspctrm ./  TFRmuitc_ICTKN_abs_complexnumbers.fourierspctrm; 

%Create matrix to hold ITC info
ICTKN_ITC_map = zeros(64,38,701);

%Average normalized complex numbers across trials
for ichan = 1:length(TFRmuitc_ICTKN.label)
      
    ICTKN_ITC_map(ichan,:,:) = mean(TFRmuitc_ICTKN_norm_complexnumbers.fourierspctrm(:,ichan,:,:));
    
end

%Take absolute value of averaged complex numbers
ICTKN_ITC_map = abs(ICTKN_ITC_map);

%Save
save(strcat('ICTKN_ITC_map_s',isub{i}),'ICTKN_ITC_map');

clear TFRmuitc_ICTKN

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CTRminICTR_grandavg_ITC = CTR_ITC_map - ICTR_ITC_map;
CTRminCTKN_grandavg_ITC = CTR_ITC_map - CTKN_ITC_map;
ICTRminICTKN_grandavg_ITC = ICTR_ITC_map - ICTKN_ITC_map;

save(strcat('CTRminICTR_grandavg_ITC_s',isub{i}),'CTRminICTR_grandavg_ITC');
save(strcat('CTRminCTKN_grandavg_ITC_s',isub{i}),'CTRminCTKN_grandavg_ITC');
save(strcat('ICTRminICTKN_grandavg_ITC_s',isub{i}),'ICTRminICTKN_grandavg_ITC');

clear CTRminICTR_grandavg_ITC CTRminCTKN_grandavg_ITC ICTRminICTKN_grandavg_ITC clear CTR_ITC_map CTKN_ITC_map ICTR_ITC_map ICTKN_ITC_map



end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
isub = {'36' '38' '39' '42' '44' '45' '48' '49' '50' '53' '55' '57'};

icontrast = {'CTR' 'CTKN' 'ICTR' 'ICTKN'};
isubtract = { 'CTRminICTR' 'CTRminCTKN' 'ICTRminICTKN' };

for a = 1:length(isub)
    
    for i = 1:length(isubtract)
      
        load(strcat(isubtract{i},'_grandavg_ITC_s',isub{a},'.mat'));
        eval(strcat(isubtract{i},'_grandavg_ITC_s',isub{a},' = ',isubtract{i},'_grandavg_ITC;'));
        save(strcat(isubtract{i},'_grandavg_ITC_s',isub{a}),strcat(isubtract{i},'_grandavg_ITC_s',isub{a}));
        clear(strcat(isubtract{i},'_grandavg_ITC_s',isub{a}),strcat(isubtract{i},'_grandavg_ITC'));
        
    end
    
     for i = 1:length(icontrast)
         
         load(strcat(icontrast{i},'_ITC_map_s',isub{a},'.mat'));
         eval(strcat(icontrast{i},'_ITC_map_s',isub{a},' = ',icontrast{i},'_ITC_map;'));
         save(strcat(icontrast{i},'_ITC_map_s',isub{a}),strcat(icontrast{i},'_ITC_map_s',isub{a}));
         clear(strcat(icontrast{i},'_ITC_map_s',isub{a}),strcat(icontrast{i},'_ITC_map'));
     end
        
end

clear all;


isub = { '34' '35' '36' '37'};
icontrast = {'CTR' 'CTKN' 'ICTR' 'ICTKN'};
isubtract = {'CTRminICTR' 'CTRminCTKN' 'ICTRminICTKN'};

for i = 1:length(icontrast)
    
    for a = 1:length(isub)
        
        load(strcat(icontrast{i},'_ITC_map_s',isub{a},'.mat'));
        
    end
    
    
    eval(strcat(icontrast{i},'_ITC_map =',icontrast{i},'_ITC_map_s',isub{a},';'));
    
    for a = 2:length(isub)
        
    eval(strcat(icontrast{i},'_ITC_map(:,:,:,',num2str(a),') =',icontrast{i},'_ITC_map_s',isub{a},';'))

    end
    
    save(strcat(icontrast{i},'_ITC_map'),strcat(icontrast{i},'_ITC_map'));
    clear(strcat(icontrast{i},'_ITC_map'),strcat(icontrast{i},'_ITC_map'));
    
    
end

for i = 1:length(isubtract)
    
    for a = 1:length(isub)
        
        load(strcat(isubtract{i},'_grandavg_ITC_s',isub{a},'.mat'));
        
    end
    
    
    eval(strcat(isubtract{i},'_grandavg_ITC =',isubtract{i},'_grandavg_ITC_s',isub{a},';'));
    
    for a = 1:length(isub)
        
    eval(strcat(isubtract{i},'_grandavg_ITC(:,:,:,',num2str(a),') =',isubtract{i},'_grandavg_ITC_s',isub{a},';'))

    end
    
    save(strcat(isubtract{i},'_grandavg_ITC'),strcat(isubtract{i},'_grandavg_ITC'));
    clear(strcat(isubtract{i},'_grandavg_ITC'),strcat(isubtract{i},'_grandavg_ITC'));
    
end


clear all;

icontrast = {'CTR' 'CTKN' 'ICTR' 'ICTKN'};
isubtract = {'CTRminICTR' 'CTRminCTKN' 'ICTRminICTKN'};

for i = 1:length(icontrast)
       load(strcat(icontrast{i},'_ITC_map.mat'));
    eval(strcat(icontrast{i},'_ITC_map_grandavg =',icontrast{i},'_ITC_map(:,:,:,1);')) 
    for a = 1:64
        for b = 1:38
            for c = 1:401
                

    eval(strcat(icontrast{i},'_ITC_map_grandavg(',num2str(a),',',num2str(b),',',num2str(c),')=mean(',icontrast{i},'_ITC_map(',num2str(a),',',num2str(b),',',num2str(c),',:));'));
    
            end
        end
    end
end

clear all;
    
isub = { '34' '35' '36' '37'};

icontrast = {'CTR' 'CTKN' 'ICTR' 'ICTKN'};


for i = 1:length(isub)
    for a = 1:length(icontrast)
        
load(strcat('TFRmuitc_',icontrast{a},'_s',isub{i},'.mat'))

eval(strcat('TFRmuitc_',icontrast{a},'_s',isub{i},'=TFRmuitc_',icontrast{a}));

save(strcat('TFRmuitc_',icontrast{a},'_s',isub{i}),strcat('TFRmuitc_',icontrast{a},'_s',isub{i}));

clear(strcat('TFRmuitc_',icontrast{a},'_s',isub{i}),strcat('TFRmuitc_',icontrast{a}));


    end
end

for a = 1:length(icontrast)
    
    for i = 1:length(isub)
        
        load(strcat('TFRmuitc_',icontrast{a},'_s',isub{i},'.mat'))
        
    end
    
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.toilim         = 'all';
    eval_stamp = [(strcat(icontrast{a},'_grandavg_TFRmuitc = ft_freqgrandaverage(cfg,TFRmuitc_',icontrast{a},'_s01, TFRmuitc_',icontrast{a},'_s02, TFRmuitc_',icontrast{a},'_s04, TFRmuitc_',icontrast{a},'_s05, TFRmuitc_',icontrast{a},'_s07, TFRmuitc_',icontrast{a},'_s08, TFRmuitc_',icontrast{a},'_s09, TFRmuitc_',icontrast{a},'_s10, TFRmuitc_',icontrast{a},'_s11, TFRmuitc_',icontrast{a},'_s12, TFRmuitc_',icontrast{a},'_s13,TFRmuitc_',icontrast{a},'_s22,TFRmuitc_',icontrast{a},'_s24,TFRmuitc_',icontrast{a},'_s25,TFRmuitc_',icontrast{a},'_s26,TFRmuitc_',icontrast{a},'_s27,TFRmuitc_',icontrast{a},'_s28,TFRmuitc_',icontrast{a},'_s29,TFRmuitc_',icontrast{a},'_s30,TFRmuitc_',icontrast{a},'_s33)'))];
    eval(eval_stamp)
    
    save(strcat(icontrast{a},'_grandavg_TFRmuitc'),strcat(icontrast{a},'_grandavg_TFRmuitc'));
    clear(strcat(icontrast{a},'_grandavg_TFRmuitc'))
    
    for i = 1:length(isub)
        
        clear(strcat('TFRmuitc_',icontrast{a},'_s',isub{i}))
        
    end
    
    
end
    
    
    
    

