function par_artifact_detect(subpar)

if isstruct(subpar) % if it is par_params struct
    par = subpar;
else % assume subject string
    par = par_params(subpar);
end

cd(par.funcdir);
fprintf('---Artifact Detection for %s---\n',par.substr);

for run = 1:par.numscans;
    if par.data_seg == 1 %if its the experiment data
        if run <10
            filename = fullfile(par.funcdir,['scan0' int2str(run)], ['rscan0' int2str(run) '.nii']);
            scanpath = fullfile(par.funcdir,['rscan0' int2str(run)]);
            output = [sprintf( '\''') scanpath '/rscan0' int2str(run) sprintf( '\''') ];%outputfilename
        else
            filename = fullfile(par.funcdir,['scan' int2str(run)], ['rscan' int2str(run) '.nii']);
            scanpath = fullfile(par.funcdir,['rscan' int2str(run)]);
            output = [sprintf( '\''') scanpath '/rscan' int2str(run) sprintf( '\''') ];%outputfilename
        end
    elseif par.data_seg == 2 %if its the localizer data
        filename = fullfile(par.funcdir,'localizer/localizer.nii');
        scanpath = fullfile(par.funcdir,'localizer');
        output = [sprintf( '\''') scanpath '/rlocalizer' sprintf( '\''') ];%outputfilename
    end

xx = spm_vol(par.mask{:});    
keyboard    

end