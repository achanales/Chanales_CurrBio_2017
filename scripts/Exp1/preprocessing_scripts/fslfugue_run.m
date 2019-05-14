% fugue -i image_to_be_unwarped --loadfmap=fieldmap --unwarpdir= [x/y/z/x­/y­/z­] --dwell=1 -u warped_output

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

clear all
clc
% addpath(genpath('Users/kuhllab/Desktop/REI FMRI DATA/SUBJECT1'))
% this does not work yet because the single quotes get lost
for run = 1:8;
filenameid = {'130417115001' '130417115937' '130417120900' '130417121812' '130417122727' '130417123641' '130417124550' '130417125837'};  % these are the .nii file names for the 8 runs for subject 1
if run < 5
EPI_to_cal_synth_EPI = [sprintf( '\''') '/Users/kuhllab/Desktop/REI FMRI DATA/SUBJECT1/HFJSJ9W5/0' int2str(run+5) '+ExperimentalRun/r' filenameid{run} sprintf( '\''')]; % path for these nifti files
else
EPI_to_cal_synth_EPI = [sprintf( '\''') '/Users/kuhllab/Desktop/REI FMRI DATA/SUBJECT1/HFJSJ9W5/' int2str(run+5) '+ExperimentalRun/r' filenameid{run} sprintf( '\''')]; % path for these nifti files    
end
fieldmap = [sprintf( '\''') '/Users/kuhllab/Desktop/REI FMRI DATA/SUBJECT1/HFJSJ9W5/05+CalibrationScan/cal_reg_bo' sprintf( '\''')];; % path and file of fieldmap
EPI_to_cal_rho = [sprintf( '\''') 'r' filenameid{run} '_EPI_to_cal_rho' sprintf( '\''') ];%outputfilename

 %eval(['!/usr/local/fsl/bin/fugue -i' EPI_to_cal_synth_EPI  '--loadfmap=fieldmap --unwarpdir=y --dwell=1 -u ' EPI_to_cal_rho '--nocheck'])
 eval(['!/usr/local/fsl/bin/fugue -i ' EPI_to_cal_synth_EPI  ' --loadfmap=' fieldmap ' --unwarpdir=y --dwell=1 -u ' EPI_to_cal_rho ' --nocheck'])
  
end

% clc

% this works:
% !/usr/local/fsl/bin/fugue -i '/Users/kuhllab/Desktop/REI FMRI DATA/SUBJECT1/HFJSJ9W5/06+ExperimentalRun/r130417115001'  --loadfmap='/Users/kuhllab/Desktop/REI FMRI DATA/SUBJECT1/HFJSJ9W5/05+CalibrationScan/cal_reg_bo' --unwarpdir=y --dwell=1 -u run1EPI_to_cal_rho --nocheck




% example 
% !/usr/local/fsl/bin/fugue -i EPI_to_cal_synth_EPI --loadfmap=cal_reg_bo --unwarpdir=y --dwell=1 -u EPI_to_cal_rho --nocheck

% dwell time: Ed says:
% We use the "dwell time" parameter in a different way than intended, 
% and 1 is the correct value - our B0 field is actually specified in units of Echo Spacing.
% You should add the --nocheck option.  
%
