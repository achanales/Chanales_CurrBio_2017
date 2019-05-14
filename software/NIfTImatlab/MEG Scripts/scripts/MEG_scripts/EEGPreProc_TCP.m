%%%%% User defined inputs %%%%%
raw_dir = '/data/laurakelly/backup_laptop_19.8.10/TCP_EEG/whole_epoch/s15_whole_epoch/';
subjects = [215];
preprocdir = '/data/aheusser/TCP/EEG/preproc/';
addpath(genpath('/data/aheusser/eeglab6.01b/'));
downsamp_path = '/data/aheusser/TCP/EEG/preproc/215/';
downsamp_fname = 'Subj215_512hz_merge.set';

for s = subjects

    cd(preprocdir)
    mkdir(['Subj',num2str(s)])
    cd(['Subj',num2str(s)])



    %load BDF file in sections
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

    %%  Load in the event timinig channel, determine length of entire file,
    %%  calculate midpoints for splitting the file, and excise bad marker info
    raw_file = [raw_dir,'TCP_',num2str(s),'.bdf'];
    
    %%% Load a limited set to determine the number of channels AJW 1-28-09
    EEG = pop_biosig(raw_file,'channels',[], 'blockrange',[0 5],'ref',[],'rmeventchan','off');
    numchans = EEG.nbchan;
    clear EEG
    
    EEG = pop_biosig(raw_file,'channels',[numchans], 'blockrange',[],'ref',[],'rmeventchan','off');

    first = (EEG.xmax)/4;
    midpoint = (EEG.xmax)/2;
    third = (EEG.xmax*3)/4;
    endpoint = EEG.xmax;

    clear EEG



    eeglab redraw
    for n =1:4
        if n ==1
            EEG = pop_biosig(raw_file,'channels',[1:72],'blockrange',[1 first],'ref',[65 66],'rmeventchan','off');
            tmp = [EEG.event.type];
            idx = find(tmp > 250);

            %%  Void bad events
            EEG.event(idx) = [];

            %  Downsample to 512Hz
            EEG=pop_resample( EEG, 512);

            %%  Save the first half of the dataset as a remarked, down sampled file
            savepath =[preprocdir,'Subj',num2str(s),'/'];
            fname1 = ['Subj',num2str(s),'_512hz_1.set'];
            EEG = pop_saveset( EEG,  'filename', fname1, 'filepath',savepath );

            ALLEEG = pop_delset( ALLEEG, [1] );
        end


        if n ==2
            EEG = pop_biosig(raw_file,'channels',[1:72],'blockrange',[first midpoint],'ref',[65 66],'rmeventchan','off');
            tmp = [EEG.event.type];
            idx = find(tmp > 250);

            %%  Void bad events
            EEG.event(idx) = [];

            %% Downsample to 512 Hz
            EEG= pop_resample( EEG, 512);

            %%  Save the second half of the dataset as a remarked, down sampled file
            savepath =[preprocdir,'Subj',num2str(s),'/'];
            fname2 = ['Subj',num2str(s),'_512hz_2.set'];
            EEG = pop_saveset( EEG,  'filename', fname2, 'filepath', savepath);

            ALLEEG = pop_delset( ALLEEG, [1] );
        end
        
        if n ==3
            EEG = pop_biosig(raw_file,'channels',[1:72],'blockrange',[midpoint third],'ref',[65 66],'rmeventchan','off');
            tmp = [EEG.event.type];
            idx = find(tmp > 250);

            %%  Void bad events
            EEG.event(idx) = [];

            %% Downsample to 512 Hz
            EEG= pop_resample( EEG, 512);

            %%  Save the second half of the dataset as a remarked, down sampled file
            savepath =[preprocdir,'Subj',num2str(s),'/'];
            fname3 = ['Subj',num2str(s),'_512hz_3.set'];
            EEG = pop_saveset( EEG,  'filename', fname3, 'filepath', savepath);

            ALLEEG = pop_delset( ALLEEG, [1] );
         end
                
         if n ==4
            EEG = pop_biosig(raw_file,'channels',[1:72],'blockrange',[third endpoint],'ref',[65 66],'rmeventchan','off');
            tmp = [EEG.event.type];
            idx = find(tmp > 250);

            %%  Void bad events
            EEG.event(idx) = [];

            %% Downsample to 512 Hz
            EEG= pop_resample( EEG, 512);

            %%  Save the second half of the dataset as a remarked, down sampled file
            savepath =[preprocdir,'Subj',num2str(s),'/'];
            fname4 = ['Subj',num2str(s),'_512hz_4.set'];
            EEG = pop_saveset( EEG,  'filename', fname4, 'filepath', savepath);

            ALLEEG = pop_delset( ALLEEG, [1] );
            
            clear EEG
         end
    end

    %%%  Load the 2 downsampled files, concatenate them, save as merged file
    EEG = pop_loadset( 'filename', fname1, 'filepath', savepath);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );


    EEG = pop_loadset( 'filename', fname2, 'filepath', savepath);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    
    EEG = pop_loadset( 'filename', fname3, 'filepath', savepath);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    
    EEG = pop_loadset( 'filename', fname4, 'filepath', savepath);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );


    EEG = pop_mergeset( ALLEEG, [1 2 3 4], 0);

    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2, 'setname', ['Subj',num2str(s),'_512hz_merge.set'] ,'savenew',['Subj',num2str(s),'_512hz_merge_recoded_filtered'] );
    ALLEEG = pop_delset( ALLEEG, [1 2 3 4] );

    EEG = pop_loadset( 'filename', ['Subj',num2str(s),'_512hz_merge.set'], 'filepath', '/data/aheusser/TCP/EEG/preproc/Subj',num2str(s),'/');
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    
    %Replace 'boundary' with 999
    for iboundary= 1:length(EEG.event)
        if strcmp(EEG.event(iboundary).type,'boundary') == 1;
            EEG.event(iboundary).type = '999';
        end
    end
    
    %Replace all events that are strings with numbers
    for istr2num = 1:length(EEG.event)
        EEG.event(istr2num).type = str2num(EEG.event(istr2num).type);
    end
    


    %Get rid of any boundaries
    tmp = [EEG.event.type];
    idx = find(tmp > 350);
    EEG.event(idx) = [];
    
    %Create a vector of stim
    stim_v = [EEG.event.type];
    
    %Creates a logical array of test events
    temp1_stim_v = stim_v > 199 & stim_v < 250;
    
    %Replaces code of test events so its unique from p/n judgements
    
    test_idx = 0;
    for i = 1:length(temp1_stim_v)
        if temp1_stim_v(i) == 1;
           test_idx = test_idx + 1;
        end
        
        if test_idx == 2;
            EEG.event(i).type = EEG.event(i).type + 100;
            test_idx = 0;
        end  
    
    end
    
    
    for i = 1:length(stim_v)
        if EEG.event(i).type == 199
            EEG.event(i).type = 50;
        end
        
        if EEG.event(i).type == 250
            EEG.event(i).type = 51;
        end
    end
    
    
    
    
    %%%  Re-code event markers so that 61-63 have appropriate ratings following
    %%%  them

    % Build index of stimuli presentation events (non-rating events)
    idx = [];
    k=[];
    for n = 1:length(EEG.event);

        k = EEG.event(n).type;
        if k > 51
            idx = [idx ; n];
        end

    end

    %%%%  rewrite stimuli presentation event markers


    for n = 1:length(idx)  %loop through only stimuli events
        r = idx(n);
        
        if EEG.event(r).type == 201 %&& (EEG.event(r+1).type == 1 || EEG.event(r+1) == 2) ;
        EEG.event(r).type = strcat(num2str(EEG.event(r).type),num2str(EEG.event(r+3).type));
        end
        
        if EEG.event(r).type == 221 %&& (EEG.event(r+1).type == 1 || EEG.event(r+1) == 2) ;
        EEG.event(r).type = strcat(num2str(EEG.event(r).type),num2str(EEG.event(r+3).type));
        end
        
        if EEG.event(r).type == 222 %&& (EEG.event(r+1).type == 1 || EEG.event(r+1) == 2);
        EEG.event(r).type = strcat(num2str(EEG.event(r).type),num2str(EEG.event(r+3).type));
        end
        
        if EEG.event(r).type == 203 %&& (EEG.event(r+1).type == 1 || EEG.event(r+1) == 2);
        EEG.event(r).type = strcat(num2str(EEG.event(r).type),num2str(EEG.event(r+3).type));
        end

    end
    
    
        for n = 1:length(idx)  %loop through only stimuli events
        r = idx(n);
        
        if EEG.event(r).type == 301 %&& (EEG.event(r+1).type == 1 || EEG.event(r+1) == 2) ;
        EEG.event(r).type = strcat(num2str(EEG.event(r).type),num2str(EEG.event(r+1).type));
        end
        
        if EEG.event(r).type == 321 %&& (EEG.event(r+1).type == 1 || EEG.event(r+1) == 2) ;
        EEG.event(r).type = strcat(num2str(EEG.event(r).type),num2str(EEG.event(r+1).type));
        end
        
        if EEG.event(r).type == 322 %&& (EEG.event(r+1).type == 1 || EEG.event(r+1) == 2);
        EEG.event(r).type = strcat(num2str(EEG.event(r).type),num2str(EEG.event(r+1).type));
        end
        
        if EEG.event(r).type == 303 %&& (EEG.event(r+1).type == 1 || EEG.event(r+1) == 2);
        EEG.event(r).type = strcat(num2str(EEG.event(r).type),num2str(EEG.event(r+1).type));
        end

        end
    
        
        
    
    
    for istr2num = 1:length(EEG.event)
        if ischar(EEG.event(istr2num).type)==1
        EEG.event(istr2num).type = str2num(EEG.event(istr2num).type);
        end
    end
    
    


    % load electrode locations
    EEG.chanlocs=readlocs('/data/aheusser/TCP/EEG/bioSemi64.ced');

    % reject the bad channels  -figure out which channels are bad
    %EEG = pop_select( EEG, 'nochannel', bad_elecs{s,2} );
    % EEG = pop_select( EEG, 'nochannel', [129 130 131 132] );

    % GFP  -  Appears unncessary because importing bdf files and including ref
    % information appears to re-ref the data to your ref channels automatically
    %EEG = pop_reref( EEG, [33 34]);

    
    % % high-pass filter at 0.5 Hz  Added 11-10-08 AJW
    EEG = pop_eegfilt( EEG, 0.5, 0, [], [0]);
    
    
    
    %%  Remove rating events
    EEG = pop_selectevent( EEG,'omittype',[1:5] , 'deleteevents', 'off', 'deleteepochs', 'on', 'invertepochs', 'off');
    
    %%%%%%%%%%%EEG = pop_epoch( EEG, {},[-.2 1.5], 'epochinfo', 'yes'); % {'21'  '11'},
    % epoch the continuous data.  Does not exclude any rating events,
    %EEG = pop_epoch( EEG, {},[-.5 2.0], 'epochinfo', 'yes'); % {'21'  '11'},
    
    !mkdir epochs epochs/PN epochs/PN/ERP epochs/PN/TF epochs/RKN epochs/RKN/PRE epochs/RKN/POST epochs/RKN/PRE/ERP epochs/RKN/PRE/TF epochs/RKN/POST/ERP epochs/RKN/POST/TF/

EEG = pop_loadset('filename',['Subj',num2str(s),'_512hz_merge_recoded_filtered.set'],'filepath','/data/aheusser/TCP/EEG/preproc/Subj',num2str(s),'/');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '2011'  '2012'  '2013'  '2031'  '2032'  '2033'  '2211'  '2212'  '2213'  '2221'  '2222'  '2223'  }, [-0.15         1.5], 'newname', 'PN_ERP_EPOCHS', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew','/data/aheusser/TCP/EEG/preproc/Subj204/epochs/PN/ERP/PN_ERP_EPOCHS.set','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-150.3906             0]);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '2011'  '2012'  '2013'  '2031'  '2032'  '2033'  '2211'  '2212'  '2213'  '2221'  '2222'  '2223'  }, [-0.3         1.8], 'newname', 'PN_ERP_TF_EPOCHS', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew','/data/aheusser/TCP/EEG/preproc/Subj',num2str(s),'/epochs/PN/TF/PN_ERP_TF.set','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-300.7812             0]);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '3011'  '3012'  '3013'  '3031'  '3032'  '3033'  '3211'  '3212'  '3213'  '3221'  '3222'  '3223'  }, [-1.5        0.15], 'newname', 'RKN_PRE_ERP_EPOCHS', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew','/data/aheusser/TCP/EEG/preproc/Subj',num2str(s),'/epochs/RKN/PRE/ERP/RKN_PRE_ERP_EPOCHS.set','gui','off'); 
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '3011'  '3012'  '3013'  '3031'  '3032'  '3033'  '3211'  '3212'  '3213'  '3221'  '3222'  '3223'  }, [-1.8         0.3], 'newname', 'RKN_PRE_TF_EPOCHS', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew','/data/aheusser/TCP/EEG/preproc/Subj',num2str(s),'/epochs/RKN/PRE/TF/RKN_PRE_TF_EPOCHS.set','gui','off'); 
EEG = eeg_checkset( EEG );
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 5,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '3011'  '3012'  '3013'  '3031'  '3032'  '3033'  '3211'  '3212'  '3213'  '3221'  '3222'  '3223'  }, [-0.15         1.5], 'newname', 'RKN_POST_ERP_EPOCHS', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew','/data/aheusser/TCP/EEG/preproc/Subj',num2str(s),'/epochs/RKN/POST/ERP/RKN_POST_ERP_EPOCHS.set','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-150.3906             0]);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 6,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  '3011'  '3012'  '3013'  '3031'  '3032'  '3033'  '3211'  '3212'  '3213'  '3221'  '3222'  '3223'  }, [-0.3         1.8], 'newname', 'RKN_POST_TF_EPOCHS', 'epochinfo', 'yes');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew','/data/aheusser/TCP/EEG/preproc/Subj',num2str(s),'/epochs/RKN/POST/TF/RKN_POST_TF_EPOCHS.set','gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-300.7812             0]);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    


    % baseline subtract
   % EEG = pop_rmbase( EEG, [-200 0]);
    eeglab redraw;

    
    

    %%  Remove the worst epochs which throw off ICA
%[EEG, locthresh, globthresh, nrej] = pop_jointprob(EEG,1,[1:EEG.nbchan] ,3,5,1,0,0);


% % %     %%% Very basic artifact rejection used pre-ICA preprocessing
% % %     try
% % %         total_trials = length(EEG.epoch);
% % %         EEG = pop_eegthresh(EEG,1,[1:38] ,-100,100,-1.25,2.4,2,0);
% % %         EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
% % %         EEG = pop_rejepoch( EEG, find(EEG.reject.rejglobal), 0);
% % %         [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3, 'setname', ['Subj',num2str(s),'_512hz_merge_AR.set'], 'savenew',['Subj',num2str(s),'_512hz_merge_AR'] , 'overwrite', 'on');
% % %     catch
% % %     end




total_trials = length(EEG.epoch);
EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
EEG = pop_rejepoch( EEG, find(EEG.reject.rejglobal), 0);
%[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3, 'setname', ['Subj',num2str(s),'_512hz_merge_preICA.set'], 'savenew',['Subj',num2str(s),'_512hz_merge_preICA'] , 'overwrite', 'on');

%EEG = pop_runica(EEG, 'icatype', 'runica','extended',1,'pca',32);
EEG = pop_runica(EEG, 'icatype', 'runica','extended',1);


[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3, 'setname', ['Subj',num2str(s),'_512hz_merge_postICA_attempt2.set'], 'savenew',['Subj',num2str(s),'_512hz_merge_postICA'] , 'overwrite', 'on');


    rejected_trials{s,1} = s;
    rejected_trials{s,2} = total_trials - length(EEG.epoch);

    retained_trials{s,1} = s;
    retained_trials{s,2} = length(EEG.epoch);
    
    ALLEEG = pop_delset( ALLEEG, [1:2] );
end

cd(preprocdir)
save('rejection_info','rejected_trials','retained_trials');


%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%% end preproc



%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%

% ICA artifact rejection
% 103 104 106:123 199

preprocdir = '/data/aheusser/TCP/EEG/preproc/';

for s = 1
  

    cd(preprocdir)
    cd(['Subj',num2str(s)])
    path = cd;
    
    fname = ['Subj',num2str(s),'_512hz_merge_postICA.set'];
    EEG = pop_loadset( 'filename', fname, 'filepath', path);
    
    pop_eegplot( EEG, 1, 1, 1);
    pop_eegplot( EEG, 0, 1, 1);
    pop_selectcomps(EEG, [1:72] );
  
end

%%%  Create matrix of subject numbers and components to remove by hand




%%% Remove the bad components from every subject
for s = 1 %[103 104 106:123 199]
    
    cd(preprocdir)
    cd(['Subj',num2str(s)])
    path = cd;
    
    fname = ['Subj',num2str(s),'_512hz_merge_postICA.set'];
    EEG = pop_loadset( 'filename', fname, 'filepath', path);
    
    rejcomp = cell2mat(rejected_components(s,2));
    
    EEG = pop_subcomp( EEG, [rejcomp], 0);

fname_new = ['Subj',num2str(s),'_512hz_merge_blinksub_AWreject.set'];
EEG = pop_saveset( EEG, 'filename', fname_new,'filepath',cd);

clear EEG rejcomp
end


%%% Remove bad trials by hand, a subject at a time AJW 2-2-09
preprocdir = '/data/watrous/FnR_EEG/Preproc_11_3_09/';

%% to do
% 103 104 106:123 199
ALLEEG = struct;
eeglab 


for s = [119]
    
    cd(preprocdir)
    cd(['Subj',num2str(s)])
    path = cd;
    
    file = ['Subj',num2str(s),'_512hz_merge_blinksub_AWreject.set'];
    EEG = pop_loadset( file);
    pop_eegplot( EEG, 1, 1, 1);
    fname_new = ['Subj',num2str(s),'_512hz_merge_blinksub_AW_reject_handAR.set'];
end
% 
% for s = [120]
%      
%     cd(preprocdir)
%     cd(['Subj',num2str(s)])
%     path = cd;
%      
%     file = ['Subj',num2str(s),'_512hz_merge_postICA.set'];
%     EEG = pop_loadset( file);
%     pop_eegplot( EEG, 1, 1, 1);
%    fname_new = ['Subj',num2str(s),'_512hz_merge_noICA_handAR.set'];
% end


%%%%
%%%%%
%%%%
EEG = pop_saveset( EEG, 'filename', fname_new,'filepath',path);
% ALLEEG = struct;
