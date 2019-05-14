  % Script to run all of the analyses in the Routes pipeline

clear all

%Experiment Info
params.expName = 'Exp1';
params.phases = {'Study'};
params.TR = 1.5;

%Subject Numbers to Run
params.allsubs = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20]; %all usuable subject numbers in the exp

subs = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20]; %speficy which subjects you want to run the chosen analysis on


%Masks
params.maskfiles = {'ppanoHipp_MNI_2mm_bin_scene300.nii','rscnoHipp_MNI_2mm_bin_scene300.nii','hipp_2mm_bin_visual300_new.nii',...
    'locnoHIPP_MNI_2mm_bin_object300.nii','mtl_cortex_noHIPP_PPA_2mm_bin_visual300_new.nii'};
params.masknames = {'PPA','RSC','HIPP','LOC', 'MTL VS no PPA'};

%Specify the masks you want to use for each analysis
analysis1masks = [1:5];
analysis2masks = [1:5];
analysis3masks = [1:5];
analysis4masks = [1:5];
analysis5masks = [1:5];

%Analysis Flags: Specify which analyses you want to run
analysisflags = [1 2 3 4 5]; %1 2 3 4 5 

%CSV Flags: Indicate which analyses you want csv files for
csvflags = [1 2 3 4 5]; 
csv = 1; % set to 1 if you want to write csvs while running analyses
csv_only = 0; %set to 1 if you do not want to run analysis but only write csv

%%%%%%%%%%%%%%%%%%%%%%%%
%Condition Setup
%%%%%%%%%%%%%%%%%%%%%%%%
% list of conditions for behavioral onset 1
% e.g.
%   Odd Subject #        Even Subject #
% 1  = Study route1    1  = Study route5     
% 2  = Study route2    2  = Study route6  
% 3  = Study route3    3  = Study route7     
% 4  = Study route4    4  = Study route8 

%Routes
Route1 = 1;
Route2 = 2;
Route3 = 3;
Route4 = 4;
Route5 = 1;
Route6 = 2;
Route7 = 3;
Route8 = 4;

% Overlapping Pairs
Pair_1 = [1 2];
vPair_2 = [3 4];

%Non Overlapping Pairs
Non_Over1 = [1 3];
Non_Over2 = [1 4];
Non_Over3 = [2 3];
Non_Over4 = [2 4];

%All Routes
All_Routes = 1:4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%START PIPELINE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if csv_only == 1 %if you are writing a csv file than dont run the analyses
    loop =0;
else
    loop = analysisflags;
end

for analyses = 1:length(loop)
    analysisflag = loop(analyses);

for sub = 1:length(subs)

    %Anlysis Specs
    params.zVox = 1; % z score across voxels (which will occur before z scoring across volumes)
    params.zVol = 0; % after potentially z scoring across voxels, z score across volumes within phase
    params.smoothingtypes = [0]; %use smoothed data?
    params.normalization = 0; %use normalized data?
    params.sub = subs(sub);
    params.same_train_test_weights = 1;
    
    %TR selection by segment (seg1 = overlapping poriton of routes; seg 2 =
    %non overlapping portion)  out of the total 16 TRs per trials
    seg1TRs = {[0 0 1/11 1/11 1/11 1/11 1/11 1/11 1/11 1/11 1/11 1/11 1/11]};
    seg2TRs = {[0 0 0 0 0 0 0 0 0 0 0 0 0 0 1/4 1/4 1/4 1/4]};

    % create a subject ID
    params.subj_id= sprintf(['sub-' params.expName 's%02d'], params.sub); 
    
    %Set up Directory Stucture
      
    params = psa_directories(params.subj_id,params);
           
    %% 1. PSA Odd runs to Even runs SEG1 BY HALF (runs 1-6 first half; runs 9-14 second half)
      if ismember(1,analysisflag)   
        flag = 1;
        params.masks = params.maskfiles(analysis1masks);
        params.maskn = params.masknames(analysis1masks);
        params.behavmodel = 1;
        params.TRweights = seg1TRs;    
        params.train_phase = 'Study';
        params.test_phase = 'Study';
        params.concatenate = 1;
        params.class_dim = 'PSA_halves_seg1';
        params.concatTRs = 1; %use spatiotemporal pattern
        params.split = 1; %split by odd and even

        for i = 1:length(params.smoothingtypes)
           params.smoothing = params.smoothingtypes(i);
           params.analysisDir = [params.subjResults '/analysis' num2str(flag) '/PSA_smooth' num2str(params.smoothing)];
                if mod(sub,2) == 1
                    params.onsets2collapse =  {Route1 Route2 Route3 Route4};  
                    params.condnames = {'Route1' 'Route2' 'Route3' 'Route4'};
                elseif mod(sub,2) == 0
                    params.onsets2collapse =  {Route5 Route6 Route7 Route8};  
                    params.condnames = {'Route5' 'Route6' 'Route7' 'Route8'};
                end
               batcher_psa_overlap_halves(params)  
         end
      end
      
     %% 2. PSA Odd runs to Even runs SEG2 BY HALF (runs 1-6 first half; runs 9-14 second half)
      if ismember(2,analysisflag)    
        flag = 2;
        params.masks = params.maskfiles(analysis2masks);
        params.maskn = params.masknames(analysis2masks);
        params.behavmodel = 1;
        params.TRweights = seg2TRs;  
        params.train_phase = 'Study';
        params.test_phase = 'Study';
        params.concatenate = 1;
        params.class_dim = 'PSA_halves_seg2';
        params.concatTRs = 1; %use spatiotemporal pattern
        params.split = 1; %split by odd and even

        for i = 1:length(params.smoothingtypes)
           params.smoothing = params.smoothingtypes(i);
           params.analysisDir = [params.subjResults '/analysis' num2str(flag) '/PSA_smooth' num2str(params.smoothing)];
                if mod(sub,2) == 1
                    params.onsets2collapse =  {Route1 Route2 Route3 Route4};  
                    params.condnames = {'Route1' 'Route2' 'Route3' 'Route4'};
                elseif mod(sub,2) == 0
                    params.onsets2collapse =  {Route5 Route6 Route7 Route8};  
                    params.condnames = {'Route5' 'Route6' 'Route7' 'Route8'};
                end
               batcher_psa_overlap_halves(params)  
         end
      end
      
  %% 3. Voxelwise change in timecourse similarity by half SEG 1
      if ismember(3,analysisflag)   
        flag = 3;
        params.masks = params.maskfiles(analysis3masks);
        params.maskn = params.masknames(analysis3masks);
        params.behavmodel = 1;
        params.TRweights = seg1TRs;  
        params.train_phase = 'Study';
        params.test_phase = 'Study';
        params.concatTRs = 1;
        params.class_dim = 'PSA_voxelwise_timecourse_sim';
        
        for i = 1:length(params.smoothingtypes)
           params.smoothing = params.smoothingtypes(i);
                params.analysisDir = [params.subjResults '/analysis' num2str(flag) '/PSA_smooth' num2str(params.smoothing)];
                if mod(sub,2) == 1
                    params.onsets2collapse =  {Route1 Route2 Route3 Route4};  
                    params.condnames = {'Route1' 'Route2' 'Route3' 'Route4'};
                elseif mod(sub,2) == 0
                    params.onsets2collapse =  {Route5 Route6 Route7 Route8};  
                    params.condnames = {'Route5' 'Route6' 'Route7' 'Route8'};
                end
               batcher_psa_voxelwise(params)  
         end
      end
    
      
      %% 4. PSA Odd runs to Even runs SEG1 Every 2 runs
      if ismember(4,analysisflag)   
        flag = 4;
        params.masks = params.maskfiles(analysis4masks);
        params.maskn = params.masknames(analysis4masks);
        params.behavmodel = 1;
        params.TRweights = seg1TRs;  
        params.train_phase = 'Study';
        params.test_phase = 'Study';
        params.concatTRs = 1;
        params.class_dim = 'PSA_2runs';
        
        for i = 1:length(params.smoothingtypes)
           params.smoothing = params.smoothingtypes(i);
                params.analysisDir = [params.subjResults '/analysis' num2str(flag) '/PSA_smooth' num2str(params.smoothing)];
                if mod(sub,2) == 1
                    params.onsets2collapse =  {Route1 Route2 Route3 Route4};  
                    params.condnames = {'Route1' 'Route2' 'Route3' 'Route4'};
                elseif mod(sub,2) == 0
                    params.onsets2collapse =  {Route5 Route6 Route7 Route8};  
                    params.condnames = {'Route5' 'Route6' 'Route7' 'Route8'};
                end
               batcher_psa_overlap_2runs(params)  
         end
      end
      
   %% 5. Goal Coding TR x TR Sliding 3 Window
      if ismember(5,analysisflag)  
        flag = 5;
        params.masks = params.maskfiles(analysis5masks);
        params.maskn = params.masknames(analysis5masks);
        params.behavmodel = 1;
        params.TRweights = {[0 1/16 1/16 1/16 1/16 1/16 1/16 1/16 1/16 1/16 1/16 1/16 1/16 1/16 1/16 1/16 1/16 1/16 1/16]};   
        params.train_phase = 'Study';
        params.test_phase = 'Study';
        params.class_dim = 'PSA_TRxTR';
        params.concatTRs = 0; %use concatenated TRs for analysis
        params.split = 1; %split by odd and even
        params.window = 1;

        for i = 1:length(params.smoothingtypes)
           params.smoothing = params.smoothingtypes(i);
           params.analysisDir = [params.subjResults '/analysis' num2str(flag) '/PSA_smooth' num2str(params.smoothing)];
                if mod(sub,2) == 1
                    params.onsets2collapse =  {Route1 Route2 Route3 Route4};  
                    params.condnames = {'Route1' 'Route2' 'Route3' 'Route4'};
                elseif mod(sub,2) == 0
                    params.onsets2collapse =  {Route5 Route6 Route7 Route8};  
                    params.condnames = {'Route5' 'Route6' 'Route7' 'Route8'};
                end
               batcher_psa_overlap_halves(params)  
         end
      end    
      

      
    if csv ==1 
         csvmaker_overlap_psa(analysisflag,params)
    end
end
end
