function run_preprocesing_Exp1()

subs = {'sub-Exp1s01','sub-Exp1s02','sub-Exp1s03' ,'sub-Exp1s04' ,'sub-Exp1s05' ,'sub-Exp1s06' ,'sub-Exp1s07' ,'sub-Exp1s08' ,'sub-Exp1s09', ...
 'sub-Exp1s10','sub-Exp1s11','sub-Exp1s12','sub-Exp1s13','sub-Exp1s14','sub-Exp1s15','sub-Exp1s16','sub-Exp1s17',...
    'sub-Exp1s18','sub-Exp1s19','sub-Exp1s20'};
    
data_segs = [1];

for i = 1:length(data_segs)
    data_seg = data_segs(i);
    if data_seg == 1
      flags = 'mylwcghko';  
    elseif data_seg == 2
        flags = 'lwcghkorpet';  
    end
    par_batchshebang(subs,data_segs(i),flags)
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