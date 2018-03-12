function [ output_args ] = vsiToTif( imgDirectory, saveDirectory )
%vsiToTif copys a directoory (imgDirectory) of .vsi files and saves them
%into a new directory (saveDirectory) as '.ome.tif' files. by JKM,
%03/02/18

% Dependencies: Bioformats


%   %% save everything as a '.ome.tif' file so that Ilastik can read files

% read in files



files = dir([imgDirectory filesep '*.vsi']);

% open each file using bioformats, and save as .ome.tif preserving file
% prefix



mkdir(saveDirectory);

for jj = 1:length(files)
filename = files(jj).name;
img = bfopen([imgDirectory filesep filename]);

clear img2;
for ii = 1:3
    img2(:,:,ii) = img{1,1}{ii,1};
end
[~,name,~] = fileparts(filename);
fileOut = [saveDirectory filesep name '.ome.tif'];
bfsave(img2,fileOut);
end

end

