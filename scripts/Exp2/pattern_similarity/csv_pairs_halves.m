function [dataSheet_acc,dataSheet_roc] = csv_pairs_halves(analysisname,csvparams,pair_adjust,timecourse)
      numruns = 6;
      colstart = 1;
      roc_col  = 1;
      halves = {'First','Second'};
      dataSheet_acc = [];
      dataSheet_roc = [];
        for x = 1:length(csvparams.smoothingtypes)
           smoothing = csvparams.smoothingtypes(x);

            for p = 1:length(csvparams.classifiers)
                for h = 1:2
                    
                classifier = csvparams.classifiers{p};
                classdir = [csvparams.subjResults '/' analysisname '/PSA_smooth' num2str(smoothing)];
                cd(classdir)
                for pair = 1:2
                analysismats= dir(['Destinations_classify_within_' halves{h} '_Half_Overlap_Pair' num2str(pair) '*']); %get list of mat names
                       %Load pair
                        for i = 1:size(analysismats,1) 
                            load(analysismats(i).name)
                            for tr = 1:size(metaResults,2)
                                 %numruns = length(metaResults{tr}.xvalid_runs);
                                %Accuracy
                                colend = colstart+numruns-1;
                                dataSheet_acc(colstart:colend,1) = csvparams.sub;
                                dataSheet_acc(colstart:colend,2) = i;
                                dataSheet_acc(colstart:colend,3) = 1:numruns;
                                dataSheet_acc(colstart:colend,4) = metaResults{tr}.runacc;
                                dataSheet_acc(colstart:colend,5) = pair + pair_adjust; %overlapping pair
                                dataSheet_acc(colstart:colend,6) = p; %classifier type 1=smlr 2=plr
                                dataSheet_acc(colstart:colend,7) = smoothing; %%smoothing 1 = yes 0 = no
                                dataSheet_acc(colstart:colend,8) = h; %half
                                if timecourse ==1 
                                    dataSheet_acc(colstart:colend,9) = tr;
                                end
                                colstart = colend +1;

                                %ROC
                                dataSheet_roc(roc_col,1) = csvparams.sub;
                                dataSheet_roc(roc_col,2) = i;
                                dataSheet_roc(roc_col,3) = metaResults{tr}.auc;
                                dataSheet_roc(roc_col,4) = metaResults{tr}.total_perf;
                                dataSheet_roc(roc_col,5) = pair + pair_adjust;
                                dataSheet_roc(roc_col,6) = p;
                                dataSheet_roc(roc_col,7) = smoothing;
                                dataSheet_roc(roc_col,8) = metaResults{tr}.auc-metaResults{tr}.total_perf;
                                dataSheet_roc(roc_col,9) = h;
                                if timecourse ==1 
                                    dataSheet_roc(roc_col,10) = tr;
                                end
                                roc_col = roc_col + 1;
                            end
                            clear metaResults params summary
                        end
                end

                            
                end
            end
        end 
    end