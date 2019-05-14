function csvmaker_overlap_psa(csvflags,csvparams)


    
   %% 1. PSA Odd runs to Even runs SEG1 BY HALF (runs 1-6 first half; runs 9-14 second half)
    if ismember(1,csvflags)
        analysisname = 'analysis1';
        csvparams.analysisDir = [csvparams.subjResults '/' analysisname];
        [csv] = csv_psa_halves_overlap(analysisname,csvparams,0);
        csv(1,:) = {'subject', 'mask', 'comparison','half','sim','smoothing','group'};
        cell2csv(fullfile(csvparams.analysisDir,'analysis1_psa.csv'),csv);
    end
    
   %% 2. PSA Odd runs to Even runs SEG2 BY HALF (runs 1-6 first half; runs 9-14 second half)
    if ismember(2,csvflags)
        analysisname = 'analysis2';
        csvparams.analysisDir = [csvparams.subjResults '/' analysisname];
        [csv] = csv_psa_halves_overlap(analysisname,csvparams,0);
        csv(1,:) = {'subject', 'mask', 'comparison','half','sim','smoothing','group'};
        cell2csv(fullfile(csvparams.analysisDir,'analysis2_psa.csv'),csv);
    end
    
  
   %% 3. Voxelwise change in timecourse similarity by half SEG 1.
    if ismember(3,csvflags)
        analysisname = 'analysis3';
        csvparams.analysisDir = [csvparams.subjResults '/' analysisname];
        [csv1, csv2,csv3,csv4] = csv_psa_voxelwise_overlap(analysisname,csvparams,1800,1200+2400+2400,1200);
        csv1(1,:) = {'subject', 'mask','sim','comparison','half'};
        csv2(1,:) = {'subject', 'mask','sim','voxNum','voxRank','half','pair','comparison'};
        csv3(1,:) = {'subject', 'mask','oVoxRank','srSim','half','pair'};
        csv4(1,:) = {'subject', 'mask','rankCor','binOverlap','comparison'};

        cell2csv(fullfile(csvparams.analysisDir,'analysis3_sum.csv'),csv1);
        cell2csv(fullfile(csvparams.analysisDir,'analysis3_comb.csv'),csv2);
        cell2csv(fullfile(csvparams.analysisDir,'analysis3_srxo.csv'),csv3);
        cell2csv(fullfile(csvparams.analysisDir,'analysis3_rankCorr.csv'),csv4);

    end     
     
    
    %% 4. PSA Odd runs to Even runs SEG1 Every 2 runs
    if ismember(4,csvflags)
        analysisname = 'analysis4';
        csvparams.analysisDir = [csvparams.subjResults '/' analysisname];
        [csv] = csv_psa_halves_overlap(analysisname,csvparams,0);
        csv(1,:) = {'subject', 'mask', 'comparison','run_group','sim','smoothing','group'};
        cell2csv(fullfile(csvparams.analysisDir,'analysis4_psa.csv'),csv);
        
        cd(csvparams.mvpaDir)
        [csv] = csv_psa_datamat2(analysisname,csvparams,0);
         csv(1,:) = {'subject', 'mask', 'overlap_pair','run_group','sim','smoothing','group'};
         cell2csv(fullfile(csvparams.analysisDir,'analysis4_individual_pairs.csv'),csv);
        
    end 
    
    %% 5. TR x TR
    if ismember(5,csvflags)
        analysisname = 'analysis5';
        csvparams.analysisDir = [csvparams.subjResults '/' analysisname];
        [csv] = csv_psa_halves_overlap(analysisname,csvparams,1);
        csv(1,:) = {'subject', 'mask', 'comparison','half','sim','smoothing','group','TR'};
        cell2csv(fullfile(csvparams.analysisDir,'analysis5_psa.csv'),csv);
    end   
    
 
cd(csvparams.mvpaDir)

end

