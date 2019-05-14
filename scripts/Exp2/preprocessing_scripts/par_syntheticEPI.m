function par_syntheticEPI(subpar)
% function par_syntheticEPI(subpar)
% creates a synthetic EPI
% 

origdir = pwd;
% ---load par params if need be---

if isstruct(subpar) % if it is par_params struct
    par = subpar;
else % assume subject string
    par = par_params(subpar);
end

fprintf('---Creating Synthetic EPI for %s---\n',par.substr);
cd(par.anatdir);
calrho = par.calrho; 
calbo = par.calbo;
calrs = par.calrs;
convertedTE = par.convertedTE; 
readoutdir = par.readoutdir; 
synthEPIname = par.synthEPIname; 
cbiCalibSynthEPI(calrho, calbo, calrs, convertedTE, readoutdir, synthEPIname)
cd(origdir);
fprintf('---Syntethic EPI CREATED for %s---\n',par.substr);