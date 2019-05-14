% Rereferencing the artefact-free data to "M" mastoids 
% "M" mastoids-reference

clear all;

isub = {'53' '55' '57'};

for i = 1:length(isub)

load(strcat('data_memfr_bdrc_s',isub{i},'.mat'));
cfg = [];

cfg.reref       = 'yes';
cfg.refchannel  = {'EXG1', 'EXG2'}; % the average of the two mastoid channels is used as the new reference

data_memfr_bdrcm = ft_preprocessing(cfg, data_memfr_bdrc); 

save(strcat('data_memfr_bdrcm_s',isub{i}),'data_memfr_bdrcm')

end

%subject 39 ref electrodes are names EXG1-1 and EXG2-1