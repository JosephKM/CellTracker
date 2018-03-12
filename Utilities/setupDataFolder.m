function [ ] = setupDataFolder( path,maxI )
%setupDataFolder will setup folders inside a directory.
%   

%%  move image files to 'raw images' directory
if isempty(dir([path filesep 'raw data' filesep '*tif']))
movefile([cd filesep '*tif'],'raw data')
end
%% make max intensity projections
if maxI ==1
if isempty(dir([path filesep 'MaxIntensity' filesep '*tif']))
    mkdir('MaxIntensity')
mkMaxIntensities([path filesep 'raw data'],'tif','MaxIntensity');
end
end
if maxI ==4
if isempty(dir([path filesep 'MaxIntensity' filesep '*tif']))
    mkdir('MaxIntensity')
mkMaxIntensities4chan([path filesep 'raw data'],'tif','MaxIntensity');
end
end
mkdir([path filesep 'figures']);
mkdir([path filesep 'Outfiles_nuc_cyto']);
mkdir([path filesep 'Outfiles_membrane']);
mkdir([path filesep 'OutfileBackups']);
mkdir('scripts&paramfiles');
