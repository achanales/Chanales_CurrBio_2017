function [] = MEGBound_MEG_Practice(SubjectNumber)
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

debugmode = 0;
BlankScreenDur = .25;
RestDur = Inf;
StimDur = 2.5;
ITI = 1.0;
FixDur = 1.5;
TestDur = 'any';
TestLoop = 1;


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
PTBSetIsDebugging(0);

% set some defaults
PTBSetExitKey('ESCAPE');
PTBSetBackgroundColor([128 128 128]);
PTBSetTextColor([255 255 255]);		% This defaults to white = (255, 255, 255).
PTBSetTextFont('Arial');		% This defaults to Courier.
PTBSetTextSize(30);				   % This defaults to 30.


% set output file stuff
PTBSetLogFiles(['S' SubjStr '_practive_log_file.txt'], ['S' SubjStr '_practice_data_file.txt']);
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


try
    % start experiment
    PTBSetupExperiment('MEGBound_practice');
    %PTBInitStimTracker;
    %collection_type = 'Char';
    %PTBSetInputCollection(collection_type);
    
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
    %     rgbcolor = cell2mat([encodingSeq(:,5,iBlock) encodingSeq(:,6,iBlock) encodingSeq(:,7,iBlock)]);
    %     itemfile = encodingSeq(:,1,iBlock);
    %     boundtype = encodingSeq(:,2,iBlock);
    %     withinEventPos = cell2mat(encodingSeq(:,3,iBlock));
    %     encodingColor = cell2mat(encodingSeq(:,4,iBlock));
    practicefile = {'667.bmp'; '668.bmp'; '669.bmp'; '670.bmp'; '671.bmp'; '672.bmp'};
     
    %PTBDisplayText('+',{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]},{FixDur});
    
    instr = {'Welcome to the Memory Experiment!', 'In this task, you will view a series of objects embedded on a color background.','For each trial, please visualize the object in the color background and decide whether the', 'object/color background combination is pleasing to you. Then, you will be tested','on your memory for the object/color combinations as well as the','order in which the objects were presented. Press any key to go on.'};
    PTBDisplayParagraph(instr,{'center',30},{'any'});
    PTBDisplayBlank({.3},'Blank');
    
    instr = {'In this practice experiment, you will see 6 objects, one at a time.',' For each object, please indicate whether the object/color combination',' is pleasing to you. Try to remember the color of the background for each object,','as well as the order of the objects because you will be tested after this study period.','In this practice, you will have as much time as you need to make your decision.','Press any key to give it a try.'};
    PTBDisplayParagraph(instr,{'center',30},{'any'});
    PTBDisplayBlank({2},'Blank');
    
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
    PTBDisplayPictures(practicefile(1), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
    
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
    PTBDisplayPictures(practicefile(2), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
    
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
    PTBDisplayPictures(practicefile(3), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
    
    currcolorbox = cat(3,ones(colorboxSize1,colorboxSize2).*colorsamples_RGB(13,1), ...
        ones(colorboxSize1,colorboxSize2).*colorsamples_RGB(13,2), ...
        ones(colorboxSize1,colorboxSize2).*colorsamples_RGB(13,3));
    
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
    PTBDisplayPictures(practicefile(4), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
    
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
    PTBDisplayPictures(practicefile(5), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
    
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice')
    PTBDisplayPictures(practicefile(6), {[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1}, {'any'},'practice');
    PTBDisplayMatrices({currcolorbox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.33]}, {1.5},'practice')
    
    %Practice Test
%     corr_colorbox = cat(3,ones(350,350).*colorsamples_RGB(1,1), ...
%         ones(350,350).*colorsamples_RGB(1,2), ...
%         ones(350,350).*colorsamples_RGB(1,3));
%     
%     lure_colorbox = cat(3,ones(350,350).*colorsamples_RGB(13,1), ...
%         ones(350,350).*colorsamples_RGB(13,2), ...
%         ones(350,350).*colorsamples_RGB(13,3));

    colorBoxSize = 250;

    corr_colorbox = cat(3,ones(colorBoxSize,colorBoxSize).*colorsamples_RGB(1,1), ...
        ones(colorBoxSize,colorBoxSize).*colorsamples_RGB(1,2), ...
        ones(colorBoxSize,colorBoxSize).*colorsamples_RGB(1,3));
    
    lure_colorbox = cat(3,ones(colorBoxSize,colorBoxSize).*colorsamples_RGB(13,1), ...
        ones(colorBoxSize,colorBoxSize).*colorsamples_RGB(13,2), ...
        ones(colorBoxSize,colorBoxSize).*colorsamples_RGB(13,3));
    
    instr = {'Now, let''s try the practice test.','First, please indicate the color of the border that the item was studied with.', 'An item will appear on the screen with two different colors below it.','One of these two colors is the correct color that the item was studied with.','Please press the H key if you are sure it was the color on the left.','Please press the J key if you think it was the color on the left, but not sure.','Please press the L key if you are sure it was the color on the right.','Please press the K key if you think it was the color on the left, but not sure.','Press any key to start the practice color memory test.'};
    PTBDisplayParagraph(instr,{'center',30},{'any'});
    PTBDisplayBlank({2},'Blank');
    
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]},{-1},'practice');
    PTBDisplayMatrices({corr_colorbox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.75]},{-1},'practice');
    PTBDisplayMatrices({lure_colorbox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.75]}, {-1},'practice');
    
    PTBDisplayText('H - LEFT SURE     J - LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.95]},{-1});
    PTBDisplayText('K - RIGHT UNSURE     L - RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.95]},{-1});
    PTBDisplayPictures(practicefile(2),{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]}, {1}, {'any'},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]},{1.5},'practice');
    
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]},{-1},'practice');
    PTBDisplayMatrices({lure_colorbox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.75]},{-1},'practice');
    PTBDisplayMatrices({corr_colorbox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.75]}, {-1},'practice');
    
    PTBDisplayText('H - LEFT SURE     J - LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.95]},{-1});
    PTBDisplayText('K - RIGHT UNSURE     L - RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.95]},{-1});
    PTBDisplayPictures(practicefile(5),{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]}, {1}, {'any'},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.5 PTBScreenRes.height*.25]},{1.5},'practice');
    
    instr = {'Now, you''ll try the practice item order test.','Which item appeared first?','Please press the H key if you are sure it was the object on the left.','Please press the J key if you think it was the object on the left, but not sure.','Please press the L key if you are sure it was the object on the right.','Please press the K key if you think it was the object on the left, but not sure.','Press any key to start the practice item order test.'};
    PTBDisplayParagraph(instr,{'center',30},{'any'});
    PTBDisplayBlank({2},'Blank');
    
    PTBDisplayText('H - LEFT SURE     J - LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.7]},{-1});
    PTBDisplayText('K - RIGHT UNSURE     L - RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.7]},{-1});
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]},{-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]},{-1},'practice');
    PTBDisplayPictures(practicefile(1),{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]}, {1}, {-1},'practice');
    PTBDisplayPictures(practicefile(3),{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]}, {1}, {'any'},'practice')
    PTBDisplayBlank({2},'Blank');
    
    PTBDisplayText('H - LEFT SURE     J - LEFT UNSURE',{[PTBScreenRes.width*.05 PTBScreenRes.height*.7]},{-1});
    PTBDisplayText('K - RIGHT UNSURE     L - RIGHT SURE',{[PTBScreenRes.width*.55 PTBScreenRes.height*.7]},{-1});
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]},{-1},'practice');
    PTBDisplayMatrices({whitebox},{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]},{-1},'practice');
    PTBDisplayPictures(practicefile(6),{[PTBScreenRes.width*.25 PTBScreenRes.height*.5]}, {1}, {-1},'practice');
    PTBDisplayPictures(practicefile(4),{[PTBScreenRes.width*.75 PTBScreenRes.height*.5]}, {1}, {'any'},'practice')
    PTBDisplayBlank({2},'Blank');
    
    instr = {'Any questions?  If so, please ask your experimenter at this time.','If not, please notify your experimenter that you understand the task and are ready to start!'};
    PTBDisplayParagraph(instr,{'center',30},{'any'});
    PTBDisplayBlank({2},'Blank');
    
    
    PTBDisplayBlank({.1},'Final Screen');
    
    PTBCleanupExperiment;
    fclose('all');
    sca; ShowCursor;
    cd ../
    
catch %#ok<CTCH>
    
    cd ../
    PTBHandleError;
    
end

