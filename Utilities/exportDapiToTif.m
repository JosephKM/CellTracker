%% I usually run this script inside the direc where olympus files (.oib or .oif) are stored in order to
%  obtain the DAPI channel as tifs for inport into Ilastik. As written,
%  this script assumes that the DAPI channel is the first channel, and that
%  there are no Z slices within the file.

%  by JKM

filePath = cd; %direc where raw files are stored
saveInPath = [filePath filesep 'DAPI']; %new folder where multi-tiff images for each position are saved.
mkdir(saveInPath);

files = dir(filePath);
dirFlags = ~[files.isdir];
files = files(dirFlags);
for iFiles = 1:length(files);
    filereader = bfopen(files(iFiles).name);
    [path nameToSave ext] = fileparts(files(iFiles).name);
    imgToSave = filereader{1,1}{1,1}; %change index for DAPI if not first channel
    imwrite(imgToSave,[saveInPath filesep nameToSave '.tif']);
end
