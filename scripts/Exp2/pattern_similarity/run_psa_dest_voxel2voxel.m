function[dataMat]= run_psa_overlap_voxel2voxel(all_data,meta_runs_condensed,condensed_regs_all,S)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %   RUN PSA
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    firsthalf = meta_runs_condensed<7; %get index for rusn 1-6
    secondhalf = meta_runs_condensed>8; %get index for rusn 9-14
    oddruns = mod(meta_runs_condensed,2) == 1; %get index for all odd runs
    evenruns = mod(meta_runs_condensed,2) == 0; %get index for all even runs
    
    %collapse across time dimension
    spatial_pats = squeeze(mean(all_data,1)); %voxel x trial matrix   
    
    num_vox = size(spatial_pats,1);
    
    lower_mat = logical(tril(ones(300,300),-1));
    upper_mat = logical(triu(ones(300,300),1));
    
    dataMat = [];
         
 for route = 1:4
    r_inxh1_o = logical(condensed_regs_all(route,:) & firsthalf & oddruns); %trial indices for the first half odd runs
    r_inxh1_e = logical(condensed_regs_all(route,:) & firsthalf & evenruns); %trial indices for the first half even runs
    r_inxh2_o = logical(condensed_regs_all(route,:) & secondhalf & oddruns); %trial indices for the second half odd runs
    r_inxh2_e = logical(condensed_regs_all(route,:) & secondhalf & evenruns); %trial indices for the second half even runs   
    
    %Compute Voxel 2 Voxel timecourse correlations
    TRpat_h1_o = mean(all_data(:,:,r_inxh1_o),3); %tr x voxel pattern first half
    TRpat_h1_e = mean(all_data(:,:,r_inxh1_e),3); %tr x voxel pattern first half
    TRpat_h2_o = mean(all_data(:,:,r_inxh2_o),3); %tr x voxel pattern first half
    TRpat_h2_e = mean(all_data(:,:,r_inxh2_e),3); %tr x voxel pattern first half
    
    h1_corrmat = (corr(TRpat_h1_o,TRpat_h1_e) + corr(TRpat_h1_e,TRpat_h1_o))/2;
    h2_corrmat = (corr(TRpat_h2_o,TRpat_h2_e) + corr(TRpat_h2_e,TRpat_h2_o))/2;
    
    
    %compute change in connectivity across halves
    change = h2_corrmat - h1_corrmat; % negative numbers mean decrease in con, positive means increase in con
    change = change(lower_mat);
    h1_fc = h1_corrmat(lower_mat);
    h2_fc = h2_corrmat(lower_mat);
    
    
   
    %obtain average spatial pattern for route seperately for 1st and 2nd
    %half
    r_inxh1 = logical(condensed_regs_all(route,:) & firsthalf);
    pat_h1 = mean(spatial_pats(:,r_inxh1),2); %voxel pattern first half

    %Rank voxels in 1st half and bin into strong, moderate, weak
    %activity
    
    [~,idx_h1] = sort(pat_h1,'descend');
    
    h1_rank = 1:num_vox;
    h1_rank(idx_h1) = h1_rank;
    
    h1_bin = ceil(h1_rank/100); %bin into hi,mod,lo 
    
    act_levels = h1_bin' * h1_bin; %pairwise voxel activation levels in first half. 9 means both were Highly active, 6 one moderately active on highly etc.
    act_levels = act_levels(lower_mat);
    
    %#of voxel 2 voxel comparisons
    num_comp = length(act_levels);
    
    
    %Columns
    %1 route #
    %2 change in connectivity
    %3 1st half connectivity
    %4 2nd half connectivity
    %5 1st half activiation pairing
    route_data = [repmat(route,1,num_comp)' change h1_fc h2_fc act_levels];
    dataMat = [dataMat; route_data];
 end


end


   
