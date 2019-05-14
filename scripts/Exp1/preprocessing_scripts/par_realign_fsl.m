function par_realign_fsl(subpar)
% function par_unwarp(subpar)
% runs unwarp using fsl's fugue tool

% fugue -i image_to_be_unwarped --loadfmap=fieldmap --unwarpdir= [x/y/z/x�/y�/z�] --dwell=1 -u warped_output

% Usage: 
% fugue -i <epi> -p <unwrapped phase map> -d <dwell-to-asym-ratio> -u <result> [options]
% fugue  -i <unwarped-image> -p <unwrapped phase map> -d <dwell-to-asym-ratio> -w <epi-like-result> [options]
% fugue -p <unwrapped phase map> -d <dwell-to-asym-ratio> --saveshift=<shiftmap> [options]

% image_to_be_warped:
%        Nifti file to be unwarped, such as an EPI. 
%        NOTE that this file should be in register with the field map
%        (which it is in our case as EPI_to_cal_synth_EPI is derived from the same
%        calibration data)
% fieldmap:
%       Nifti file containing the B0 field map
% unwarpdir:
%       Indicates the direction that the unwarp should be applied. This will usually correspond to your EPI readout direction, unless your EPI has been rotated. A negative sign following the x, y, or z indicates reversed readout.
% dwell: the CBI B0 field map is in units of echo spacing, so this parameter is set to 1 
% warped_output:
%       filename for the warped output
% 
% 
% subpar refers to either the subject number (in string notation) or 
% the par struct generated by par = par_params(subject)
% modified from old parscripts by jbh on 7/23/08


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
fprintf('---Realign for %s---\n',par.substr);



for run = 1:par.numscans
    if par.data_seg == 1 %if its the experiment data
        if run <10
            filename = fullfile(par.funcdir,['scan0' int2str(run)], ['scan0' int2str(run) '.nii']);
            scanpath = fullfile(par.funcdir,['scan0' int2str(run)]);
            output = [sprintf( '\''') scanpath '/rscan0' int2str(run) sprintf( '\''') ];%outputfilename
        else
            filename = fullfile(par.funcdir,['scan' int2str(run)], ['scan' int2str(run) '.nii']);
            scanpath = fullfile(par.funcdir,['scan' int2str(run)]);
            output = [sprintf( '\''') scanpath '/rscan' int2str(run) sprintf( '\''') ];%outputfilename
        end
        
        scanname = ['scan' num2str(run,'%02d')];
    elseif par.data_seg == 2 %if its the localizer data
        filename = fullfile(par.funcdir,'localizer/localizer.nii');
        scanpath = fullfile(par.funcdir,'localizer');
        output = [sprintf( '\''') scanpath '/rlocalizer' sprintf( '\''') ];%outputfilename
        
        scanname = 'localizer';
    end
  functional =[sprintf( '\''') filename sprintf( '\''')];  % this the the .nii file for the given run #
  synthEPI = [sprintf( '\''') par.synthEPI sprintf( '\''')]; %this is the .nii synthEPI file which will be used as a reference slice

if exist(fullfile(par.funcdir,scanname,['r' scanname '.nii']),'file')
    fprintf('Realignment already run for scan %s \n',run)
else
% %Send all information to command linen to run fsl
 eval(['!/usr/local/fsl/bin/mcflirt -in ' functional ' -o ' output ' -reffile ' synthEPI ' -plots -report']);
end
end

    %Plot motion parameters and save to pdf

    if ~exist(par.motiondir,'dir')
        mkdir(par.motiondir)
    end

    for run = 1:par.numscans
         if run <10
          rp = load([par.funcdir '/scan0' num2str(run) '/rscan0' num2str(run) '.par']);  
         else
          rp = load([par.funcdir '/scan' num2str(run) '/rscan' num2str(run) '.par']);    
         end
            figure;
            subplot(2,1,1);plot(rp(:,1:3));
            set(gca,'xlim',[0 size(rp,1)+1]);
            subplot(2,1,2);plot(rp(:,4:6));
            set(gca,'xlim',[0 size(rp,1)+1]);
            eval(['print -painters -dpdf -r600 ' par.motiondir '/scan' num2str(run) '.pdf']);
            close;
    end



cd(origdir);
fprintf('---Realign COMPLETED for %s---\n',par.substr);

end

