function par_moverawdata(subpar)
%%% to run, type, for example:   par_moverawdata('PE_sub22')
%%% This will transfer volumes from the raw data folder (in
%%% Documents/rawdata_EXPNAME) to the EXPNAME/fmri_data direcotry.  It will
%%% make a folder for the subject in the study, test, and combo directories
%%% and in each subject's folder it will create sub folders for anat and
%%% functional images.  It will move the study phase functionals to the
%%% EXPNAME subject folder and will rename the folders according to phase
%%% (e.g., run4 --> study1).

% ---load par params if need be---
if isstruct(subpar) % if it is par_params struct
    par = subpar;
else % assume subject string
    par = par_params(subpar);
end

% make subject's functional dir
if ~exist(par.funcdir,'dir')
    mkdir(par.funcdir)
else  % if already exists, rename existing with date that it was renamed
    display('Functional directory already exists')
end

% make anat dir
if ~exist(par.anatdir,'dir')
    mkdir(par.anatdir)
else  % if already exists, rename existing with date that it was renamed
    display('Anat directory already exists')
end

raw_anat_dir = fullfile(par.rawdir,par.substr,'anat');
raw_func_dir = fullfile(par.rawdir,par.substr,'func');


% Copy over files if they do not already exist

% T1 anatomy
if ~exist(fullfile(par.anatdir,'t1mprage.nii'),'file')
    display('Copying T1')
    copyfile(fullfile(raw_anat_dir,[par.substr '_T1w.nii']),fullfile(par.anatdir,'t1mprage.nii'))
    copyfile(fullfile(raw_anat_dir,'cal_bo.nii'),fullfile(par.anatdir,'cal_bo.nii'))
    copyfile(fullfile(raw_anat_dir,'cal_reg_bo.nii'),fullfile(par.anatdir,'cal_reg_bo.nii'))
    copyfile(fullfile(raw_anat_dir,'cal_rho.nii'),fullfile(par.anatdir,'cal_rho.nii'))
    copyfile(fullfile(raw_anat_dir,'cal_rs.nii'),fullfile(par.anatdir,'cal_rs.nii'))
end

% Localizer scan
if ~exist(fullfile(par.funcdir,'localizer','localizer.nii'),'file')
    display('Making Localizer Directory')
    mkdir(fullfile(par.funcdir,'localizer'))
    
    display('Copying Localizer Scan')
    copyfile(fullfile(raw_func_dir,[par.substr '_task-localizer_bold.nii']),fullfile(par.funcdir,'localizer','localizer.nii'))
end

% Route Learning Scans
A =dir(fullfile(raw_func_dir,'*run*_bold.nii') );
for i = 1:numel(A)
    scanname = ['scan' A(i).name(36:37)];
    if ~exist(fullfile(par.funcdir,scanname,[scanname '.nii']),'file')
        
        fprintf('Making Directory for %s \n',scanname)
        mkdir(fullfile(par.funcdir,scanname))
        
        fprintf('Copying Directory for %s \n',scanname)
        copyfile(fullfile(raw_func_dir,A(i).name),fullfile(par.funcdir,scanname,[scanname '.nii']))
    end
end

 

cd(par.pardir);
addpath(genpath(pwd));
cd(par.scriptsdir);
