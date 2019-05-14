function params = psa_directories(subject,params)
% Add directory strucure to par structure. 
% This will need to modified if run on different computer. 

%%
fprintf('\nEstablishing Directory Structure for Subject %s...', subject);


%% SPECIFY DIRECTORY NAMES
% ---------Directory names----------
params.expDir = fullfile('/','data','Avi','Route_Learning'); %experiment folder 
params.mvpaDir = [params.expDir '/mvpa_data'];
params.subjResults = [params.mvpaDir '/' subject];
params.univar_dir = [params.expDir '/fmri_data/' subject ];
params.functional_dir = [params.univar_dir '/functional'];
params.masks_dir = [params.univar_dir '/roi'];    % this is where all the maks files should be 

if ~exist(params.mvpaDir,'dir')
    mkdir(params.mvpaDir)
end

if ~exist(params.subjResults,'dir')
    mkdir(params.subjResults)
end


end