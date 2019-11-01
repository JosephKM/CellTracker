function [ output_args ] = mkMaxIntensities( direc,extension,outputDirec )
% Makes Max Intensity Projections for all files in a directory  which have
% a given file extension. Output files will be .tiff under
% direc/MaxIntensities
%
%   

% example:
%   mkMaxIntensities(experiment,'.tif') results in a new 

mkdir(outputDirec);

imglist = dir(fullfile(direc, ['*' extension]));
parfor ii = 1:length(imglist)
    file = [direc filesep imglist(ii).name];
    [~,name,~] = fileparts(file);
mkMaxIntensity(file,[outputDirec filesep 'MAX' name '.tif'])
disp(['MaxIntensity' filesep 'MAX' imglist(ii).name ' complete']);
 end
disp('All Projections complete');




end

