function [filenames] = mvpa_images(S,smoothedOrNot,normalizedOrNot)
% adjusted for Overlap

nruns = 14; %number of runs 
nvols = 190-6; %number of volumes in a run (length of run minus the first 6 volumes that were dropped)

filenames = [];


counter = 1;
for i = 1:nruns
 for j = 1:nvols
    if smoothedOrNot == 0
        filenames = [filenames; [S.functional_dir sprintf(['/scan%02d'], i) sprintf(['/urscan%02d.nii,%03d'], i,(j+6)) ]];
    elseif smoothedOrNot == 1
        filenames = [filenames; [S.functional_dir sprintf(['/scan%02d'], i) sprintf(['/surscan%02d.nii,%03d'], i,(j+6))]];
    end
    counter  = counter + 1;
end
end


filenames = cellstr(filenames);




