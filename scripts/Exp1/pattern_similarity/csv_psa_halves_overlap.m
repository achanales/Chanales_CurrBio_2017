    function [dataSheet_acc] = csv_psa_halves_overlap(analysisname,csvparams,tr)
        colstart = 1;
        if mod(csvparams.sub,2) == 1
            oe = 1;
        else
            oe = 2;
        end
        
        dataSheet = {};
        rc = 2;
            for s = 1:length(csvparams.smoothingtypes)
                smoothing = csvparams.smoothingtypes(s);
                classdir = [csvparams.subjResults '/' analysisname '/PSA_smooth' num2str(smoothing)];
                cd(classdir)
                 analysismats = dir([csvparams.expName '_psa_*']); %get list of mat namess
                
                for i = 1:size(analysismats,1) 
                    load(analysismats(i).name)
                    
                    for j = 1:length(dataMat)
                        %Summary csv
                        dataSheet_acc{rc,1} = csvparams.sub;
                        dataSheet_acc{rc,2} = maskname;
                        dataSheet_acc{rc,3} = dataMat(2,j);
                        dataSheet_acc{rc,4} = dataMat(3,j); %half 
                        dataSheet_acc{rc,5} = dataMat(1,j); %overlapping pair
                        dataSheet_acc{rc,6} = smoothing; %%smoothing 1 = yes 0 = no
                        dataSheet_acc{rc,7} = oe; %% odd = 1 even = 2
                            if tr == 1
                                dataSheet_acc{rc,8} = dataMat(4,j);
                            end

                        rc = rc + 1;
                       
                    end
                     clear dataMat maskname
                    
                end
            end
    end