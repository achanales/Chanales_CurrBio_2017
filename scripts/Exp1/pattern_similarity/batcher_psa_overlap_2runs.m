function batcher_psa_overlap_2runs(params)
params.freesurfer_masks = 0;

cd(params.mvpaDir);
     for mask = 1:length(params.masks)
        params.current_mask = params.masks{mask};
        maskname = params.maskn{mask};
        savename = [params.expName '_psa_' params.current_mask '_smth' num2str(params.smoothing) '_norm' num2str(params.normalization) '.mat'];
            for TR = 1:numel(params.TRweights)
                params.weights{1} = params.TRweights{TR};
                params.shuffle = 0;
                [all_data,~,runs,regs] = psa_prepdata(params.sub,params);
                [dataMat,dataMat2] = run_psa_overlap_2runs(all_data,runs,regs,params);
                if ~exist(params.analysisDir)
                    mkdir(params.analysisDir);
                end
                cd(params.analysisDir)
                eval(['save ' savename ' dataMat dataMat2 maskname']);
                cd(params.mvpaDir)
            end
             
     end

cd(params.mvpaDir);




 
