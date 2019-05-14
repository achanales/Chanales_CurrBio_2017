function [] = MEGBound_MEG_RestScan(SubjectNumber,iBlock,isMEG,is_debugging,use_eyetracker)
% function [] = MEGBound_Task_16blockversion(SubjectNumber,iBlock,isMEG,is_debugging,use_eyetracker)
%
% MEGBound encoding task
% This version of MEGbound tests 80 B and 96 NB color memory and order
% memory trials.  The order memory trials are separated by a lag of three.
% The color test trials are yoked to lag +1 and -1.
%
% Modified: 02/26/13


% rand('state',sum(100*clock)); PTBSetupExperiment resets rand's seed

%set subject directory and number
if SubjectNumber < 10
    SubjStr = ['0' num2str(SubjectNumber)];
else
    SubjStr = num2str(SubjectNumber);
end
basedir = pwd;


% set experiment paths
encdir = [basedir '/Encoding/'];
imagedir = [basedir '/stim_resize/']; addpath(genpath(imagedir));
stimlistdir = [basedir '/StimLists/']; addpath(genpath(stimlistdir));
datadir = [basedir '/Data/'];
subdir = [datadir SubjStr];
mkdir([datadir SubjStr])

% set various stimulus duration values
if is_debugging
    BlankScreenDur = .01;
    RestDur = Inf;
    StimDur = .01;
    ITI = .01;
    FixDur = .01;
    TestDur = .01;
    TestLoop = .01;
else
    debugmode = 0;
    BlankScreenDur = .25;
    RestDur = Inf;
    StimDur = 2.5;
    ITI = 1.0;
    FixDur = 1.5;
    TestDur = 'any';
    TestLoop = 1;
end

%Add PTBWrapper if its not in the path
% p = path;
% s = strfind(p,'/MEGbound/PTBWrapper/');
% if isempty(s)
%     addpath(genpath([basedir '/PTBWrapper/']));
% end

% add psychtoolbox if not in the path
% if isMEG==1
%     collection_type = 'Char';
%     PTBSetInputCollection(collection_type);
%     PTBInitUSBBox;
% else % if not in MEG, set the psychtoolbox path
%     p = path;
%     s = strfind(p,'/MEGbound/Psychtoolbox/');
%     if isempty(s)
%         addpath(genpath([basedir '/Psychtoolbox/']));
%     end
% end
%PsychJavaTrouble;

% if debugging, skip some stuff
%PTBVersionCheck(1,1,12,'at least');
PTBSetIsDebugging(is_debugging);

if is_debugging
    Screen('Preference', 'SkipSyncTests', 1);
end

% set some defaults
PTBSetExitKey('ESCAPE');
PTBSetBackgroundColor([128 128 128]);
PTBSetTextColor([255 255 255]);		% This defaults to white = (255, 255, 255).
PTBSetTextFont('Arial');		% This defaults to Courier.
PTBSetTextSize(30);				   % This defaults to 30.


% set output file stuff
PTBSetLogFiles(['S' SubjStr '_' num2str(iBlock) '_log_file.txt'], ['S' SubjStr '_' num2str(iBlock) '_data_file.txt']);
PTBSetLogHeaders({'condition','item','itempos','itemcolor','targetloc'})

% set some global variables
global PTBLastPresentationTime;			%#ok<NUSED> % When the last display was presented.
global PTBLastKeyPressTime;				  %#ok<NUSED> % When the last response was given.
global PTBLastKeyPress;						   % The last response given.
global PTBScreenRes;
global PTBWaitForKey;% Has 'width' and 'height' of current display in pixels


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Eye-tracker Initialization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if use_eyetracker
    PTBInitEyeTracker();
    paragraph = {'Eyetracker initialized.','Get ready to calibrate.'};
    PTBDisplayParagraph(paragraph, GL_paragraph_pos, {'a'});
    PTBCalibrateEyeTracker;
    % actually starts the recording
    % name correponding to MEG file (can only be 8 characters!!, no
    % extension)
    PTBStartEyeTrackerRecording(subject);
end


try
    % start experiment
    PTBSetupExperiment('MEGBound_RestScan');
    
    if isMEG==1
        PTBInitStimTracker;
        collection_type = 'Char';
        PTBSetInputCollection(collection_type);
    end
    
    
    
    
    % to use doug's PTBwrapper scripts, need to create
    
    screen_res = get(0,'screensize');
    
    
    instr = {'Please close your eyes and lie still','This scan will be about 5 minutes long','Press any key to continue.'};
    PTBDisplayParagraph(instr,{'center',30},{'any'},1);
    RestScanStart = GetSecs;
    
    while GetSecs - RestScanStart <= 300
        
        PTBDisplayText([num2str(round(300 - (GetSecs - RestScanStart))) ' seconds left.'],{'center'},{1});
        
    end
    
    
    
    instr = {'Please wait for your experimenter.'};
    PTBDisplayParagraph(instr,{'center',30},{'any'},1);
    
    pause(5)
    
    
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Eyelink file
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if use_eyetracker
        
        % retrieve the file
        PTBDisplayText('Saving Data...', {'center', center}, {.1});
        PTBStopEyeTrackerRecording; % <----------- (can take a while)
        
        % move the file to the logs directory
        destination = ['logs'];
        movefile([subject, '_' num2str(iBlock), '.edf'], [destination filesep subject, '.edf'])
    end
    
    PTBCleanupExperiment;
    fclose('all');
    sca; ShowCursor;
    
    
    
    
catch %#ok<CTCH>
    
    cd ../
    PTBHandleError;
    
end

