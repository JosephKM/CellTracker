function [ output_args ] = computeCellsAndMemChild( data_direc,positions,chan,paramfile )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%% set up folder (run inside dataset root directory (one dir up from raw images)
mkdir([data_direc '-Outfiles']);
mkdir('scripts&paramfiles');

%% read in ilastik masks and run segmentation
    %%for pos = positions;
        for pos = positions;
    outfile = fullfile([data_direc '-Outfiles'],['pos' int2str(pos) '.mat']);
    runSegmentCellsAndMembraneAndorSplitOnlyByPosTime(data_direc,pos,chan,paramfile,outfile);
   
    end
copyfile(which(paramfile),['scripts&paramfiles/UserParamCopy.m']); %saves userParam with dataset
disp('Images and masks processed');

end

