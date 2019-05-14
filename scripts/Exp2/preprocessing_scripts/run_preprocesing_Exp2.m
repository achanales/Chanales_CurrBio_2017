function run_preprocesing_Exp2()

subs = {'sub-Exp2s01','sub-Exp2s02','sub-Exp2s03','sub-Exp2s04','sub-Exp2s05','sub-Exp2s06','sub-Exp2s07','sub-Exp2s08','sub-Exp2s09', ...
    'sub-Exp2s10','sub-Exp2s11','sub-Exp2s12','sub-Exp2s13','sub-Exp2s14','sub-Exp2s15','sub-Exp2s16','sub-Exp2s17','sub-Exp2s18','sub-Exp2s19','sub-Exp2s20','sub-Exp2s21'};

data_segs = [1];

for i = 1:length(data_segs)
    data_seg = data_segs(i);
    if data_seg == 1
      flags = 'mylwcghko';  
    elseif data_seg == 2
        flags = 'lwcghkorpet';  
    end
    par_batchshebang_Exp2(subs,data_segs(i),flags)
end












%% Reminder of flag choices
% QUALITY CHECK
% a = use cbi software to create rois for quality check
% q = use cbi software to check for spikes in raw data 


% CREATE IMAGES
% m = moverawdata
% y = create synthetic EPI using CBI script  AC Change 


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
