% FT_FREQSTATISTICS computes significance probabilities and/or critical values of a parametric statistical test
% or a non-parametric permutation test.
%
% Use as
%   [stat] = ft_freqstatistics(cfg, freq1, freq2, ...)
% where the input data is the result from FT_FREQANALYSIS, FT_FREQDESCRIPTIVES
% or from FT_FREQGRANDAVERAGE.
%
% The configuration can contain the following options for data selection
%   cfg.channel     = Nx1 cell-array with selection of channels (default = 'all'),
%                     see FT_CHANNELSELECTION for details
%   cfg.latency     = [begin end] in seconds or 'all' (default = 'all')
%   cfg.frequency   = [begin end], can be 'all'       (default = 'all')
%   cfg.avgoverchan = 'yes' or 'no'                   (default = 'no')
%   cfg.avgovertime = 'yes' or 'no'                   (default = 'no')
%   cfg.avgoverfreq = 'yes' or 'no'                   (default = 'no')
%   cfg.parameter   = string                          (default = 'powspctrm')
%
% Furthermore, the configuration should contain
%   cfg.method       = different methods for calculating the significance probability and/or critical value
%                    'montecarlo' get Monte-Carlo estimates of the significance probabilities and/or critical values from the permutation distribution,
%                    'analytic'   get significance probabilities and/or critical values from the analytic reference distribution (typically, the sampling distribution under the null hypothesis),
%                    'stats'      use a parametric test from the Matlab statistics toolbox,
%                    'glm'        use a general linear model approach.
%
% The other cfg options depend on the method that you select. You
% should read the help of the respective subfunction STATISTICS_XXX
% for the corresponding configuration options and for a detailed
% explanation of each method.
%
% See also FT_FREQANALYSIS, FT_FREQDESCRIPTIVES, FT_FREQGRANDAVERAGE

% Undocumented local options:
%   cfg.inputfile  = one can specifiy preanalysed saved data as input
%                     The data should be provided in a cell array
%   cfg.outputfile = one can specify output as file to save to disk





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Montecarlo Stats                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;

data1 = {'R' 'CTR' 'CTR' 'ICTR' 'CTR' 'ICTR'};
data2 = {'KN' 'ICTR' 'CTKN' 'ICTKN' 'CR' 'CR'};

%data1 = {'CTR'};
%data2 = {'ICTR'};

freq_bin = {'4 8' '9 12' '13 20' '20 38'}; 
%freq_bin = {'9 12'};
freq_label = {'theta' 'alpha' 'beta' 'gamma'};
%freq_label = {'alpha'};

for icond = 1:length(data1)
    
    for a=1:length(freq_label)
    
    load(strcat(data1{icond},'_ind_grandavg_TFR'));
    load(strcat(data2{icond},'_ind_grandavg_TFR'));
    
    [cap_coords_num cap_coords_txt] = xlsread('/Users/aheusser/Desktop/TCP_EEG/RKN/TF/cap_coords_64.xls');
    
    eval(strcat(data1{icond},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data1{icond},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    eval(strcat(data2{icond},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data2{icond},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    
    cfg = [];
    %cfg.channel          = {'MEG'};
    cfg.latency          = [2 8];
    eval(strcat('cfg.frequency        = [',freq_bin{a},'];'));
    cfg.avgoverfreq = 'yes' ;
    cfg.method           = 'montecarlo';
    cfg.statistic        = 'depsamplesT';
    cfg.correctm         = 'cluster';
    cfg.clusteralpha     = 0.05;
    cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 2;
    cfg.tail             = 0;
    cfg.clustertail      = 0;
    cfg.alpha            = 0.05;
    cfg.numrandomization = 1000;
    cfg.neighbourdist = .3991;
    
    subj = 24;
    design = zeros(2,2*subj);
    for i = 1:subj
        design(1,i) = i;
    end
    for i = 1:subj
        design(1,subj+i) = i;
    end
    design(2,1:subj)        = 1;
    design(2,subj+1:2*subj) = 2;
    
    cfg.design   = design;
    cfg.uvar     = 1;
    cfg.ivar     = 2;
    
    eval(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_stats = ft_freqstatistics(cfg,',data1{icond},'_ind_grandavg_TFR,',data2{icond},'_ind_grandavg_TFR)'));
    save(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_stats'),strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_stats'));
    
end




end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Analytic Stats                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

data1 = {'R' 'CTR' 'CTR' 'ICTR' 'CTR' 'ICTR'};
data2 = {'KN' 'ICTR' 'CTKN' 'ICTKN' 'CR' 'CR'};
freq_bin = {'4 8' '9 12' '13 20' '20 38'}; 
freq_label = {'theta' 'alpha' 'beta' 'gamma'};

for icond = 1:length(data1)
    
    for a=1:length(freq_label)
    
    load(strcat(data1{icond},'_ind_grandavg_TFR'));
    load(strcat(data2{icond},'_ind_grandavg_TFR'));
    
    [cap_coords_num cap_coords_txt] = xlsread('/Users/aheusser/Desktop/TCP_EEG/RKN/TF/cap_coords_64.xls');
    
    eval(strcat(data1{icond},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data1{icond},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    eval(strcat(data2{icond},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data2{icond},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    
    cfg = [];
    %cfg.channel          = {'MEG'};
    cfg.latency          = [2 8];
    eval(strcat('cfg.frequency        = [',freq_bin{a},'];'));
    cfg.avgoverfreq = 'yes' ;
    cfg.method           = 'analytic';
    cfg.statistic        = 'depsamplesT';
    %cfg.correctm         = 'cluster';
    cfg.clusteralpha     = 0.05;
    %cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 2;
    cfg.tail             = 0;
    cfg.clustertail      = 0;
    cfg.alpha            = 0.05;
    cfg.numrandomization = 1000;
    cfg.neighbourdist = .3991;
    
    subj = 24;
    design = zeros(2,2*subj);
    for i = 1:subj
        design(1,i) = i;
    end
    for i = 1:subj
        design(1,subj+i) = i;
    end
    design(2,1:subj)        = 1;
    design(2,subj+1:2*subj) = 2;
    
    cfg.design   = design;
    cfg.uvar     = 1;
    cfg.ivar     = 2;
    
    eval(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_analytic_stats = ft_freqstatistics(cfg,',data1{icond},'_ind_grandavg_TFR,',data2{icond},'_ind_grandavg_TFR)'));
    save(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_analytic_stats'),strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_analytic_stats'));
    
end




end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Analytic Anova Stats                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

data1 = {'CTR' 'ICTR'};
data2 = {'CTKN' 'ICTKN'};
freq_bin = {'4 8' '9 12' '13 20' '21 38'}; 
freq_label = {'theta' 'alpha' 'beta' 'gamma'};


    
    for a=1:length(freq_label)
    
    load(strcat(data1{1},'_ind_grandavg_TFR'));
    load(strcat(data2{1},'_ind_grandavg_TFR'));
    load(strcat(data1{2},'_ind_grandavg_TFR'));
    load(strcat(data2{2},'_ind_grandavg_TFR'));
    
    [cap_coords_num cap_coords_txt] = xlsread('/Users/aheusser/Desktop/TCP_EEG/RKN/TF/cap_coords_64.xls');
    
    eval(strcat(data1{1},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data1{1},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    eval(strcat(data2{1},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data2{1},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    
    eval(strcat(data1{2},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data1{2},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    eval(strcat(data2{2},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data2{2},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    
    cfg = [];
    %cfg.channel          = {'MEG'};
    %cfg.latency          = [2 4.5];
    eval(strcat('cfg.frequency        = [',freq_bin{a},'];'));
    cfg.avgoverfreq = 'yes' ;
    cfg.method           = 'analytic';
    cfg.statistic        = 'depsamplesF';
    %cfg.correctm         = 'cluster';
    %cfg.clusteralpha     = 0.05;
    %cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 2;
    cfg.tail             = 1;
    cfg.clustertail      = 0;
    cfg.alpha            = 0.05;
    %cfg.numrandomization = 1000;
    %cfg.neighbourdist = 2.5;
    
    subj = 24;
    design = zeros(2,4*subj);
    for i = 1:subj
        design(1,i) = i;
    end
    
    for i = 1:subj
        design(1,subj+i) = i;
    end
    
    for i = 1:subj
        design(1,2*subj+i) = i;
    end
    
    for i = 1:subj
        design(1,3*subj+i) = i;
    end
    
    design(2,1:subj)        = 1;
    design(2,subj+1:2*subj) = 2;
    design(2,subj*2+1:3*subj) = 3;
    design(2,subj*3+1:4*subj) = 4;
 
    
    cfg.design   = design;
    cfg.uvar     = 1;
    cfg.ivar     = 2;
    
    eval(strcat(data1{1},data2{1},'min',data2{1},data1{2},'_',freq_label{a},'_analytic_anova = ft_freqstatistics(cfg,',data1{1},'_ind_grandavg_TFR,',data1{2},'_ind_grandavg_TFR,',data2{1},'_ind_grandavg_TFR,',data2{2},'_ind_grandavg_TFR)'));
    %save(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_analytic_anova'),strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_anova'));
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Montecarlo Anova Stats                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

data1 = {'CTR' 'ICTR'};
data2 = {'CTKN' 'ICTKN'};
freq_bin = {'4 8' '9 12' '13 20' '21 38'}; 
freq_label = {'theta' 'alpha' 'beta' 'gamma'};


    
    for a=1:length(freq_label)
    
    load(strcat(data1{1},'_ind_grandavg_TFR'));
    load(strcat(data2{1},'_ind_grandavg_TFR'));
    load(strcat(data1{2},'_ind_grandavg_TFR'));
    load(strcat(data2{2},'_ind_grandavg_TFR'));
    
    [cap_coords_num cap_coords_txt] = xlsread('/Users/aheusser/Desktop/TCP_EEG/RKN/TF/cap_coords_64.xls');
    
    eval(strcat(data1{1},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data1{1},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    eval(strcat(data2{1},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data2{1},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    
    eval(strcat(data1{2},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data1{2},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    eval(strcat(data2{2},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
    eval(strcat(data2{2},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
    
    cfg = [];
    %cfg.channel          = {'MEG'};
    %cfg.latency          = [2 4.5];
    eval(strcat('cfg.frequency        = [',freq_bin{a},'];'));
    cfg.avgoverfreq = 'yes' ;
    cfg.method           = 'montecarlo';
    cfg.statistic        = 'depsamplesF';
    cfg.correctm         = 'cluster';
    cfg.clusteralpha     = 0.05;
    cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 2;
    cfg.tail             = 1;
    cfg.clustertail      = 1;
    cfg.alpha            = 0.025;
    cfg.numrandomization = 1000;
    cfg.neighbourdist = .3991;
    
    subj = 24;
    design = zeros(2,4*subj);
    for i = 1:subj
        design(1,i) = i;
    end
    
    for i = 1:subj
        design(1,subj+i) = i;
    end
    
    for i = 1:subj
        design(1,2*subj+i) = i;
    end
    
    for i = 1:subj
        design(1,3*subj+i) = i;
    end
    
    design(2,1:subj)        = 1;
    design(2,subj+1:2*subj) = 2;
    design(2,subj*2+1:3*subj) = 3;
    design(2,subj*3+1:4*subj) = 4;
 
    
    cfg.design   = design;
    cfg.uvar     = 1;
    cfg.ivar     = 2;
    
    eval(strcat(data1{1},data2{1},'min',data2{1},data1{2},'_',freq_label{a},'_analytic_anova = ft_freqstatistics(cfg,',data1{1},'_ind_grandavg_TFR,',data1{2},'_ind_grandavg_TFR,',data2{1},'_ind_grandavg_TFR,',data2{2},'_ind_grandavg_TFR)'));
    %save(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_analytic_anova'),strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_anova'));
    
    end


    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Gamma Analytic Stats                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

data1 = {'CTR' 'CTR' 'ICTR'};
data2 = {'ICTR' 'CTKN' 'ICTKN'};
%freq_bin = {}; 
freq_label = {'high_gamma'};

for icond = 1:length(data1)
    
    for a = 1:length(freq_label)
        
        load(strcat(data1{icond},'_ind_gamma_V1V2_grandavg_TFR'));
        load(strcat(data2{icond},'_ind_gamma_V1V2_grandavg_TFR'));
        
        [cap_coords_num cap_coords_txt] = xlsread('/Users/aheusser/Desktop/TCP_EEG/RKN/TF/cap_coords_64.xls');
        
        eval(strcat(data1{icond},'_ind_gamma_V1V2_grandavg_TFR.elec.label = cap_coords_txt;'));
        eval(strcat(data1{icond},'_ind_gamma_V1V2_grandavg_TFR.elec.pnt = cap_coords_num;'));
        eval(strcat(data2{icond},'_ind_gamma_V1V2_grandavg_TFR.elec.label = cap_coords_txt;'));
        eval(strcat(data2{icond},'_ind_gamma_V1V2_grandavg_TFR.elec.pnt = cap_coords_num;'));
        
        cfg = [];
        %cfg.channel          = {'MEG'};
        cfg.latency          = [2 8];
        %eval(strcat('cfg.frequency        = [',freq_bin{a},'];'));
        cfg.avgoverfreq = 'yes' ;
        cfg.method           = 'analytic';
        cfg.statistic        = 'depsamplesT';
        %cfg.correctm         = 'cluster';
        cfg.clusteralpha     = 0.05;
        %cfg.clusterstatistic = 'maxsum';
        cfg.minnbchan        = 2;
        cfg.tail             = 0;
        cfg.clustertail      = 0;
        cfg.alpha            = 0.025;
        cfg.numrandomization = 1000;
        cfg.neighbourdist = .3991;
        
        subj = 24;
        design = zeros(2,2*subj);
        for i = 1:subj
            design(1,i) = i;
        end
        for i = 1:subj
            design(1,subj+i) = i;
        end
        design(2,1:subj)        = 1;
        design(2,subj+1:2*subj) = 2;
        
        cfg.design   = design;
        cfg.uvar     = 1;
        cfg.ivar     = 2;
        
        eval(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_analytic_stats = ft_freqstatistics(cfg,',data1{icond},'_ind_gamma_V1V2_grandavg_TFR,',data2{icond},'_ind_gamma_V1V2_grandavg_TFR)'));
        save(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_analytic_stats'),strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_analytic_stats'));
        
    end
    
    
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Gamma Montecarlo Stats                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

data1 = {'CTR' 'CTR' 'ICTR'};
data2 = {'ICTR' 'CTKN' 'ICTKN'};
%freq_bin = {}; 
freq_label = {'high_gamma'};

for icond = 1:length(data1)
    
    for a = 1:length(freq_label)
        
        load(strcat(data1{icond},'_ind_gamma_V1V2_grandavg_TFR'));
        load(strcat(data2{icond},'_ind_gamma_V1V2_grandavg_TFR'));
        
        [cap_coords_num cap_coords_txt] = xlsread('/Users/aheusser/Desktop/TCP_EEG/RKN/TF/cap_coords_64.xls');
        
        eval(strcat(data1{icond},'_ind_gamma_V1V2_grandavg_TFR.elec.label = cap_coords_txt;'));
        eval(strcat(data1{icond},'_ind_gamma_V1V2_grandavg_TFR.elec.pnt = cap_coords_num;'));
        eval(strcat(data2{icond},'_ind_gamma_V1V2_grandavg_TFR.elec.label = cap_coords_txt;'));
        eval(strcat(data2{icond},'_ind_gamma_V1V2_grandavg_TFR.elec.pnt = cap_coords_num;'));
        
        cfg = [];
        %cfg.channel          = {'MEG'};
        cfg.latency          = [2 8];
        %eval(strcat('cfg.frequency        = [',freq_bin{a},'];'));
        cfg.avgoverfreq = 'yes' ;
        cfg.method           = 'montecarlo';
        cfg.statistic        = 'depsamplesT';
        cfg.correctm         = 'cluster';
        cfg.clusteralpha     = 0.05;
        cfg.clusterstatistic = 'maxsum';
        cfg.minnbchan        = 2;
        cfg.tail             = 0;
        cfg.clustertail      = 0;
        cfg.alpha            = 0.025;
        cfg.numrandomization = 1000;
        cfg.neighbourdist = .3991;
        
        subj = 24;
        design = zeros(2,2*subj);
        for i = 1:subj
            design(1,i) = i;
        end
        for i = 1:subj
            design(1,subj+i) = i;
        end
        design(2,1:subj)        = 1;
        design(2,subj+1:2*subj) = 2;
        
        cfg.design   = design;
        cfg.uvar     = 1;
        cfg.ivar     = 2;
        
        eval(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_stats = ft_freqstatistics(cfg,',data1{icond},'_ind_gamma_V1V2_grandavg_TFR,',data2{icond},'_ind_gamma_V1V2_grandavg_TFR)'));
        save(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_stats'),strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_stats'));
        
    end
    
    
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            ITC Analytic Stats                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

data1 = {'CTR' 'CTR' 'ICTR'};
data2 = {'ICTR' 'CTKN' 'ICTKN'};
freq_bin = {'4 8' '9 12' '13 20' '20 38'}; 
freq_label = {'theta' 'alpha' 'beta' 'gamma'};

for icond = 1:length(data1)
    
    for a = 1:length(freq_label)
        
        load(strcat(data1{icond},'_ind_ITC_map'));
        load(strcat(data2{icond},'_ind_ITC_map'));
        
        [cap_coords_num cap_coords_txt] = xlsread('/Users/aheusser/Desktop/TCP_EEG/RKN/TF/cap_coords_64.xls');
        
        eval(strcat(data1{icond},'_ind_ITC_map.elec.label = cap_coords_txt;'));
        eval(strcat(data1{icond},'_ind_ITC_map.elec.pnt = cap_coords_num;'));
        eval(strcat(data2{icond},'_ind_ITC_map.elec.label = cap_coords_txt;'));
        eval(strcat(data2{icond},'_ind_ITC_map.elec.pnt = cap_coords_num;'));
        
        cfg = [];
        %cfg.channel          = {'MEG'};
        cfg.latency          = [2 8];
        eval(strcat('cfg.frequency        = [',freq_bin{a},'];'));
        cfg.avgoverfreq = 'yes' ;
        cfg.method           = 'analytic';
        cfg.statistic        = 'depsamplesT';
        cfg.correctm         = 'cluster';
        cfg.clusteralpha     = 0.05;
        cfg.clusterstatistic = 'maxsum';
        cfg.minnbchan        = 2;
        cfg.tail             = 0;
        cfg.clustertail      = 0;
        cfg.alpha            = 0.025;
        cfg.numrandomization = 1000;
        cfg.neighbourdist = .3991;
        
        subj = 24;
        design = zeros(2,2*subj);
        for i = 1:subj
            design(1,i) = i;
        end
        for i = 1:subj
            design(1,subj+i) = i;
        end
        design(2,1:subj)        = 1;
        design(2,subj+1:2*subj) = 2;
        
        cfg.design   = design;
        cfg.uvar     = 1;
        cfg.ivar     = 2;
        
        eval(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_analytic_ITC_stats = ft_freqstatistics(cfg,',data1{icond},'_ind_ITC_map,',data2{icond},'_ind_ITC_map)'));
        save(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_analytic_ITC_stats'),strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_analytic_ITC_stats'));
        
    end
    
    
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            ITC Montecarlo Stats                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

data1 = {'CTR' 'CTR' 'ICTR'};
data2 = {'ICTR' 'CTKN' 'ICTKN'};
freq_bin = {'4 8' '9 12' '13 20' '20 38'}; 
freq_label = {'theta' 'alpha' 'beta' 'gamma'};

for icond = 1:length(data1)
    
    for a = 1:length(freq_label)
        
        load(strcat(data1{icond},'_ind_ITC_map'));
        load(strcat(data2{icond},'_ind_ITC_map'));
        
        [cap_coords_num cap_coords_txt] = xlsread('/Users/aheusser/Desktop/TCP_EEG/RKN/TF/cap_coords_64.xls');
        
        eval(strcat(data1{icond},'_ind_ITC_map.elec.label = cap_coords_txt;'));
        eval(strcat(data1{icond},'_ind_ITC_map.elec.pnt = cap_coords_num;'));
        eval(strcat(data2{icond},'_ind_ITC_map.elec.label = cap_coords_txt;'));
        eval(strcat(data2{icond},'_ind_ITC_map.elec.pnt = cap_coords_num;'));
        
        cfg = [];
        %cfg.channel          = {'MEG'};
        cfg.latency          = [2 8];
        eval(strcat('cfg.frequency        = [',freq_bin{a},'];'));
        cfg.avgoverfreq = 'yes' ;
        cfg.method           = 'montecarlo';
        cfg.statistic        = 'depsamplesT';
        cfg.correctm         = 'cluster';
        cfg.clusteralpha     = 0.05;
        cfg.clusterstatistic = 'maxsum';
        cfg.minnbchan        = 2;
        cfg.tail             = 0;
        cfg.clustertail      = 0;
        cfg.alpha            = 0.025;
        cfg.numrandomization = 1000;
        cfg.neighbourdist = .3991;
        
        subj = 24;
        design = zeros(2,2*subj);
        for i = 1:subj
            design(1,i) = i;
        end
        for i = 1:subj
            design(1,subj+i) = i;
        end
        design(2,1:subj)        = 1;
        design(2,subj+1:2*subj) = 2;
        
        cfg.design   = design;
        cfg.uvar     = 1;
        cfg.ivar     = 2;
        
        eval(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_ITC_stats = ft_freqstatistics(cfg,',data1{icond},'_ind_ITC_map,',data2{icond},'_ind_ITC_map)'));
        save(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_ITC_stats'),strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_ITC_stats'));
        
    end
    
    
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Correlation Matrices                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;

load('CTR_ind_grandavg_TFR');
load('CTKN_ind_grandavg_TFR');
load('ICTR_ind_grandavg_TFR');
load('ICTKN_ind_grandavg_TFR');

alpha_timebin = {'151:160' '161:170' '171:180' '181:190' '191:200'};
theta_timebin = {'201:210' '211:220' '221:230' '231:240' '241:250' '251:260' '261:270' '271:280' '281:290' '291:300'};

CTRminCTKN_correl = [];


for ichan1 = 1:64
    tic
    for ichan2 = 1:64
        
        for ialpha = 1:length(alpha_timebin)
            
            for itheta = 1:length(theta_timebin)
                
                
                
                eval(strcat('CTRminCTKN_prestim_alpha = CTR_ind_grandavg_TFR.powspctrm(:,',num2str(ichan1),',7:10,',alpha_timebin{ialpha},') - CTKN_ind_grandavg_TFR.powspctrm(:,',num2str(ichan1),',7:10,',alpha_timebin{ialpha},');'));
                
                CTRminCTKN_prestim_alpha_ind = [];
                
                for i = 1:24
                    
                    CTRminCTKN_prestim_alpha_ind(i) =  mean(mean(CTRminCTKN_prestim_alpha(i,:,:,:)));
                    
                end
                
                CTRminCTKN_prestim_alpha_ind = CTRminCTKN_prestim_alpha_ind';
                
                
                
                eval(strcat('CTRminCTKN_poststim_theta = CTR_ind_grandavg_TFR.powspctrm(:,',num2str(ichan2),',2:6,',theta_timebin{itheta},') - CTKN_ind_grandavg_TFR.powspctrm(:,',num2str(ichan2),',2:6,',theta_timebin{itheta},');'));
                
                CTRminCTKN_poststim_theta_ind = [];
                
                for i = 1:24
                    
                    CTRminCTKN_poststim_theta_ind(i) =  mean(mean(CTRminCTKN_poststim_theta(i,:,:,:)));
                    
                end
                
                CTRminCTKN_poststim_theta_ind = CTRminCTKN_poststim_theta_ind';
                
                CTRminCTKN_correl(ichan1,ichan2,ialpha,itheta) = corr(CTRminCTKN_prestim_alpha_ind,CTRminCTKN_poststim_theta_ind);
                
                
                
            end
        end
        toc
    end
    
    
end

save('CTRminCTKN_correl', 'CTRminCTKN_correl');


ICTRminICTKN_correl = [];


for ichan1 = 1:64
    tic
    for ichan2 = 1:64
        
        for ialpha = 1:length(alpha_timebin)
            
            for itheta = 1:length(theta_timebin)
                
                
                
                eval(strcat('ICTRminICTKN_prestim_alpha = CTR_ind_grandavg_TFR.powspctrm(:,',num2str(ichan1),',7:10,',alpha_timebin{ialpha},') - CTKN_ind_grandavg_TFR.powspctrm(:,',num2str(ichan1),',7:10,',alpha_timebin{ialpha},');'));
                
                ICTRminICTKN_prestim_alpha_ind = [];
                
                for i = 1:24
                    
                    ICTRminICTKN_prestim_alpha_ind(i) =  mean(mean(ICTRminICTKN_prestim_alpha(i,:,:,:)));
                    
                end
                
                ICTRminICTKN_prestim_alpha_ind = ICTRminICTKN_prestim_alpha_ind';
                
                
                
                eval(strcat('ICTRminICTKN_poststim_theta = CTR_ind_grandavg_TFR.powspctrm(:,',num2str(ichan2),',2:6,',theta_timebin{itheta},') - CTKN_ind_grandavg_TFR.powspctrm(:,',num2str(ichan2),',2:6,',theta_timebin{itheta},');'));
                
                ICTRminICTKN_poststim_theta_ind = [];
                
                for i = 1:24
                    
                    ICTRminICTKN_poststim_theta_ind(i) =  mean(mean(ICTRminICTKN_poststim_theta(i,:,:,:)));
                    
                end
                
                ICTRminICTKN_poststim_theta_ind = ICTRminICTKN_poststim_theta_ind';
                
                ICTRminICTKN_correl(ichan1,ichan2,ialpha,itheta) = corr(ICTRminICTKN_prestim_alpha_ind,ICTRminICTKN_poststim_theta_ind);
                
                
                
            end
        end
        toc
    end
    
    
end

save('ICTRminICTKN_correl', 'ICTRminICTKN_correl');






figure;
cfg=[];
cfg.interactive = 'yes';
cfg.layout    = 'biosemi64.lay';
%cfg.ylim = [ 3 20 ];
cfg.zlim = [-500 500];
%cfg.xlim = [3 5];
%cfg.baseline = [-0.2 0.0];
%cfg.baseline = [3.8 4.0];
cfg.colorbar = 'yes';
ft_multiplotTFR(cfg, CTRminICTR_V1V2_grandavg_TFR); 










cfg = [];
cfg.alpha  = .025;
cfg.zparam = 'stat';
cfg.zlim   = [-4 4];
cfg.layout = 'biosemi64.lay';
clusterplot(cfg, CTRminCTKN_gamma_montecarlo_ITC_stats);


% plot uncorrected "significant" channels
cfg = [];
cfg.layout = 'biosemi64.lay';
cfg.highlight = 'on';
cfg.highlightchannel = find(CTRminICTR_alpha_analytic_stats.mask>0);
%cfg.comment   = 'no';
figure; ft_topoplotTFR(cfg, CTRminICTR_alpha_analytic_stats)
title('significant without multiple comparison correction')




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Montecarlo Stats                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sub = {'02'};
% condition = {'CTR'};
% for icond = 1:length(condition)
% 
% eval(strcat(condition{icond},'_ind_ITC_map = [];'))
%     
% for isub = 1:length(sub)
%     
%    load(strcat(condition{icond},'_ITC_map_s',sub{isub},'.mat;'));
%     eval(strcat(condition{icond},'_ind_ITC_map(',num2str(i),') = ',condition{icond},'_ITC_map;'));
% end
% 
% end
% 
% 
%     
%     
% 
% 
% 
% clear all;
% 
% data1 = {'R' 'CTR' 'CTR' 'ICTR' 'CTR' 'ICTR'};
% data2 = {'KN' 'ICTR' 'CTKN' 'ICTKN' 'CR' 'CR'};
% 
% %data1 = {'CTR'};
% %data2 = {'ICTR'};
% 
% freq_bin = {'4 8' '9 12' '13 20' '20 38'}; 
% %freq_bin = {'9 12'};
% freq_label = {'theta' 'alpha' 'beta' 'gamma'};
% %freq_label = {'alpha'};
% 
% for icond = 1:length(data1)
%     
%     for a=1:length(freq_label)
%     
%     load(strcat(data1{icond},'_ind_grandavg_TFR'));
%     load(strcat(data2{icond},'_ind_grandavg_TFR'));
%     
%     [cap_coords_num cap_coords_txt] = xlsread('/Users/aheusser/Desktop/TCP_EEG/RKN/TF/cap_coords_64.xls');
%     
%     eval(strcat(data1{icond},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
%     eval(strcat(data1{icond},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
%     eval(strcat(data2{icond},'_ind_grandavg_TFR.elec.label = cap_coords_txt;'));
%     eval(strcat(data2{icond},'_ind_grandavg_TFR.elec.pnt = cap_coords_num;'));
%     
%     cfg = [];
%     %cfg.channel          = {'MEG'};
%     cfg.latency          = [2 8];
%     eval(strcat('cfg.frequency        = [',freq_bin{a},'];'));
%     cfg.avgoverfreq = 'yes' ;
%     cfg.method           = 'montecarlo';
%     cfg.statistic        = 'depsamplesT';
%     cfg.correctm         = 'cluster';
%     cfg.clusteralpha     = 0.1;
%     cfg.clusterstatistic = 'maxsum';
%     cfg.minnbchan        = 2;
%     cfg.tail             = 0;
%     cfg.clustertail      = 0;
%     cfg.alpha            = 0.05;
%     cfg.numrandomization = 1000;
%     cfg.neighbourdist = .3991;
%     
%     subj = 24;
%     design = zeros(2,2*subj);
%     for i = 1:subj
%         design(1,i) = i;
%     end
%     for i = 1:subj
%         design(1,subj+i) = i;
%     end
%     design(2,1:subj)        = 1;
%     design(2,subj+1:2*subj) = 2;
%     
%     cfg.design   = design;
%     cfg.uvar     = 1;
%     cfg.ivar     = 2;
%     
%     eval(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_stats = ft_freqstatistics(cfg,',data1{icond},'_ind_grandavg_TFR,',data2{icond},'_ind_grandavg_TFR)'));
%     save(strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_stats'),strcat(data1{icond},'min',data2{icond},'_',freq_label{a},'_montecarlo_stats'));
%     
% end
% 
% 
% 
% 
% end
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
