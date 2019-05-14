clear all;

isub = {'57'};

load(strcat('comp_s',isub{1},'.mat'))

cfg = [];
cfg.comp   = [ 1:10 ]; % components to be plotted, blink component
cfg.layout = 'biosemi64.lay'; % specify the layout file that should be used for plotting
ft_componentbrowser(cfg, comp)

% "C" correct data from blinks and horizontal eye movements
% remove the bad components and backproject the data
cfg = [];
cfg.component = [1,7,11,33,38,42,45];
cfg.channel = {'all'};% to be removed one component %blink and horizontal eye movement, and 2 muslce-activity/noise components
data_memfr_bdrc = ft_rejectcomponent(cfg, comp)

save(strcat('data_memfr_bdrc_s',isub{1}),'data_memfr_bdrc')

%08: 1,2,4,6,13,20,32,43,60,67,69

%09: 1,4,18,33,37,70

%10: 3,16,22,36,38,39,45,55,56,69,70

%11: 4,7,10,18,19,20,15,25,21,27,36,59

%12: 3,7,9,10,12,13,15,16,18,21,31,43,45,64,67

%13: 1,29,41,46,57,62,69

%22: 1,7,10,19,38,40,49,57

%23: 1,2,14,23

%24: 1,2,3,4,5,18,29,34,37,51,52,67

%25: 1,2,4,6,8,5,15,22,24,37,46,55,68

%26: 1,3,4,15,32,47,54,68,69

%27: 1,5,8,20,52

%28: 1,14,32

%29: 1,4,7,8,14,16,24,31,46,51

%30: 1,2,10,3,4,21,22,28,40,34,66,68

%33: 1,2,9,17,21,29,49,54

%34: 1,2,5,9,10,14,20,21,42,46,68

%35: 

%36: 1,6,7,8,9,10,11,14,15,19,21,23,28,31,32,41,43,47,53,66,69

%37: 1,6,4,2,31,56,70

%38: 1,2,4,9,25,33,39,40,60,52,61,62,68

%39: 1,2,3,4,5,11,17,51,63,68

%41: 1,2,3,14,28,57,69

%42: 1,3,6,17,19,20,47,48,57,58,68,69,70,61

%43: 1,5,37,48,57,68,69

%44: 1,2,44,53,54,57

%45: 1

%46: 1,2,8,9,13,15,21,22,23,24,25,33,34,38,46,50,52,56,59,60,63

%47: 1,8,10

%48: 1,3,24,31,44,63

%49: 1,2,3,4,7,24,28,39

%53: 1,4,12,18,19,46,48,49,59,62

%55: 1,2,5,7,16,32,36,56

%57: 1,7,11,33,38,42,45