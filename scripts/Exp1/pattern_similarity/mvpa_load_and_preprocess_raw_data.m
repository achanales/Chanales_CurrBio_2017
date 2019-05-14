function [subj] = mvpa_load_and_preprocess_raw_data(S)
    
    % initialize subj structure
    subj = init_subj(S.expName,S.subj_id);

    % load mask file
    subj = load_spm_mask(subj,S.roi_name,S.roi_file);
    
    % load functional data
    subj = load_analyze_pattern(subj,'spiral',S.roi_name, S.img_files,'single',true);

    % make runs vector
    subj = init_object(subj,'selector','runs');

    trial_idx = 1;
    for r = 1:length(S.runs_vector)
        runs(trial_idx:trial_idx+S.runs_vector(r)-1)=r;
        trial_idx = trial_idx+S.runs_vector(r);
    end
   
    subj = set_mat(subj,'selector','runs',runs);

    % detrend the timeseries data
    subj = detrend_runs(subj,'spiral','runs'); 
        
    % clean up workspace
    subj = remove_mat(subj,'pattern','spiral');
 
    % high-pass filter the timeseries data
    subj = hpfilter_runs(subj,'spiral_d','runs',100,2); % remove frequencies below .01 Hz
    
    % clean up workspace
    subj = remove_mat(subj,'pattern','spiral_d');
   
    % zscore the data from each run
    subj = zscore_runs(subj,'spiral_d_hp','runs'); % Z-score the data
    
    % clean up workspace
    subj = remove_mat(subj,'pattern','spiral_d_hp');
    
    if ~exist(S.mvpaDir)
        mkdir(S.mvpaDir);
    end
    
    save (S.workspace);
