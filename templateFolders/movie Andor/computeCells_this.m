% computeCells_this is run after MaxI and Ilastik

%% parameters
clear;
clear global;
tic;
setAnalysisParam_this;
global analysisParam;
data_direc = analysisParam.data_direc;
file_suffix = '.tif'; % may have to make further adjustments if not using andor .tif files
chan = analysisParam.chan; %first value is nuc channel, following contains other channels
paramfile = analysisParam.userParam; %the paramfile for preprocessing images
positions = [0:analysisParam.nPos-1]; %positions to run (assumes andor dataset naming conventions)
%%
computeCellsAndMemChild( data_direc,positions,chan,paramfile );
toc;
%%
mkdir(analysisParam.figDir);
allPeaks = getAllPeaks;
singleCells = allPeaks2singleCells(allPeaks);
plotMembrane;
mkSignalingPlotsV2(singleCells);



