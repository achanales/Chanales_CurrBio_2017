function par = par_params_directories(subject,par)
% Add directory strucure to par structure. 
% This will need to modified if run on different computer. 

%%
fprintf('\nEstablishing Directory Structure for Subject %s...', subject);


%% SPECIFY DIRECTORY NAMES
% ---------Directory names----------
par.pardir = fullfile('/','data','Avi','Route_Learning'); %experiment folder 
par.rawdir = fullfile(par.pardir, 'raw_data'); %folder where the openFMRI data lives
par.scriptsdir = fullfile(par.pardir, 'scripts','Exp1','preprocessing_scripts');
par.groupbehavdir = fullfile(par.pardir, 'behav_data');
par.fmridir = fullfile(par.pardir, 'fmri_data');
par.spmpath = fullfile(par.pardir,'software','spm8');
%---sub specific---
par.subdir = fullfile(par.fmridir, subject);
par.anatdir = fullfile(par.subdir, 'anat');
par.funcdir = fullfile(par.subdir, 'functional');
par.motiondir = fullfile(par.funcdir, 'motion_figures');
par.logdir = fullfile(par.subdir, 'logfiles');
par.resultsdir = fullfile(par.subdir, ['results_model' num2str(par.modelnum)]);
par.behavdir = fullfile(par.subdir, ['behavioral_model' num2str(par.modelnum)]);

end