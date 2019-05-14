function [connames connums] = par_getslconinfo(repsub, conin)
% function par_getslconinfo(repsub)
%
% Takes in either a vector of contrast numbers or contrast names and fills
% out the other...
%
% jbh 8/11/08


%load in spm
fprintf(['\nUsing ' repsub filesep 'SPM.mat\n'])
load(fullfile(repsub,'SPM.mat'));

%convert cons into standardized naming
allconnames = lower(strrep({SPM.xCon.name}, ' > ', '_'));

if isa(conin, 'numeric') %vector of contrast numbers
    for Nn = 1:length(conin)
       connames{Nn} = allconnames{conin(Nn)}; 
       connums{Nn} = prepend(num2str(conin(Nn)));
    end
elseif isa(conin, 'cell') % contrast names
    connames = conin;
    for Cc = 1:length(conin)
        connums{Cc} = prepend(num2str(find(strcmp(conin{Cc},allconnames))));
    end
end

