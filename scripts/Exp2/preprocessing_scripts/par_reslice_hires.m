function par_reslice_hires(par)
% This function uses the fsl tool flirt to resample the mprage(hires) into
% function resolution. It requires an nii file calles "space_[function
% resolution" i.e. space_2mm.nii. This nii file is just an empty 3D matrix
% with the same resolution as the functional scans. 

origdir = pwd;

% ---load par params if need be---

if isstruct(subpar) % if it is par_params struct
    par = subpar;
else % assume subject string
    par = par_params(subpar);
end

%setenv FSLDIR /usr/local/fsl
%setenv PATH ${FSLDIR}/bin:${PATH}
setenv('FSLOUTPUTTYPE', 'NIFTI');
%  %source ${FSLDIR}/etc/fslconf/fsl.csh

cd(par.funcdir);
% run unwarp; generate mean img
fprintf('---Resslicing Hi_Res for %s---\n',par.substr);

identitymatrix = fullfile(par.scriptsdir,'reslice_only.mat');
output = fullfile(par.anatdir,'hires_2mm.nii');

  hires =[sprintf( '\''') par.hiresimg sprintf( '\''')];  % this the the .nii hires file that should have already been registred to functional space
  space = [sprintf( '\''') par.emptyspace sprintf( '\''')]; %this is the .nii empty matrix with the same resolution as functionals
  output = [sprintf( '\''') par.hiresimg sprintf( '\''')]; 

% %Send all information to command linen to run fsl
 eval(['!/usr/local/fsl/bin/flirt -in ' functional ' -o ' output ' -reffile ' synthEPI ' -plots -report']);


end

cd(origdir);
fprintf('---Realign COMPLETED for %s---\n',par.substr);

end

