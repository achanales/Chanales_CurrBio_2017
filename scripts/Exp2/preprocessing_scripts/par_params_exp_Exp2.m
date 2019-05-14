function par = par_params_exp(subject)
% Basic parameter specification directory.  Creates par struct which can be
% used in par_ functions as the subpar argument
%  

%%
fprintf('\nEstablishing Parameters for Subject %s...', subject);

spm_get_defaults; %set-up defaults (also makes sure spm is happily in the path)


par.substr = subject;
% convert sub string to number to simplify things later-- assumes s##
% format
par.subnum = str2double(subject(end-1:end));
par.modelnum = 1; %AC Change
par.data_seg = 1;

%Get directory stucture
par = par_params_directories_Exp2(subject,par);

%addpaths
 addpath(genpath(par.pardir));

%% SPECIFY BASIC SCAN PARAMETERS
%----------Scan Params----------------

%Load Runs Info
excelFile = [subject '_runinfo.txt']; %must be a text file
stimList = read_table(excelFile);
    %col 1 = study runs
    %col 2 = loclaizer runs
par.studyruns = stimList.col1(end);
%par.replayruns = stimList.col2(end);
par.numscans = par.studyruns;

par.TR = 1.5; % TR in seconds

par.numslice = 26; % AC change 

par.TA = par.TR-par.TR/par.numslice; %TA

% par.sliceorder = 1:1:par.numslice; %slice order (assumes ascending)  -- no change for brice
par.sliceorder = [1:2:par.numslice 2:2:par.numslice];  % interleaved ascending, but NOTE that Siemens starts with even slice # if total slices is even (e.g., 34) AC CHANGE = since we have an odd # of slices changes so that its it starts with 1 not 2
par.refslice = floor(par.numslice/2); %reference slice (assumes middle) -- no change for brice (gives 15) %AC comment will now give 17


par.dropvol = 6; % how many of the 1st volumes are dropped
par.minvol = par.dropvol+1; % first non-dropped volume

for studyrun = 1:par.studyruns
    par.maxvol(studyrun) = stimList.col1(studyrun);
end

%There are no replay runs in this study
% for replayrun = 1:par.replayruns
%     par.maxvol(replayrun+studyrun) = stimList.col2(replayrun);
% end

for loopscans=1:par.numscans
    par.numvols(loopscans) = par.maxvol(loopscans) - par.dropvol;
end

%Info for creating syntetic EPI 
par.TE = 23; %AC Change
par.echospacing = 400; %AC Change
par.convertedTE = (par.TE/par.echospacing)*1000; %AC Change
par.readoutdir = 1; %AC 1, -1 or 0 
par.synthEPIname = 'synthEPI.nii'; %AC Change Make sure this name is the same name as the filename par.synthEPI will look for below

% anat info 
par.calrho = fullfile(par.anatdir, 'cal_rho.nii'); %AC Change This is the calibration scan that is used to create the synthetic EPI 
par.calbo = fullfile(par.anatdir, 'cal_bo.nii'); %AC Change This is another calibration scan used to create the synthetic EPI
par.calrs = fullfile(par.anatdir, 'cal_rs.nii'); %AC Change This is another calibration scan used to create the synthetic EPI
par.calregbo = fullfile(par.anatdir, 'cal_reg_bo.nii'); %AC Change This is a registered fieldmap needed for unwarping 
par.synthEPI = fullfile(par.anatdir, 'synthEPI.nii'); %AC Change The synthetic EPI is in place of the inplane. It is generated from the cal_rho using a script provided by the CBI
par.hiresimg = fullfile(par.anatdir, 't1mprage.nii'); %AC Change
par.emptyspace = fullfile(par.scriptsdir, 'space_2mm.nii'); %AC Change



%% CREATE NAMES OF SCAN FILES     --- this section should be pretty stable
% --------populate image list names------
scpr = {[]; 'w';'sw';'u'; 'ur'; 'wur'; 'sur';}; % prepend scan with.. ([] means no prepend)
%set up for following format:
% /home/jbhutchi/data/parmap/fmri_data/s01/functional/scan01/swascan01.V007.img
% where everything up until 'scan01' is set by par.funcdir, and the naming
% of 'scan01' and 'swascan' is set up by using pathparts below

for ss = 1:length(scpr)
    pathparts = {[par.funcdir]; '/scan'; ['/' scpr{ss} 'scan'];'.nii,'};
    pathchunk = cellfun(@(ci)(repmat(ci,[sum(par.numvols) 1])), pathparts, 'UniformOutput', false); % oof
    x = 1;
    y = 1;
    for loopscans=1:par.numscans % BK - here, for 1:8
        for loopinscans = 1:par.numvols(loopscans) % AC - here, 1:268
            scannumvec(x) = loopscans;  % AC - scannumvec ends up being 268 1's followed by 268 2's, etc
            x = x+1;
        end
        for loopinscans = par.minvol:par.maxvol(loopscans)
            volnumvec(y) = loopinscans; % AC - volnumvec ends up being 6:268 followed by 6:268
            y = y+1;
        end
    end
    
    scannumchunk = strarrprepend(scannumvec',2); % BK - translates scan numbers from 1-8 to 01-08
    volnumchunk = strarrprepend(volnumvec',3); % BK - volnums go from 6, 7 ... 100 to 006, 007 ... 100
        
    par.(['all' scpr{ss} 'scanfiles']) = [pathchunk{1} pathchunk{2} scannumchunk pathchunk{3} scannumchunk pathchunk{4} volnumchunk];
    par.([scpr{ss} 'scanfiles']) = mat2cell(par.(['all' scpr{ss} 'scanfiles']), par.numvols',length(par.(['all' scpr{ss} 'scanfiles'])(1,:)))';
end

% every 10th raw scan file... used for art_movie_nogui quick flag
par.artfiles = par.allscanfiles(1:10:(sum(par.numvols)),:);


%% SLICE TIMING, REALIGN, and RESLICE PARAMS
% variables for slice timing not specified above

%% Slice Timing
par.slicetiming(1) = par.TA / (par.numslice -1);%timing var for slice timing
par.slicetiming(2) = par.TR - par.TA; %timing var for slice timing


%% Realign
par.aligntosynthepi = 1; %1 if you want all of your functionals to be realigned to they synthetic EPI so that they are in the same space. This will add the synthetic EPI as the first session (run) used in realignment

% realign flags... these are all 
par.realflag.quality = 0.9; % no Brice change
par.realflag.fwhm = 5;      % no Brice change
par.realflag.sep = 4;       % no Brice change
par.realflag.rtm = 0; % realign to mean (instead of first)-- see gui for explanation ... AC Change now realigns to first image
% par.realflag.PW;  %if field exists, then weighting is done...
par.realflag.interp = 2; % no Brice change 

%% Reslice 
% reslice flags
par.reslflag.mask = 0; % No brice change AC Change after talking to Ed. 
par.reslflag.mean = 1;  % no brice change
par.reslflag.interp = 4; % no brice change
par.reslflag.which = 0;   % Brice no change ...don't know what this does AC 0 if you dont want to resclice [2 1] to reslice all the images



%% COREGISTRATION, SEGMENTING, and NORMALIZATION PARAMS
% coregistration info
par.cor_meanfunc = [par.funcdir '/scan01/meanascan01.nii,' prepend(num2str(par.minvol),3)];
% note that this mean scan file is assuming you realign after slice
% timing...

% segment info
par.img2bSeg = par.hiresimg;
% need filepartinfo for below
[segpath, segname, segext] = fileparts(par.img2bSeg); 
par.segopts = struct('biascor',1,'GM',[0 0 1],'WM',[0 0 1],'CSF',[0 0 0],'cleanup',0); % Brice: this seems to match the defaults in SPM
par.segbiasfwhm = 60; % No brice change..... 60 is default in gui, 75 is default in command line for reasons unexplained
% see spm_config_preproc and spm_preproc(_write) for details


% normalization:a1` 
% gray matter: all of the settings seemed same as those in Brice's experiment
par.graytemp = fullfile(par.spmpath,'apriori','grey.nii');
par.grsegs(1,:) = fullfile(segpath, ['c1' segname segext]);
par.grsegs(2,:) = fullfile(segpath, ['c2' segname segext]);
par.graysrcimg = fullfile(segpath, ['c1' segname segext]);
par.graywrimg = fullfile(segpath, ['c1' segname segext]);
par.grflags.smosrc = 8;
par.grflags.smoref = 0;
par.grflags.regtype = 'mni';
par.grflags.cutoff = 25;
par.grflags.nits = 16;
par.grflags.reg = 1;
par.grwrflags.preserve = 0;
par.grwrflags.bb = [[-78 -112 -50];[78 76 85]]; 
par.grwrflags.vox        = [3 3 3];
par.grwrflags.interp     = 1; 
par.grwrflags.wrap       = [0 0 0];


%% SMOOTHING and SPECMASK PARAMS 
% smoothing funcs
par.smoothkernel = [2 2 2]; % AC change from 8 to 5



% specmaskvars  % Brice: I'm not sure how these following .imgs match
% up withwhat we have in the anatomical folders..

par.specwrflags.preserve = 0;
par.specwrflags.bb = [[-78 -112 -50];[78 76 95]]; % changed upper z from 85
par.specwrflags.vox        = [1 1 1];
par.specwrflags.interp     = 1;
par.specwrflags.wrap       = [0 0 0];

par.specsmooth = [20 20 20];
par.maskimg = [par.anatdir '/mask.nii'];
% par.smaskimg = [par.anatdir '/smask.img'];
% par.tsmaskimg = [par.anatdir '/tsmask.img'];
par.wmaskimg = [par.anatdir '/wmask.nii'];
par.swmaskimg = [par.anatdir '/swmask.nii'];
par.tswmaskimg = [par.anatdir '/tswmask.nii'];
par.brainmask = [par.anatdir '/brainmask_bin.nii'];
par.addsegs = 'i1 + i2';
par.maskthresh = 'i1 > .2';


%% MODEL PARAMETERS

% model vars...
par.timing.fmri_t0 = 8;  %micro-time resolution stuff (changed from 8)   I'm not sure if we want to switch these Brice or leave it as 8 and 16
par.timing.fmri_t = 16; %used to be 16-- changed based on conversation with melina

par.timing.units = 'secs'; % same for brice
par.bases.hrf.derivs = [0 0];  % default is actually [0 0]
                               % same for brice models this has an impact
                               % on how many columns there are and what the
                               % contrast inputs are 
% Melina says no cost to doing time and  dispersion derivs ([0 0] = no derivs) 
% NOTE that this will impact how you make contrasts!!
% par.volt = 1; 
par.volt = 1; % changed to 0 for brice back to 1
% par.sess.scans is specified after populating list names...
% onsetfilename = ['RRI.sub' subject(end:end) '.onsetTimes.txt'];
par.sess.multi = {fullfile(par.behavdir, 'onsets.mat')};
par.sess.multi_reg = {fullfile(par.behavdir, 'regs.mat')};
par.sess.hpf = 128;  % has anyone played around with this AND linear regs?
% par.sess.cond.help = 'Placeholder';
par.cvi = 'AR(1)'; %note that this actually gets changed to AR(0.2) in spm_fmri_spm_ui.  
% It looks like you might be able to give it a custom value
% by simply putting a number in here, but I haven't played around with it
par.global = 'None';
% explicit mask
par.mask = {par.tswmaskimg}; %AC CHANGE FOR HACK PURPOSES

% contrast vars
par.constat = 'T';

% more model stuff
par.sess.scans = par.allurscanfiles;

    
%%

fprintf('Done\n');
