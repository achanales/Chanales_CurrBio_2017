function par_slspecest(matplace,scans)
% Set up the design matrix and run a design.

spm_defaults;
global defaults
defaults.modality='FMRI';

original_dir = pwd;
[p n e v] = fileparts(matplace);
cd(p);
load(job.spmmat{1});    
% Image filenames
%-------------------------------------------------------------
SPM.xY.P = strvcat(scans);

% Let SPM configure the design
%-------------------------------------------------------------
SPM = spm_fmri_spm_ui(SPM);

if ~isempty(job.mask)&&~isempty(job.mask{1})
    SPM.xM.VM         = spm_vol(job.mask{:});
    SPM.xM.xs.Masking = [SPM.xM.xs.Masking, '+explicit mask'];
end

%-Save SPM.mat
%-----------------------------------------------------------------------
fprintf('%-40s: ','Saving SPM configuration')   %-#
if str2num(version('-release'))>=14,
    save('SPM','-V6','SPM');
else
    save('SPM','SPM');
end;

fprintf('%30s\n','...SPM.mat saved')                     %-#


my_cd(original_dir); % Change back dir
fprintf('Done\n')
return
%----------------------------