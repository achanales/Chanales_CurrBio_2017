function par_slcons(spmdir,contrastname)
% par_slcons(spmdir)
% Sets contrasts.
% 
% subpar refers to either the subject number (in string notation) or
% the par struct generated by par = par_params(subject)
% 
% made from av_setContrasts  1/28/08 jbh
% modified to subpar format, etc, 7/24/08 jbh



origdir = pwd;

% 
% % ---load par params if need be---
% if isstruct(subpar) % if it is par_params struct
%     par = subpar;
% else % assume subject string
%     par = par_params(subpar);
% end

STAT = 'T';

cd(spmdir);
fprintf('\nLoading SPM...');
load SPM
fprintf('Done');
Xsize = size(SPM.xX.xKXs.X,2);
con_vals{1} = ones([1 Xsize]);
con_vals{1}(1) = 1;
con_name{1} = contrastname;


%-------------------------------------------------------------------
for k=1:length(con_vals)

    % Basic checking of contrast
    %-------------------------------------------------------------------
    [c,I,emsg,imsg] = spm_conman('ParseCon',con_vals{k},SPM.xX.xKXs,STAT);
    if ~isempty(emsg)
        disp(emsg);
        error('Error in contrast specification');
    else
        disp(imsg);
    end;

    % Fill-in the contrast structure
    %-------------------------------------------------------------------
    if all(I)
        DxCon = spm_FcUtil('Set',con_name{k},STAT,'c',c,SPM.xX.xKXs);
    else
        DxCon = [];
    end

    % Append to SPM.xCon. SPM will automatically save any contrasts that
    % evaluate successfully.
    %-------------------------------------------------------------------
    if isempty(SPM.xCon)
        SPM.xCon = DxCon;
    elseif ~isempty(DxCon)
        SPM.xCon(end+1) = DxCon;
    end
    SPM = spm_contrasts(SPM,length(SPM.xCon));
        
end


% Change back directory
cd(origdir);



