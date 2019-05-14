function[dataMat]= run_psa_overlap_halves(all_data,meta_runs_condensed,condensed_regs_all,P)


if P.split ==1 %if you want to split by odd and even runs   
        oddruns = mod(meta_runs_condensed,2) == 1; %get index for all odd runs
        evenruns = mod(meta_runs_condensed,2) == 0; %get index for all even runs
        firsthalf = meta_runs_condensed<7; %get index for rusn 1-6
        secondhalf = meta_runs_condensed>8; %get index for rusn 9-14

        firstodd_inx = zeros(4,112);
        secondodd_inx =zeros(4,112);
        firsteven_inx =zeros(4,112);
        secondeven_inx =zeros(4,112);

        for route = 1:4
            firstodd_inx(route,:) = condensed_regs_all(route,:) & oddruns & firsthalf;
            firsteven_inx(route,:) = condensed_regs_all(route,:) & evenruns & firsthalf;
            secondodd_inx(route,:) = condensed_regs_all(route,:) & oddruns & secondhalf;
            secondeven_inx(route,:) = condensed_regs_all(route,:) & evenruns & secondhalf;
        end

  if P.concatTRs == 1 %if you want to use all TRs

        firstodd_data = (firstodd_inx*all_data')/6;
        firsteven_data = (firsteven_inx*all_data')/6;
        secondodd_data = (secondodd_inx*all_data')/6;
        secondeven_data = (secondeven_inx*all_data')/6;

        firstcorr_data = corr(firstodd_data',firsteven_data');
        secondcorr_data = corr(secondodd_data',secondeven_data');

        %Convert corr values to z values using Fisher transform
        firstcorr_data = fisherz(firstcorr_data);
        secondcorr_data = fisherz(secondcorr_data);

        firstsameCorr= mean(diag(firstcorr_data));
        secondsameCorr= mean(diag(secondcorr_data));

        overlap = zeros(4,4);
        overlap(1,2) = 1;
        overlap(2,1) = 1; 
        overlap(3,4) = 1;
        overlap(4,3) = 1;

        firstoverlapCorr = mean(firstcorr_data(find(overlap)));
        secondoverlapCorr = mean(secondcorr_data(find(overlap)));

        diff = zeros(4,4);
        diff(1,3:4) = 1;
        diff(2,3:4) = 1;
        diff(3,1:2) = 1;
        diff(4,1:2) = 1;

        firstdiffCorr = mean(firstcorr_data(find(diff)));
        seconddiffCorr = mean(secondcorr_data(find(diff)));

        dataMat(1,:) = [firstsameCorr firstoverlapCorr firstdiffCorr secondsameCorr secondoverlapCorr seconddiffCorr];
        dataMat(2,:) = [1 2 3 1 2 3]; %this row identifies the comparision 1 == same 2= overlap 3= diff
        dataMat(3,:) = [1 1 1 2 2 2]; %this row identifies the half
        
    elseif P.concatTRs == 0

        numTRs = sum(P.TRweights{1}>0);
        numVoxels = size(all_data,1)/numTRs;
        TRs = sort(repmat(1:numTRs,1,numVoxels)); %TR to feature mapping 
        startcol = 1;
        
        if P.window == 1
            %Sliding 3 Window
            window = [0 1 2];
            for i = 1:numTRs-2
                endcol = startcol +5;
                window = window + 1;
                concat_pat = zeros(numVoxels,size(all_data,2));
                for j = 1:length(window)
                    features = TRs == window(j); 
                    tr_data = all_data(features,:);
                    concat_pat = [concat_pat + tr_data];
                end

                tr_data_window = concat_pat/length(window);




                firstodd_data = (firstodd_inx*tr_data_window')/6;
                firsteven_data = (firsteven_inx*tr_data_window')/6;
                secondodd_data = (secondodd_inx*tr_data_window')/6;
                secondeven_data = (secondeven_inx*tr_data_window')/6;

                firstcorr_data = corr(firstodd_data',firsteven_data');
                secondcorr_data = corr(secondodd_data',secondeven_data');

                %Convert corr values to z values using Fisher transform
                firstcorr_data = fisherz(firstcorr_data);
                secondcorr_data = fisherz(secondcorr_data);

                firstsameCorr= mean(diag(firstcorr_data));
                secondsameCorr= mean(diag(secondcorr_data));

                overlap = zeros(4,4);
                overlap(1,2) = 1;
                overlap(2,1) = 1; 
                overlap(3,4) = 1;
                overlap(4,3) = 1;

                firstoverlapCorr = mean(firstcorr_data(find(overlap)));
                secondoverlapCorr = mean(secondcorr_data(find(overlap)));

                diff = zeros(4,4);
                diff(1,3:4) = 1;
                diff(2,3:4) = 1;
                diff(3,1:2) = 1;
                diff(4,1:2) = 1;

                firstdiffCorr = mean(firstcorr_data(find(diff)));
                seconddiffCorr = mean(secondcorr_data(find(diff)));


                dataMat(1,startcol:endcol) = [firstsameCorr firstoverlapCorr  firstdiffCorr secondsameCorr secondoverlapCorr seconddiffCorr];
                dataMat(2,startcol:endcol) = [1 2 3 1 2 3]; %this row identifies the comparision 1 == same 2= overlap 3= diff
                dataMat(3,startcol:endcol) = [1 1 1 2 2 2]; %this row identifies the half
                dataMat(4,startcol:endcol) = i;

                startcol = endcol + 1;
            end
            
        elseif P.window == 0
            %Non sliding window
           for i = 1:numTRs 
                 endcol = startcol +5;
                 features = TRs == i; 
                 tr_data = all_data(features,:);

                firstodd_data = (firstodd_inx*tr_data')/6;
                firsteven_data = (firsteven_inx*tr_data')/6;
                secondodd_data = (secondodd_inx*tr_data')/6;
                secondeven_data = (secondeven_inx*tr_data')/6;

                firstcorr_data = corr(firstodd_data',firsteven_data');
                secondcorr_data = corr(secondodd_data',secondeven_data');

                %Convert corr values to z values using Fisher transform
                firstcorr_data = fisherz(firstcorr_data);
                secondcorr_data = fisherz(secondcorr_data);

                firstsameCorr= mean(diag(firstcorr_data));
                secondsameCorr= mean(diag(secondcorr_data));

                overlap = zeros(4,4);
                overlap(1,2) = 1;
                overlap(2,1) = 1; 
                overlap(3,4) = 1;
                overlap(4,3) = 1;

                firstoverlapCorr = mean(firstcorr_data(find(overlap)));
                secondoverlapCorr = mean(secondcorr_data(find(overlap)));

                diff = zeros(4,4);
                diff(1,3:4) = 1;
                diff(2,3:4) = 1;
                diff(3,1:2) = 1;
                diff(4,1:2) = 1;

                firstdiffCorr = mean(firstcorr_data(find(diff)));
                seconddiffCorr = mean(secondcorr_data(find(diff)));


                dataMat(1,startcol:endcol) = [firstsameCorr firstoverlapCorr  firstdiffCorr secondsameCorr secondoverlapCorr seconddiffCorr];
                dataMat(2,startcol:endcol) = [1 2 3 1 2 3]; %this row identifies the comparision 1 == same 2= overlap 3= diff
                dataMat(3,startcol:endcol) = [1 1 1 2 2 2]; %this row identifies the half
                dataMat(4,startcol:endcol) = i;
                startcol = endcol + 1;
           end
    end
    
elseif P.split == 0
    firsthalf = meta_runs_condensed<7; %get index for rusn 1-6
    secondhalf = meta_runs_condensed>8; %get index for rusn 9-14

    first_inx = zeros(4,112);
    second_inx =zeros(4,112);
    
        for route = 1:4
            first_inx(route,:) = condensed_regs_all(route,:)  & firsthalf;
            second_inx(route,:) = condensed_regs_all(route,:) & secondhalf;
        end
        
      first_data = (first_inx*all_data')/12;
      second_data = (second_inx*all_data')/12;
      
      firstcorr_data = corr(first_data',first_data');
      secondcorr_data = corr(second_data',second_data');
      
      firstcorr_data = triu(firstcorr_data,1) + tril(firstcorr_data,-1); %add upper and lower havles of the triangle to get rid of 1s on the diag
      secondcorr_data = triu(secondcorr_data,1) + tril(secondcorr_data,-1); %add upper and lower havles of the triangle to get rid of 1s on the diag
      
      %Convert corr values to z values using Fisher transform
      firstcorr_data = fisherz(firstcorr_data);
      secondcorr_data = fisherz(secondcorr_data);
    
      firstsameCorr= mean(diag(firstcorr_data));
      secondsameCorr= mean(diag(secondcorr_data));
    
        overlap = zeros(4,4);
        overlap(2,1) = 1; 
        overlap(4,3) = 1;
    
    
    firstoverlapCorr = mean(firstcorr_data(find(overlap)));
    secondoverlapCorr = mean(secondcorr_data(find(overlap)));
    
    diff = zeros(4,4);
    diff(3,1:2) = 1;
    diff(4,1:2) = 1;
    
    firstdiffCorr = mean(firstcorr_data(find(diff)));
    seconddiffCorr = mean(secondcorr_data(find(diff)));
    
     dataMat(1,:) = [firstsameCorr firstoverlapCorr firstdiffCorr secondsameCorr secondoverlapCorr seconddiffCorr];
     dataMat(2,:) = [1 2 3 1 2 3]; %this row identifies the comparision 1 == same 2= overlap 3= diff
     dataMat(3,:) = [1 1 1 2 2 2]; %this row identifies the half
     
end
end


   
