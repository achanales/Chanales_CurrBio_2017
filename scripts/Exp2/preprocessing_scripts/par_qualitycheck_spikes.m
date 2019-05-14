function par_qualitycheck_spikes(par)

%Go to subject's raw folder
cd(par.rawdir)

%Read config file
[foldername type] = textread('config.txt','%s%s');
funcfiles = foldername(3:end);

%make roitxt Directory if it does not exist
roitxtDir = [par.rawdir '/roitexts'];
if ~exist(roitxtDir,'dir')
    mkdir(roitxtDir)
end

%% First create ROIs and check to make sure they are ok
cd(funcfiles{1})
%get functional file name
a = dir('*.nii'); %find the file that ends in .nii
name = a.name;
%name the roi file
roiname = [roitxtDir '/' par.substr '_rois.txt'];
%run cbi roi making script
roiCorners(name,roiname);
cd(par.rawdir)

    for func = 1:length(funcfiles)
        cd(funcfiles{func})
        fprintf('---Spike Check for Run %d---\n',func);

        %get functional file name
        a = dir('*.nii'); %find the file that ends in .nii
        name = a.name;

        dataQReport(name,roiname,par.dropvol);

        cd(par.rawdir)

    end

end