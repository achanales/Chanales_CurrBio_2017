    function [dataSheet_acc1,dataSheet_acc2,dataSheet_acc3,dataSheet_acc4] = csv_psa_voxelwise_overlap(analysisname,csvparams,numcomp1,numcomp2,numcomp3)

    rc1 = 2;
    rc2 = 2;
    rc3 = 2;
    rc4 = 2;
     
     dataSheet_acc1 = {};
     dataSheet_acc2 = {};
     dataSheet_acc3 = {};
     dataSheet_acc4 = {};

            for s = 1:length(csvparams.smoothingtypes)
                smoothing = csvparams.smoothingtypes(s);
                classdir = [csvparams.subjResults '/' analysisname '/PSA_smooth' num2str(smoothing)];
                cd(classdir)
                analysismats = dir([csvparams.expName '_psa_*']); %get list of mat names

                for i = 1:size(analysismats,1) 
                    load(analysismats(i).name)
                    %Summary csv
                        for j = 1:numcomp1
                            dataSheet_acc1{rc1,1} = csvparams.sub;
                            dataSheet_acc1{rc1,2} = maskname;
                            dataSheet_acc1{rc1,3} = dataMat(1,j);
                            dataSheet_acc1{rc1,4} = dataMat(2,j); %same overlap non overlap 
                            dataSheet_acc1{rc1,5} = dataMat(3,j); %half 
                            rc1 = rc1 + 1;
                        end
                        
                        for j = 1:numcomp2
                            dataSheet_acc2{rc2,1} = csvparams.sub;
                            dataSheet_acc2{rc2,2} = maskname;
                            dataSheet_acc2{rc2,3} = combMat(1,j);
                            dataSheet_acc2{rc2,4} = combMat(2,j); %vox num
                            dataSheet_acc2{rc2,5} = combMat(3,j); %vox ranking
                            dataSheet_acc2{rc2,6} = combMat(4,j); %half 
                            dataSheet_acc2{rc2,7} = combMat(5,j); %pair 
                            dataSheet_acc2{rc2,8} = combMat(6,j); %comparison 1 = overlap 2 = non overap 3 = same
                            rc2 = rc2 +1;
                        end
                    
                        for j = 1:numcomp3
                            dataSheet_acc3{rc3,1} = csvparams.sub;
                            dataSheet_acc3{rc3,2} = maskname;
                            dataSheet_acc3{rc3,3} = srxo(1,j); %overlap vox ranking
                            dataSheet_acc3{rc3,4} = srxo(2,j); %same route sim
                            dataSheet_acc3{rc3,5} = srxo(3,j); %half 
                            dataSheet_acc3{rc3,6} = srxo(4,j); %pair
                            rc3 = rc3 +1;
                        end
                        
                        for j = 1:3
                            dataSheet_acc4{rc4,1} = csvparams.sub;
                            dataSheet_acc4{rc4,2} = maskname;
                            dataSheet_acc4{rc4,3} = srMat(1,j); %spearman correlation
                            dataSheet_acc4{rc4,4} = srMat(2,j); %bin overlap
                            dataSheet_acc4{rc4,5} = srMat(3,j); %comparions 1 = overlap 2 = non overap 3 = same
                            rc4 = rc4 + 1;
                        end
                    clear dataMat combMat srxo srMat maskname
                end
                
            end
    end