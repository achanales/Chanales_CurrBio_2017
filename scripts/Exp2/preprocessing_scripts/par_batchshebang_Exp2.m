function par_batchshebang_Exp2(subs, data_seg,flags)
 


for C = 1:length(subs)
    sub = subs{C};
    %Load par params 
     if data_seg == 1 %if its the experiment
        par = par_params_exp_Exp2(sub);
    elseif data_seg == 2 %if its the localizer scan
        par = par_params_loc_Exp2(sub);
     end
    
    
    data_seg = [data_seg]; %1 = experiment %2 = localizer
    par_wholeshebang(par,flags,data_seg);
end



%% Reminder of flag choices
% QUALITY CHECK
% a = use cbi software to create rois for quality check
% q = use cbi software to check for spikes in raw data 


% CREATE IMAGES
% m = moverawdata
% y = create synthetic EPI using CBI script  AC Change 
% h = reslice mprage to functional resolution


% PREPROCESSING
% s = slice timing AC Change now not part of the pre-processing pipeline
% for Kuhl Lab
% l = realign
% w = unwarp
% z = use house made artifcat detection
% c = coregister hires to syntheticEPI or mean-functional
% g = segment and normalize gray matter
% n = normalize functionals
% h = smooth functionals
% k = make specmask

% ANALYSIS
% o = make and move onsets
% r = make regressors
% p = specify model
% e = run model
% t = make contrasts
