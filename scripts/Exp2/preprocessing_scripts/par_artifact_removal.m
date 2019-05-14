function par_artifact_removal(subpar)

origdir = pwd;

% ---load par params if need be---

if isstruct(subpar) % if it is par_params struct
    par = subpar;
else % assume subject string
    par = par_params(subpar);
end



fprintf('---Artifact Removal for %s---\n',par.substr);

for run = 1:par.numscans;
    if par.data_seg == 1 %if its the experiment data
        if run <10
            filename = fullfile(par.funcdir,['scan0' int2str(run)], ['urscan0' int2str(run) '.nii']);
        else
            filename = fullfile(par.funcdir,['scan' int2str(run)], ['urscan' int2str(run) '.nii']);
        end
    elseif par.data_seg == 2 %if its the localizer data
        filename = fullfile(par.funcdir,'localizer/urlocalizer.nii');
    end

    %Load Unwarped Timecourse
    hdr = spm_vol(filename);
    [rawrun_full, XYZ] = spm_read_vols(hdr); 
    nV = size(rawrun_full,4);
    hdr = hdr(1);

   %Remove Dropped timepoints
    rawrun_drop = rawrun_full(:,:,:,1:par.dropvol);
    rawrun = rawrun_full(:,:,:,par.minvol:end);

    %Zscore within Voxel
    zrun = zscore(rawrun,[ ],4);
    
    pos_art = zrun>3;
    neg_art = zrun<-3;
    
    %Find Z Score equivelent to 3 sd 
    sd_vox = std(rawrun,[],4);
    pos_3 = sd_vox.*3;
    neg_3 = sd_vox.*-3;
    
    
    pos_mat = zeros(size(rawrun,1),size(rawrun,2),size(rawrun,3),size(rawrun,4)); %create empty matrix the same size as our 4d run data
    neg_mat = pos_mat;
    for i = 1:size(rawrun,4)
        pos_mat(:,:,:,i) = pos_art(:,:,:,i).*pos_3;
        neg_mat(:,:,:,i) = neg_art(:,:,:,i).*neg_3;
    end
    
    posart_inx = find(pos_art); %find indices in the raw data matrix where there is a positive valued artificat
    negart_inx = find(neg_art); %find indices in the raw data matrix where there is a negative valued artificat
    
    pos_replace = pos_mat(find(pos_mat));
    neg_replace = neg_mat(find(neg_mat));

    rawrun(posart_inx) = pos_replace;
    rawrun(negart_inx) = neg_replace;

    rawrun_save = cat(4,rawrun_drop,rawrun);
    %rawrun_save = single(rawrun_save);
    
    for n = 1:nV
        hdr.n(1)=n;
        spm_write_vol(hdr,rawrun_save(:,:,:,n));
    end
    
fprintf('Run %2d complete\n',run);
end

fprintf('---Artifact Removal COMPLETE for %s---\n',par.substr);
end