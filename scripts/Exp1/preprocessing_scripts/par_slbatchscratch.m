function par_slbatchscratch
% function par_slbatchscratch
%
% scratchpad for running various second-level analyses... further
% fanciness/robustness to come
%
%jbh 8/11/08


origdir = pwd;

CN = 0; % This is the counter for the analyses you want to run (only cowards
% run a single analysis at once (although you have this option))

fmridir = '/spungen/home/jbhutchi/data/parmap/fmri_data';
grpdir =  fullfile(fmridir, 'group_data');
%set up to write out model directories within this specified group
%directory...



%------------------ Analysis specific info----------------------
% Specify parameters here (hard-coded, as will be experiment specific
% anyway...).  You can just copy paste what's between the dashed lines for
% each analysis you want to run
%
CN = CN +1; % count up...
modname{CN} = 'fullpart'; % name of model
namey{CN} = 'allsubs'; %name of analysis (e.g. allsubjects)
excsub{CN} = {};  % exlude any subjects?
repsub{CN} = fullfile(fmridir, 's01','results'); %filepath to where a
%representative SPM.mat lives for getting contrast info
conin = [1:6, 11, 31:34, 41:43, 64:69];
[condinfo(CN).connames condinfo(CN).connums] = par_getslconinfo(repsub{CN}, conin);
% generate both con names and numbers given one or the other
%--------------------------------------------------------------------

%------------------ Analysis specific info----------------------
% Specify parameters here (hard-coded, as will be experiment specific
% anyway...).  You can just copy paste what's between the dashed lines for
% each analysis you want to run
%
CN = CN +1; % count up...
modname{CN} = 'fullpart'; % name of model
namey{CN} = 'no14'; %name of analysis (e.g. allsubjects)
excsub{CN} = {'s14'};  % exlude any subjects?
repsub{CN} = fullfile(fmridir, 's01','results'); %filepath to where a
%representative SPM.mat lives for getting contrast info
conin = [1:6, 11, 31:34, 41:43, 64:69];
[condinfo(CN).connames condinfo(CN).connums] = par_getslconinfo(repsub{CN}, conin);
% generate both con names and numbers given one or the other
%--------------------------------------------------------------------



%------------------ Analysis specific info----------------------
% Specify parameters here (hard-coded, as will be experiment specific
% anyway...).  You can just copy paste what's between the dashed lines for
% each analysis you want to run
%
CN = CN +1; % count up...
modname{CN} = 'fullpart'; % name of model
namey{CN} = 'nofull'; %name of analysis (e.g. allsubjects)
excsub{CN} = {'s01','s09','s12','s14','s16', 's17','s21','s23','s25'};  % exlude any subjects?
repsub{CN} = fullfile(fmridir, 's02','results'); %filepath to where a
%representative SPM.mat lives for getting contrast info
conin = [1:6, 11, 31:34, 41:43, 64:69];
[condinfo(CN).connames condinfo(CN).connums] = par_getslconinfo(repsub{CN}, conin);
% generate both con names and numbers given one or the other
%--------------------------------------------------------------------



%------------------ Analysis specific info----------------------
% Specify parameters here (hard-coded, as will be experiment specific
% anyway...).  You can just copy paste what's between the dashed lines for
% each analysis you want to run
%
CN = CN +1; % count up...
modname{CN} = 'fullpart'; % name of model
namey{CN} = 'nopart'; %name of analysis (e.g. allsubjects)
excsub{CN} = {'s01','s04','s12','s15','s16', 's18','s21','s22'};  % exlude any subjects?
repsub{CN} = fullfile(fmridir, 's02','results'); %filepath to where a
%representative SPM.mat lives for getting contrast info
conin = [1:6, 11, 31:34, 41:43, 64:69];
[condinfo(CN).connames condinfo(CN).connums] = par_getslconinfo(repsub{CN}, conin);
% generate both con names and numbers given one or the other
%--------------------------------------------------------------------



% crunch the requested analyses
for nn = 1:CN
    condir = fullfile(grpdir, modname{nn});
    if ~exist(condir,'dir'); mkdir(condir); end
    par_slscratch(condir, condinfo(nn),excsub{nn},namey{nn})
end





cd(origdir);