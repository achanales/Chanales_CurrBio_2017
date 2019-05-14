function [] = MEGBound_MEG_Task(SubjectNumber,iBlock,is_debugging,isMEG,use_eyetracker)
% function [] = MEGBound_Task_16blockversion(SubjectNumber,iBlock,isMEG,is_debugging,use_eyetracker)
%
% MEGBound encoding task
% This version of MEGbound tests 80 B and 96 NB color memory and order
% memory trials.  The order memory trials are separated by a lag of three.
% The color test trials are yoked to lag +1 and -1.
%
% Modified: 02/26/13
%
% Modified: 04/18/13 AH: -added listen for button box only, unique names
% for eyetracking edf files.  They are formatted like this: 
% ['MB' SubjStr '_' num2str(iBlock) '.edf']
% 


% rand('state',sum(100*clock)); PTBSetupExperiment resets rand's seed

% make sure Matlab is listening for button box ONLY

%get the devices attached
[a b] = GetKeyboardIndices;

%find the button box index and pass it to kbcheck so that kbcheck only listens
%for the button box
BBidx = a(strmatch('904',b));


%set subject directory and numbe
if SubjectNumber < 10
    SubjStr = ['0' num2str(SubjectNumber)];
else
    SubjStr = num2str(SubjectNumber);
end
basedir = pwd;

%set up counterbalancing
cbal = mod(SubjectNumber,16);
load([basedir '/Encoding/TO_pos_cbal_16block']);

%load colorsamples
load([basedir '/scripts/colorsamples.mat'])
colorsamples_RGB = colorsamples.*255;

%switch the side of the correct presentation for every other subject
if mod(SubjectNumber,2)==0
    TO_pos_cbal = [TO_pos_cbal(:,2,:) TO_pos_cbal(:,1,:) ~TO_pos_cbal(:,3,:)];
end

%create array for source memory correct responses, 0 means present correct
%response to left, 1 means present correct response to the right
load([basedir '/Encoding/sourceMem_cb'])

%for every other subject, the correct response switches
if mod(SubjectNumber,2)==0
    sourceMem_cb = ~sourceMem_cb;
end

%reshape the array to be better for blocks
%sourceMem_cb = reshape(sourceMem_cb,3,1,16);


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
    StimDur = 2.5;
    ITI = 1.0;
    FixDur = 1.5;
    TestDur = 'any';
    TestLoop = 1;
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
PTBSetLogHeaders({'condition','item','itempos','itemcolor','targetloc'});
%PTBSetLogAppend(3,'clear',{'NaN'});


% set some global variables
global PTBLastPresentationTime;			%#ok<NUSED> % When the last display was presented.
global PTBLastKeyPressTime;				  %#ok<NUSED> % When the last response was given.
global PTBLastKeyPress;						   % The last response given.
global PTBScreenRes;
global PTBWaitForKey;% Has 'width' and 'height' of current display in pixels



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Eye-tracker Initialization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if use_eyetracker
%     PTBInitEyeTracker();
%
%     paragraph = {'Eyetracker initialized.','Get ready to calibrate.'};
%     PTBDisplayParagraph(paragraph, {'center',30}, {'any'});
%     % actually starts the recording
%     % name corresponding to MEG file (can only be 8 characters!!, no extension)
%
%     PTBStartEyeTrackerRecording(SubjectNumber);
% end





try
    % start experiment
    PTBSetupExperiment('MEGBound_Task');
    
    if isMEG==1
        PTBInitStimTracker;
        collection_type = 'Char';
        PTBSetInputCollection(collection_type);
    end
    
    if use_eyetracker
        PTBInitEyeTracker();
        paragraph = {'Eyetracker initialized.','Get ready to calibrate.'};
        PTBDisplayParagraph(paragraph, {'center',30}, {'any'});
        PTBCalibrateEyeTracker;
        % actually starts the recording
        % name corresponding to MEG file (can only be 8 characters!!, no extension)
        
        PTBStartEyeTrackerRecording(['MB' SubjStr '_' num2str(iBlock)]);
    end
    
    % go to encoding directory and load encoding sequence
    cd(encdir);
    listnum = mod(SubjectNumber,12);
    if listnum == 0
        listnum = 12;
    end
    load(['encodingSeq',num2str(listnum)])
    
    % define number of blocks and items
    nBlocks = 16;
    nItems = 576;
    nBTestItems = 80;
    nNBTestItems = 96;
    
    %keyboard
    % reshape the lists into blocks
    for iRange = 1:nBlocks-1
        nRange(iRange) = (nItems/nBlocks)*iRange;
    end
    
    nRange = [0 nRange nItems];
    
    for jBlock = 1:length(nRange)-1
        encodingSeqTmp(:,:,jBlock) = encodingSeq(nRange(jBlock)+1:nRange(jBlock+1),:);
    end
    
    encodingSeq = encodingSeqTmp;
    clear encodingSeqTmp
    
    % now load in the test stims
    load(['testSeq_16block_V8_',num2str(listnum),'.mat'])
    
    % reformat test stims
    TestStimsTmp(:,:,1) = testSeq(1:22,:);
    TestStimsTmp(:,:,2) = testSeq(23:44,:);
    TestStimsTmp(:,:,3) = testSeq(45:66,:);
    TestStimsTmp(:,:,4) = testSeq(67:88,:);
    TestStimsTmp(:,:,5) = testSeq(89:110,:);
    TestStimsTmp(:,:,6) = testSeq(111:132,:);
    TestStimsTmp(:,:,7) = testSeq(133:154,:);
    TestStimsTmp(:,:,8) = testSeq(155:176,:);
    TestStimsTmp(:,:,9) = testSeq(177:198,:);
    TestStimsTmp(:,:,10) = testSeq(199:220,:);
    TestStimsTmp(:,:,11) = testSeq(221:242,:);
    TestStimsTmp(:,:,12) = testSeq(243:264,:);
    TestStimsTmp(:,:,13) = testSeq(265:286,:);
    TestStimsTmp(:,:,14) = testSeq(287:308,:);
    TestStimsTmp(:,:,15) = testSeq(309:330,:);
    TestStimsTmp(:,:,16) = testSeq(331:end,:);
    
    
    TestStims = TestStimsTmp;
    
    
    % to use doug's PTBwrapper scripts, need to create
    %sca
    %keyboard
    screen_res = get(0,'screensize');
    %     colorboxSize1 = screen_res(4);
    %     colorboxSize2 = screen_res(3);
    colorboxSize1 = 600;
    colorboxSize2 = 600;
    %colorboxSize = [PTBScreenRes.width PTBScreenRes.height];
    whiteboxSize = 350;
    
    % white bkgd box is always the same, define it here
    whitebox = 255*ones(whiteboxSize,whiteboxSize,3);
    
    blackcolorbox = cat(3,ones(400,400).*205, ...
        ones(400,400).*205, ...
        ones(400,400).*205);
    
    currcolorbox = cat(3,ones(colorboxSize1,colorboxSize2).*colorsamples_RGB(1,1), ...
        ones(colorboxSize1,colorboxSize2).*colorsamples_RGB(1,2), ...
        ones(colorboxSize1,colorboxSize2).*colorsamples_RGB(1,3));
    
    %define some variables
    rgbcolor = cell2mat([encodingSeq(:,5,iBlock) encodingSeq(:,6,iBlock) encodingSeq(:,7,iBlock)]);
    itemfile = encodingSeq(:,1,iBlock);
    boundtype = encodingSeq(:,2,iBlock);
    withinEventPos = cell2mat(encodingSeq(:,3,iBlock));
    encodingColor = cell2mat(encodingSeq(:,4,iBlock));
    practicefile = {'667.bmp'; '668.bmp'; '669.bmp'; '670.bmp'; '671.bmp'; '672.bmp'};
    
    %define number of trials
    nTrials = length(itemfile);
    
%     % wait for a keypress
%     if iBlock ==1
%         
%         
%         
%         %PTBDisplayText('+',{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{FixDur});
%         
%         instr = {'Welcome to the Memory Experiment!', 'In this task, you will view a series of objects embedded on a color background.','For each trial, please visualize the object in the color background and decide whether the', 'object/color background combination is pleasing to you. Then, you will be tested','on your memory for the object/color combinations as well as the','order in which the objects were presented. Press any key to go on.'};
%         PTBDisplayParagraph(instr,{'center',30},{'any'});
%         PTBDisplayBlank({.3},'Blank');
%         
%         instr = {'In this practice experiment, you will see 6 objects, one at a time.',' For each object, please indicate whether the object/color combination',' is pleasing to you. Try to remember the color of the background for each object,','as well as the order of the objects because you will be tested after this study period.','In this practice, you will have as much time as you need to make your decision.','Press any key to give it a try.'};
%         PTBDisplayParagraph(instr,{'center',30},{'any'});
%         PTBDisplayBlank({2},'Blank');
%         
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
%         PTBDisplayPictures(practicefile(1), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
%         
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
%         PTBDisplayPictures(practicefile(2), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
%         
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
%         PTBDisplayPictures(practicefile(3), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
%         
%         currcolorbox = cat(3,ones(colorboxSize1,colorboxSize2).*colorsamples_RGB(13,1), ...
%             ones(colorboxSize1,colorboxSize2).*colorsamples_RGB(13,2), ...
%             ones(colorboxSize1,colorboxSize2).*colorsamples_RGB(13,3));
%         
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
%         PTBDisplayPictures(practicefile(4), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
%         
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
%         PTBDisplayPictures(practicefile(5), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
%         
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
%         PTBDisplayPictures(practicefile(6), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
%         PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
%         
%         %Practice Test
%         corr_colorbox = cat(3,ones(350,350).*colorsamples_RGB(1,1), ...
%             ones(350,350).*colorsamples_RGB(1,2), ...
%             ones(350,350).*colorsamples_RGB(1,3));
%         
%         lure_colorbox = cat(3,ones(350,350).*colorsamples_RGB(13,1), ...
%             ones(350,350).*colorsamples_RGB(13,2), ...
%             ones(350,350).*colorsamples_RGB(13,3));
%         
%         instr = {'Now, let''s try the practice test.','First, please indicate the color of the border that the item was studied with.', 'An item will appear on the screen with two different colors below it.','One of these two colors is the correct color that the item was studied with.','Please press the H key if you are sure it was the color on the left.','Please press the J key if you think it was the color on the left, but not sure.','Please press the L key if you are sure it was the color on the right.','Please press the K key if you think it was the color on the left, but not sure.','Press any key to start the practice color memory test.'};
%         PTBDisplayParagraph(instr,{'center',30},{'any'});
%         PTBDisplayBlank({2},'Blank');
%         
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]},{-1},'practice');
%         PTBDisplayMatrices({corr_colorbox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.75]},{-1},'practice');
%         PTBDisplayMatrices({lure_colorbox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.75]}, {-1},'practice');
%         
%         PTBDisplayText('LEFT SURE     LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.95]},{-1});
%         PTBDisplayText('RIGHT UNSURE     RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.95]},{-1});
%         PTBDisplayPictures(practicefile(2),{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]}, {1}, {'any'},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]},{1.5},'practice');
%         
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]},{-1},'practice');
%         PTBDisplayMatrices({lure_colorbox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.75]},{-1},'practice');
%         PTBDisplayMatrices({corr_colorbox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.75]}, {-1},'practice');
%         
%         PTBDisplayText('LEFT SURE     LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.95]},{-1});
%         PTBDisplayText('RIGHT UNSURE     RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.95]},{-1});
%         PTBDisplayPictures(practicefile(5),{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]}, {1}, {'any'},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]},{1.5},'practice');
%         
%         instr = {'Now, you''ll try the practice item order test.','Which item appeared first?','Please press the H key if you are sure it was the object on the left.','Please press the J key if you think it was the object on the left, but not sure.','Please press the L key if you are sure it was the object on the right.','Please press the K key if you think it was the object on the left, but not sure.','Press any key to start the practice item order test.'};
%         PTBDisplayParagraph(instr,{'center',30},{'any'});
%         PTBDisplayBlank({2},'Blank');
%         
%         PTBDisplayText('LEFT SURE     LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.7]},{-1});
%         PTBDisplayText('RIGHT UNSURE     RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.7]},{-1});
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]},{-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]},{-1},'practice');
%         PTBDisplayPictures(practicefile(1),{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]}, {1}, {-1},'practice');
%         PTBDisplayPictures(practicefile(3),{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]}, {1}, {'any'},'practice')
%         PTBDisplayBlank({2},'Blank');
%         
%         PTBDisplayText('LEFT SURE     LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.7]},{-1});
%         PTBDisplayText('RIGHT UNSURE     RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.7]},{-1});
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]},{-1},'practice');
%         PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]},{-1},'practice');
%         PTBDisplayPictures(practicefile(6),{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]}, {1}, {-1},'practice');
%         PTBDisplayPictures(practicefile(4),{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]}, {1}, {'any'},'practice')
%         PTBDisplayBlank({2},'Blank');
%         
%         instr = {'Any questions?  If so, please ask your experimenter at this time.','If not, please notify your experimenter that you understand the task and are ready to start!'};
%         PTBDisplayParagraph(instr,{'center',30},{'any'});
%         PTBDisplayBlank({2},'Blank');
%         
%     end
    %initiate encoding output data
    encodingDataFile = cell(nTrials+1,8);
    encodingDataFile{1,1} = 'trialnum';
    encodingDataFile{1,2} = 'trialID';
    encodingDataFile{1,3} = 'time';
    encodingDataFile{1,4} = 'respTime';
    encodingDataFile{1,5} = 'RT';
    encodingDataFile{1,6} = 'resp';
    encodingDataFile{1,7} = 'boundType';
    encodingDataFile{1,8} = 'testColor';
    encodingDataFile{1,9} = 'position';
    
    
    %initiate test output data
    testDataFile = cell(23,10);
    testDataFile{1,1} = 'trialnum';
    testDataFile{1,2} = 'itemTrialID';
    testDataFile{1,3} = 'TOCorrectTrialID';
    testDataFile{1,4} = 'TOIncorrectTrialID';
    testDataFile{1,5} = 'time';
    testDataFile{1,6} = 'respTime';
    testDataFile{1,7} = 'RT';
    testDataFile{1,8} = 'resp';
    testDataFile{1,9} = 'boundType';
    testDataFile{1,10} = 'itemEncodingColor';
    testDataFile{1,11} = 'TOPosCbal';
    testDataFile{1,11} = 'LurePosition';
    
    
    % display instructions
    instr = {'Press any key to start the experiment.'};
    PTBDisplayParagraph(instr,{'center',30},{'any'});
    PTBDisplayBlank({2},'Blank');
    
    %Short Delay
    
    PTBDisplayText('+',{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{2});
    
    %%% loop through encoding trials %%%
    for iTrial = 1:nTrials
        
        
        % create the color box
        currcolorbox = cat(3,ones(colorboxSize1,colorboxSize2).*rgbcolor(iTrial,1), ...
            ones(colorboxSize1,colorboxSize2).*rgbcolor(iTrial,2), ...
            ones(colorboxSize1,colorboxSize2).*rgbcolor(iTrial,3));
        
        % display color and white boxes, but use different trigger if a
        % color switch trial
        
        PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{-1},num2str(rgbcolor(iTrial,:)));
        PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{-1},'white')
        
        % display the item
        
        
        %PTBDisplayMatrices({blackcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{1}, {2.5,'any'}, 'flag', 1, 0);
        
        PTBDisplayPictures(itemfile(iTrial), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {2.5,'any'}, 'flag', 1, 0);
        trialOnset = GetSecs;
        respTime = [];
        RT= [];
        resp = [];
        expPaused = [];
        
        
        %get response
        while GetSecs - trialOnset < StimDur
            
            
            [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
            
            if keyIsDown
                
                if strcmp(kbname(keyCode),'p')
                    
                    pause(.1)
                    
                    while 1
                        
                        [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
                        
                        if keyIsDown
                            
                            if strcmp(kbname(keyCode),'p')
                                
                                resp = 'p';
                                clear keyIsDown
                                pause(.1)
                                break
                                
                            end
                            
                        end
                        
                    end
                    
                    
                elseif sum(keyCode)==1
                    
                    resp = kbname(keyCode);
                    
                else
                    
                    resp = 'm';
                    
                end
                
                
                
                respTime = TimeSecs;
                RT = TimeSecs - trialOnset;
                disp(num2str(RT))
            end
            
        end
        
        
        % redraw the color border
        PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{-1},num2str(rgbcolor(iTrial,:)));
        PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{-1},'white');
        
        %Present the ITI
        PTBDisplayText(' ',{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{ITI});
        
        %keyboard
        ITIOnset = GetSecs;
        
        %get responses during ITI
        while GetSecs - ITIOnset < ITI
            
            
            [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
            
            if keyIsDown
                
                if strcmp(kbname(keyCode),'p')
                    
                    
                    pause(.1)
                    clear keyIsDown
                    
                    while 1
                        
                        [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
                        
                        if keyIsDown
                            
                            if strcmp(kbname(keyCode),'p')
                                
                                resp = 'p';
                                clear keyIsDown
                                pause(.1)
                                break
                                
                            end
                            
                        end
                        
                    end
                    
                    
                elseif sum(keyCode)==1
                    
                    resp = kbname(keyCode);
                    
                else
                    
                    resp = 'm';
                    
                end
                
                
                
                respTime = TimeSecs;
                RT = TimeSecs - trialOnset;
                pause(.1)
            end
            
        end
        
        PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{-1},num2str(rgbcolor(iTrial,:)));
        PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{-1},'white');
        PTBSetTextColor([1 1 1])
        
        %Grab ITI Responses
        PTBDisplayText('+',{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{FixDur});
        %         respTime =  PTBLastKeyPressTime;
        %         resp =  PTBLastKeyPress;
        
        %PTBDisplayText('+',{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{FixDur-.1});
        
        
        PTBSetTextColor([255 255 255])
        fixOnset = GetSecs;
        
        while GetSecs - fixOnset < FixDur
            
            
            [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
            
            if keyIsDown
                
                
                if strcmp(kbname(keyCode),'p')
                    
                    pause(.1)
                    
                    while 1
                        
                        [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
                        
                        if keyIsDown
                            
                            if strcmp(kbname(keyCode),'p')
                                
                                resp = 'p';
                                clear keyIsDown
                                pause(.1)
                                break
                                
                            end
                            
                        end
                        
                    end
                    
                    
                    
                end
                
            end
            
        end
        
        
        
        %write out encoding data after every trial
        
        encodingDataFile{iTrial+1,1}= iTrial;
        encodingDataFile{iTrial+1,2}= itemfile(iTrial);
        encodingDataFile{iTrial+1,3}= trialOnset;
        encodingDataFile{iTrial+1,4}= respTime;
        encodingDataFile{iTrial+1,5}= respTime - trialOnset;
        encodingDataFile{iTrial+1,6}= resp;
        encodingDataFile{iTrial+1,7}= boundtype(iTrial);
        encodingDataFile{iTrial+1,8}= encodingColor(iTrial);
        encodingDataFile{iTrial+1,9}= withinEventPos(iTrial);
        save([subdir '/encodingDataFileSub' SubjStr 'Block' num2str(iBlock) '.mat'],'encodingDataFile')
        
        
        %reset write out encoding data variables
        %trialOnset = [];
        %respTime = [];
        %RT = [];
        %keyCode = [];
        %resp =[];
        clear keyIsDown TimeSecs keyCode
        
    end % iTrial
    
    
    %End of encoding stuff
    endblock = {'You have reached the end of the study phase for this block.', 'Get ready for the test phase.', 'Hit any key to proceed.'};
    PTBDisplayParagraph(endblock,{'center',30},{'any'});
    
    
    
    %Define number of trials and test items for the test block
    nTrials = length(TestStims(:,1,iBlock));
    testfile = TestStims(:,1:3,iBlock);
    testColor = cell2mat(TestStims(:,6,iBlock));
    
    %Short Delay
    PTBDisplayText('+',{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{2});
    
    %%% loop through test trials %%%
    
    trial_counter = 1;
    cbal_counter = 1;
    source_counter = 1;
    firstSource = 1;
    firstOrder = 1;
    
    sourceblock = {'Color Memory Test.'};
    PTBDisplayParagraph(sourceblock,{'center',30},{3});
    
    
    for iTrial = 1:nTrials
        
        trial_counter = trial_counter + 1;
        
        %reset write out test data variables
        trialOnset = [];
        respTime = [];
        RT = [];
        keyCode = [];
        resp =[];
        
        % 0 is for intact order, 1 is for rearranged, 2 is for source
        
        
        % First, present 11 trials for the color source memory.  Then, present
        % 11 trials of the intact/rearrange order memory
        
        
        
        if  any(iTrial==1:11)
            
            
            corr_color = colorsamples_RGB(TestStims{iTrial,7,iBlock},:);
            lure_color = colorsamples_RGB(TestStims{iTrial,8,iBlock},:);
            
            
            
            colorBoxSize = 250;
            
            corr_colorbox = cat(3,ones(colorBoxSize,colorBoxSize).*corr_color(1), ...
                ones(colorBoxSize,colorBoxSize).*corr_color(2), ...
                ones(colorBoxSize,colorBoxSize).*corr_color(3));
            
            lure_colorbox = cat(3,ones(colorBoxSize,colorBoxSize).*lure_color(1), ...
                ones(colorBoxSize,colorBoxSize).*lure_color(2), ...
                ones(colorBoxSize,colorBoxSize).*lure_color(3));
            
            
            if TestStims{iTrial,9,iBlock}==0
                
                
                PTBDisplayText('LEFT SURE     LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.95]},{-1});
                PTBDisplayText('RIGHT UNSURE     RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.95]},{-1});
                PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]},{-1},'white');
                
                PTBDisplayMatrices({corr_colorbox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.75]},{-1},num2str(colorsamples_RGB(TestStims{iTrial,6,iBlock},:)));
                PTBDisplayMatrices({lure_colorbox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.75]},{-1},num2str(colorsamples_RGB(TestStims{iTrial,7,iBlock},:)));
                PTBDisplayPictures(testfile(iTrial,1),{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]}, {1}, {TestDur},'Color Test', 2, 0);
                trialOnset = GetSecs;
                
            elseif TestStims{iTrial,9,iBlock}==1
                
                
                PTBDisplayText('LEFT SURE     LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.95]},{-1});
                PTBDisplayText('RIGHT UNSURE     RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.95]},{-1});
                PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]},{-1},'white');
                
                PTBDisplayMatrices({corr_colorbox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.75]},{-1},num2str(colorsamples_RGB(TestStims{iTrial,6,iBlock},:)));
                PTBDisplayMatrices({lure_colorbox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.75]},{-1},num2str(colorsamples_RGB(TestStims{iTrial,7,iBlock},:)));
                PTBDisplayPictures(testfile(iTrial,1),{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]}, {1}, {TestDur},'Color Test', 2, 0);
                trialOnset = GetSecs;
            end
            
            %order test
        elseif TestStims{iTrial,9,iBlock}==0
            
            PTBDisplayText('LEFT SURE     LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.8]},{-1});
            PTBDisplayText('RIGHT UNSURE     RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.8]},{-1});
            PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]},{-1},'white');
            PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]},{-1},'white');
            PTBDisplayPictures(testfile(iTrial,2),{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]}, {1}, {-1},'Test TO');
            PTBDisplayPictures(testfile(iTrial,3),{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]}, {1}, {TestDur}, 'Order Test', 4, 0)
            trialOnset = GetSecs;
            
        elseif TestStims{iTrial,9,iBlock}==1
            
            PTBDisplayText('LEFT SURE     LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.8]},{-1});
            PTBDisplayText('RIGHT UNSURE     RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.8]},{-1});
            PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]},{-1},'white');
            PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]},{-1},'white');
            PTBDisplayPictures(testfile(iTrial,2),{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]}, {1}, {-1},'Test TO');
            PTBDisplayPictures(testfile(iTrial,3),{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]}, {1}, {TestDur}, 'Order Test',4, 0)
            trialOnset = GetSecs;
            
        end
        
        
        
        
        %get responses
        while TestLoop
            
            [keyIsDown,TimeSecs,keyCode] = KbCheck(BBidx);
            
            if keyIsDown
                
                resp = kbname(keyCode);
                respTime = TimeSecs;
                RT = TimeSecs - trialOnset;
                clear keyIsDown
                break
            end
            
        end
        
        
        %write out test data file after every trial
        
        
        testDataFile{trial_counter,1}= iTrial;
        testDataFile{trial_counter,2}= TestStims{iTrial,1,iBlock};
        testDataFile{trial_counter,3}= TestStims{iTrial,2,iBlock};
        testDataFile{trial_counter,4}= TestStims{iTrial,3,iBlock};
        testDataFile{trial_counter,5}= trialOnset;
        testDataFile{trial_counter,6}= respTime;
        testDataFile{trial_counter,7}= RT;
        testDataFile{trial_counter,8}= resp;
        testDataFile{trial_counter,9}= TestStims{iTrial,5,iBlock};
        testDataFile{trial_counter,10}= TestStims{iTrial,7,iBlock};
        testDataFile{trial_counter,11}= TestStims{iTrial,8,iBlock};
        testDataFile{trial_counter,12}= TestStims{iTrial,9,iBlock};
        
        save([subdir '/testDataFileSub' SubjStr 'Block' num2str(iBlock) '.mat'],'testDataFile')
        
        
        %reset write out test data variables
        trialOnset = [];
        respTime = [];
        RT = [];
        keyCode = [];
        resp =[];
        
        cbal_counter = cbal_counter + 1;
        
        PTBDisplayText('+',{'center'},{FixDur});
        
        if iTrial==11
            orderblock = {'Order Memory Test.'};
            PTBDisplayParagraph(orderblock,{'center',30},{3});
        end
        
        
    end % iTrial
    
    
    endblock = {'You have reached the end of block ' num2str(iBlock) ' of 16.', 'Press any key to continue.'};
    PTBDisplayParagraph(endblock,{'center',30},{'any'});
    
    %Feedback!!!
    
    sourcetest = [];
    ordertest = [];
    
    load([basedir '/Data/' SubjStr '/testDataFileSub' SubjStr 'Block' num2str(iBlock)]);
    sourcetest = [testDataFile(2:12,:)];
    ordertest = [testDataFile(13:end,:)];
    sourceAcc = zeros(11,1);
    orderAcc = zeros(11,1);
    
    for iaccuracy = 1:size(sourcetest,1)
        
        if (sourcetest{iaccuracy,12}==0&&(strcmp(sourcetest{iaccuracy,8},'1!')||strcmp(sourcetest{iaccuracy,8},'2@')))||(sourcetest{iaccuracy,12}==1&&(strcmp(sourcetest{iaccuracy,8},'3#')||strcmp(sourcetest{iaccuracy,8},'4$')))
            
            sourceAcc(iaccuracy) = 1;
            
        end
        
    end
    
    for iaccuracy = 1:size(ordertest,1)
        
        if (ordertest{iaccuracy,12}==0&&(strcmp(ordertest{iaccuracy,8},'1!')||strcmp(ordertest{iaccuracy,8},'2@')))||(ordertest{iaccuracy,12}==1&&(strcmp(ordertest{iaccuracy,8},'3#')||strcmp(ordertest{iaccuracy,8},'4$')))
            
            orderAcc(iaccuracy) = 1;
            
        end
        
    end
    %
    %
    %
    %
    %
    %
    %
    %
    %
    %
    %
    endblock = {'Your color memory accuracy was' num2str(mean(sourceAcc)*100) '%.','Your order memory accuracy was' num2str(mean(orderAcc)*100) '%.'};
    PTBDisplayParagraph(endblock,{'center',30},{'any'});
    
    endblock = {'Your color memory accuracy was' num2str(mean(sourceAcc)*100) '%.','Your order memory accuracy was' num2str(mean(orderAcc)*100) '%.'};
    PTBDisplayParagraph(endblock,{'center',30},{'any'});
    
    %sendmail('andrew.heusser@gmail.com','performance',{num2str(ON_Acc),num2str(TO_Acc)})
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Eyelink file
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if use_eyetracker
        
        % retrieve the file
        PTBDisplayText('Saving Data...', {'center', center}, {.1});
        PTBStopEyeTrackerRecording; % <----------- (can take a while)
        
        % move the file to the logs directory
        %destination = ['logs'];
        %movefile([subject, '_' num2str(iBlock), '.edf'], [destination filesep subject, '.edf'])
    end
    
    
    % finish up
    PTBDisplayText('The end.  Press any key to go to next run.',{'center'},{'any'});
    PTBDisplayBlank({.1},'Final Screen');
    
    PTBCleanupExperiment;
    fclose('all');
    sca; ShowCursor;
    cd ../
    
catch %#ok<CTCH>
    
    cd ../
    PTBHandleError;
    
end

