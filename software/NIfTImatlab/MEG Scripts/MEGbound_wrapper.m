function [] = MEGbound_wrapper(SubjectNumber)

addpath(genpath('/MEGbound/PTBWrapper'))
addpath(genpath('/Volumes/davachilab/MEGbound/Psychtoolbox'))
iBlock = 1:16; 
isMEG = 0;
is_debugging = 0;
use_eyetracker = 0;

for irun = 1:length(iBlock)
    
    MEGBound_Task_16blockversion_pilot_02252013(SubjectNumber,iBlock(irun),isMEG,is_debugging,use_eyetracker)
    PTBCleanupExperiment;
    fclose('all');
    sca;
    cd ../
end

PTBCleanupExperiment;
fclose('all');
%unix(['mv S' SubjStr '*_file.txt ' datadir '.']);
%unix(['mv encodingDataFileSub' SubjStr 'Block' num2str(iBlock) '*_file.txt ' datadir '.']);
%unix(['mv testDataFileSub' SubjStr 'Block' num2str(iBlock) '*_file.txt ' datadir '.']);
sca; ShowCursor;

return