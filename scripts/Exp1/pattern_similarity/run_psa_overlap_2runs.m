function[dataMat,dataMat2]= run_psa_overlap_2runs(all_data,meta_runs_condensed,condensed_regs_all,P)

groups = {[1 2] [3 4] [5 6] [7 8] [9 10] [11 12] [13 14]};

overlap = zeros(4,4);
overlap(1,2) = 1;
overlap(2,1) = 1; 
overlap(3,4) = 1;
overlap(4,3) = 1;

diff = zeros(4,4);
diff(1,3:4) = 1;
diff(2,3:4) = 1;
diff(3,1:2) = 1;
diff(4,1:2) = 1;

colstart = 1;
colstart2 = 1;
dataMat = [];
for i = 1:length(groups)
    odd = meta_runs_condensed == groups{i}(1);
    even = meta_runs_condensed == groups{i}(2);

    firstodd_inx = zeros(4,112);
    secondodd_inx =zeros(4,112);
    firsteven_inx =zeros(4,112);
    secondeven_inx =zeros(4,112);

    for route = 1:4
        odd_inx(route,:) = condensed_regs_all(route,:) & odd;
        even_inx(route,:) = condensed_regs_all(route,:) & even;
    end


    odd_data = (odd_inx*all_data')/2;
    even_data = (even_inx*all_data')/2;

    corr_data = corr(odd_data',even_data');

    %Convert corr values to z values using Fisher transform
    corr_data = fisherz(corr_data);

    sameCorr= mean(diag(corr_data));
    overlapCorr = mean(corr_data(find(overlap)));
    diffCorr = mean(corr_data(find(diff)));

    op1 = mean([corr_data(1,2) corr_data(2,1)]); %overlap pair 1
    op2 = mean([corr_data(3,4) corr_data(4,3)]);%overlap pair 2
    
    op1 = op1-diffCorr;
    op2 = op2-diffCorr;
    
    dataMat(1,colstart:colstart+2) = [sameCorr overlapCorr diffCorr];
    dataMat(2,colstart:colstart+2) = [1 2 3]; %this row identifies the comparision 1 == same 2= overlap 3= diff
    dataMat(3,colstart:colstart+2) = [i i i]; %this row identifies the run grouping
    
    dataMat2(1,colstart2:colstart2+1) = [op1 op2];
    dataMat2(2,colstart2:colstart2+1) = [1 2];
    dataMat2(3,colstart2:colstart2+1) = [i i];
    
    colstart = colstart + 3;
    colstart2 = colstart2 + 2;
end
  
end


   
