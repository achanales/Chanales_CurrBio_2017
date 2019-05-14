clear all;

isub = { '53' '55' '57' };
%'08' '09' '10' '11' '12' '13'   '23' '24' '25' '26' '27' '28' '29'
%'30' '33'

for i = 1:length(isub)

load(strcat('data_memfr_bdr_s',isub{i},'.mat'))

cfg        = [];
% leave eye electrodes in (easier to detect blinks and eye movements)
cfg.channel = {'all','-Status', '-EXG7', '-EXG8' };
cfg.method = 'runica'; % this is the default and uses the implementation from EEGLAB
comp = ft_componentanalysis(cfg, data_memfr_bdr)

save(strcat('comp_s',isub{i}),'comp')
clear data_memfr_bdr

end