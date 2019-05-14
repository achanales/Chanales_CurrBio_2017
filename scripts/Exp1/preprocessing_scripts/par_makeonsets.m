function par_makeonsets( subpar )
%moveonsets directs to the behavioral data file on your computer and runs
%the onsetMaker function for the given subject


origdir = pwd;


% ---load par params if need be---
if isstruct(subpar) % if it is par_params struct
    par = subpar;
else % assume subject string
    par = par_params(subpar);
end

raw_func_dir = fullfile(par.rawdir,par.substr,'func');

if par.modelnum == 1 %route study

    display('Creating onsets for behavioral model 1 (routes)')

    
    A =dir(fullfile(raw_func_dir,'*run*_events.tsv') );

    names = cell(4,1);
    onsets = cell(4,1);
    for run = 1:numel(A)

        %Load event tsv for each run
        aa = tdfread(fullfile(raw_func_dir,A(run).name));

        %Get index of study trials
        st = ismember(aa.trial_type,'study_trial');
        st = st(:,1);

        conditions = unique(aa.route_number);

        for route = 1:length(conditions)
            routenum = conditions(route);
            %onsets
            rows = aa.route_number == routenum & st == 1; %find the rows that correspond the route # but only trials that are NOT test trials
            raw_onsets = aa.onset(rows);

            %adjust onset for each run 
            nulltime = 9;
            runtime = 285 - nulltime;
            adjusted_onset = raw_onsets - nulltime + (runtime*(run-1));
            onsets{route} = [onsets{route}; adjusted_onset(:)];

        end


    end

    for route = 1:length(conditions)
       %names
        routenum = conditions(route);
        names(route) = {['Route' num2str(routenum)]}; %route number

       %durations
       durations{route}(1:length(onsets{route})) = 24; %duration of trial
    end

elseif par.modelnum == 2 %localizer
     %Load event tsv for localizer
     A =dir(fullfile(raw_func_dir,'*localizer_events.tsv') );
     aa = tdfread(fullfile(raw_func_dir,A(1).name));
     
     conditions = {'face','scene','object'};
     
     names = cell(3,1);
     onsets = cell(3,1);
     durations = cell(3,1);

     for cond = 1:length(conditions)
         names(cond) = conditions(cond);
         
         %find rows corresponding to condition
         ct = ismember(aa.image_category,conditions(cond));
         ct = ct(:,1);
         
         %onsets
         raw_onsets = aa.onset(ct);
         adjusted_onsets = raw_onsets-9; %subtract 9 seconds from each onset to adjust for the 6 trs that are discarded 
         onsets{cond} = adjusted_onsets;
         
         %durations
         durations{cond} = aa.duration(ct);
         
     end

    
end
onsetdir = fullfile(par.subdir,['behavioral_model' num2str(par.modelnum)]);
if ~exist(onsetdir,'dir')
    mkdir(onsetdir)
else
    display('Behavioral model directory already exists')
end

if ~exist(fullfile(onsetdir,'onsets.mat'),'file')
    display('Saving onsets')
    save(fullfile(onsetdir,'onsets.mat'), 'onsets', 'names', 'durations');
else
    display('Onsets file already exists')
end
    

end

