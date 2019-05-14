function[all_data,uncat_data,meta_runs_condensed,condensed_regs_all]= psa_prepdata_overlap(subNum,P)
% [myResults] = run_mvpaTemp(P)  ... where P has fields of expName, subNum,
% etc. and myResults contains ....

S.subjNum = subNum;

S.expName = P.expName;
S.onsets2collapse = P.onsets2collapse;  % condition numbers to collapse across, e.g. {[1 2 3] [4 5 6]}        
S.condnames = P.condnames;              % names of the conditions, e.g., {'faces' 'scenes'}
S.thisTrain = P.train_phase;          % first item in train_test specifies the training data (e.g., 'encoding')
S.thisTest = P.test_phase;           % second items specifies testing data (e.g., 'retrieval')
S.TR_weights_idx = P.weights;           % just make sure that order of weights corresponds to the order of the taskIdx
S.taskIdx = P.phases;          % if experiment has distinct phases (e.g., encoding phase and retrieval phase)
S.shuffle = P.shuffle;         %will shuffle the regressors if 1, will not if 0
S.TR = P.TR;                   %TR
S.concatTRs = P.concatTRs; %if 1 will concatenate across TRs, if 0 will weight TRs according to specified weighting
S.behavmodel = P.behavmodel;  %specify behavioral model for testing 
S.subj_id = P.subj_id; 

%% This section should be modified according to specific experiment details

%%%%%%%%%%%%%%%%%%%% Set flags (% unless otherwise indicated: 1 = yes please, 0 = no thanks) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flags.use_premade_workspace = 1;                    % If some of the work has been done for this subject before, use this saved info (generally helpful) 
flags.num_results_iter = 1;                         % number of times to run the entire classification process (useful if sub-sampling data)
flags.num_iter_with_same_data = 1;                  % number of times to run the classfication step for a given subset of data (only useful for bp or non-deterministic classifier)
flags.equate_number_of_trials_in_conds = 1;         % equate number of trials in each condition (RECOMMENDED, unless imbalance is only in testing data)
flags.anova_p_thresh = 1;                           % p-value threshold for feature selection ANOVA (1 = DON'T PERFORM ANY FEATURE SELECTION)
flags.useSmoothedFuncs = P.smoothing;                         % 1 = yes, 0 = no;  will either look for functional data prepended with an 's' or not
flags.useNormalizedFuncs = P.normalization;                       % will either look for functional data prepended with 'w' or not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% DETAILS ABOUT YOUR RUNS
% how many volumes in each scan
S.RVIdx{1} = [184 184 184 184 184 184 184 184 184 184 184 184 184 184]; %184 = 190-6 dropped volumes
S.mRVIdx{1} = S.RVIdx{1}; % I'm not sure why we need this, too

S.idxThisTrain = find(strcmp(S.taskIdx, S.thisTrain));  % is the training data the 1st, 2nd, etc. in the taskIdx (this shouldn't need to be modified)
S.idxThisTest = find(strcmp(S.taskIdx, S.thisTest));    % ditto for test data (again, no need to modify)
tic

%% DIRECTORY INFORMATION

% specify path info according to whether smoothed or unsmoothed data are used
if flags.useSmoothedFuncs == 1
    S.smoothing = 'smoothed';
elseif flags.useSmoothedFuncs == 0
    S.smoothing = 'unsmoothed';
end

% specify path info according to whether using normalized or un-normalized
% data (un-normalized currently only makes works if there is no smoothing
if flags.useNormalizedFuncs == 1
    S.normalization = 'normalized';
elseif flags.useNormalizedFuncs == 0
    S.normalization = 'unnormalized';
end
    
% Get directories
S = psa_directories(S.subj_id,S);
S.onsets_dir = [S.univar_dir '/behavioral_model' num2str(S.behavmodel)];



%% specify runs information for training, testing data
if S.idxThisTrain==S.idxThisTest                % if training data = testing data (meaning x-validation will be used)
    S.runs_vector = S.RVIdx{S.idxThisTrain};    % makes the runs_vector = the RVIdx that corresponds to the Train data (see S.tastIdx)
    S.meta_runs = S.mRVIdx{S.idxThisTrain};     % make the meta runs = the meta train data for the relevant phase
else                                            % if training data not = testing data (no need for x-validation)
    S.runs_vector = horzcat(S.RVIdx{S.idxThisTrain}, S.RVIdx{S.idxThisTest});   % BK: runs vector = the train and test data for relevant phase
    S.meta_runs = [sum(S.RVIdx{S.idxThisTrain}), sum(S.RVIdx{S.idxThisTest})];  % BK: meta runs = [# of train TRs, # of test TRs] for relevant phase
end

% total number of runs, volumes
S.num_runs = length(S.runs_vector);             % total number of runs
S.num_vols = sum(S.runs_vector);                % total number of TRs

% if flags.useNormalizedFuncs == 1
%     S.vol_info = load([S.expt_dir '/MVPA_Overlap_final/vol_info.mat']);    % requires a vol_info.mat file that specifies functional resolution
% else % if un-normalized data are being used
%     S.vol_info = load([S.expt_dir '/MVPA_Overlap_final/unNorm_vol_info.mat']);    % requires a vol_info.mat file that specifies functional resolution
% end

%% Load and reorganize onsets
load([S.onsets_dir '/onsets.mat']);        % load in SPM-formatted onsets file (NOTE: this script assumes onsets are in seconds!)


% Collapse across onsets to reflect the conditions you want to classify.
% numel(newOnsets) should now = size(onsets2collapse,2)
for zz = 1:length(S.onsets2collapse)
    newOnsets{zz} = [];
    for yy = 1:length(S.onsets2collapse{zz})
        newOnsets{zz} = [newOnsets{zz} onsets{S.onsets2collapse{zz}(yy)}];
    end
    newOnsets{zz} = sort(newOnsets{zz});
end
S.onsets = newOnsets;

% MVPA IMAGES (BELOW) NEEDS TO BE MODIFIED FOR EACH EXPERIMENT!
[S.img_files] = mvpa_images(S,flags.useSmoothedFuncs,flags.useNormalizedFuncs);  
S.num_conds = size(S.onsets,2);

%% SPECIFY MASK
% specify mask name, location. I prefer to have 'mask' passed from the batcher script so that it's easy to loop through multiple masks
S.roi_name = P.current_mask;                            
S.roi_file = [S.masks_dir '/' S.roi_name]; 


%% TR WEIGHTS
% how to weight each of the TR's for each trial (the TRs will be averaged according to these weights)
S.TRs_to_average_over_train = 1:length(S.TR_weights_idx{S.idxThisTrain}); 	% weights for training data
S.TR_weights_train = S.TR_weights_idx{S.idxThisTrain};                      % should sum to 1
S.TRs_to_average_over_test = 1:length(S.TR_weights_idx{S.idxThisTest});     % weights for testing data
S.TR_weights_test = S.TR_weights_idx{S.idxThisTest};                        % should sum to 1


%% The below section should be relatively 'fixed' across experiments

% Set-up the workspace
S.workspace = fullfile(S.mvpaDir, S.subj_id, [S.subj_id '_train' S.thisTrain '_test' S.thisTest '_' S.roi_name '_' S.smoothing '.mat']);
existWorkspace = exist(S.workspace);                % does this workspace already exist?
Sequal = 0;
if existWorkspace
    WorkCheck = load(S.workspace);                  % if workspace already exists, load it
    Sequal = isequal(struct2cell(WorkCheck.S), struct2cell(S));
end
if (flags.use_premade_workspace&&existWorkspace)    % If the flag for using premade workspace is on, use the premade one
    load(S.workspace, 'subj');
else                                                % Otherwise, run the load and preprocess script
    [subj] = mvpa_load_and_preprocess_raw_data(S);
end


% Name the selector according to whether this is within-phase or across phase classification
if strcmp(S.thisTrain, S.thisTest)
    S.thisSelector = 'meta_runs_condensed_xval';    % if within-phase, x-validation will be applied
else
    S.thisSelector = 'trainTestOneIter';            % if between-phase, there is just one training, one testing (no x-validation)
end

subj_orig = subj; % save copy of original subj struct

subj = subj_orig; % overwrite subj struct w/ original
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% REGRESSORS (when do conditions appear) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Extract info about conditions from onsets file
    all_regs = zeros(S.num_conds,S.num_vols);               % initialize regs matrix as conditions x timepoints
    for cond = 1: S.num_conds                               % for each condition ...

        for trial = 1:length(S.onsets{cond})               % for each onset ... 
            if S.TR == 2
                time_idx = round(S.onsets{cond}(trial))/S.TR + 1; % divide by TR and add 1 to convert back from sec to TRs (first timepoint = 0 sec; first TR = 1)
            elseif S.TR == 1.5
                time_idx = round(S.onsets{cond}(trial)/S.TR + 1);   
            end
            all_regs(cond,time_idx) = 1;                    % all_regs is the master list of where each condition appears in time
        end
    end
    
    % condense regs by removing zeros
    condensed_regs_all = [];
    condensed_runs = [];
    trial_counter = 1;
    if S.idxThisTest == 1  %If training and testing on the first phase
        regstart = 1;  %start at the first TR
        regsend = sum(S.RVIdx{1}); %end at the last TR of the first phase
         all_regs = all_regs(1:S.num_conds,regstart:regsend);
    elseif S.idxThisTest == 2 %If training and testing on the second phase
        regstart = sum(S.RVIdx{1})+1; %start at the first TR after the first phase
        all_regs = all_regs(1:S.num_conds,regstart:end);
    end
    for i = 1: size(all_regs,2)
        if ~isempty(find(all_regs(:,i)))            % if not a rest timepoint
            condensed_regs_all(:,trial_counter) = all_regs(:,i);
            condensed_runs(1,trial_counter) = subj.selectors{1}.mat(i);
            trial_counter = trial_counter + 1;
        end
    end 
    idx_condense =find(sum(all_regs));    % This will drop all rest time points (it drops time points where every condition has a '0')
    
    
    %Shuffle Regressors if set to do so (This is used to check that the
    %classifier is not biased) 
    if S.shuffle == 1
        condensed_regs_all = shuffle(condensed_regs_all,2);
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SELECTORS (which trials comprise testing/training runs) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % The below will make a variable called m_runs that is a list from 1:total number of volumes in the train + test set.  
    % m_runs(volume#) will tell you what run number each volume corresponds to. 
    % In the case where train ~= test, 1's will correspond to the training data, 2's to the testing data.
    % When train = test, m_runs(volume#) = the run #
    trial_idx = 1;
    m_runs = 0;
    for r = 1:length(S.meta_runs)
        m_runs(trial_idx:trial_idx+S.meta_runs(r)-1)=r;
        trial_idx = trial_idx+S.meta_runs(r);
    end
    meta_runs_condensed = m_runs(idx_condense); % drop rest time points    
    all_trials = sum(all_regs,1);               % sum all_regs across 1st dimension
    % set up the training/testing sets
    if strcmp(S.thisTrain, S.thisTest)          % for within-phase classification
        meta_runs_train = find(all_trials);     % this equals all trials because all trials will be part of training at some point
        meta_runs_test = [];
    else                                        % for between-phase classification
        meta_runs_train = idx_condense(find(meta_runs_condensed==1));   
        meta_runs_test = idx_condense(find(meta_runs_condensed==2));
    end
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Grab Releveant Volumes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      TR_counter = 1;
        for dt = 1:length(S.TR_weights_idx{S.idxThisTrain})
           if S.TR_weights_train(dt) ~= 0
            data_by_TR_train(TR_counter,:,:) = subj.patterns{end}.mat(:,meta_runs_train+(dt-1));
            TR_counter = TR_counter + 1;
           end
        end
        
        %save uncuncatented data for voxelwise analysis
       uncat_data = data_by_TR_train; %TR x voxel x trial
       
       %concatenate spatial pattern across volumes within trial
       concatdata_train = [];
       for dt = 1:TR_counter-1
           concatdata_train = horzcat(concatdata_train,data_by_TR_train(dt,:,:));
       end
       all_data = squeeze(concatdata_train);
  
    

end

   

