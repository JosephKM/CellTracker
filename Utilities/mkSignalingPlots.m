% call this script to generate most used plots.
clear;
setAnalysisParam_this;
addpath(genpath(cd),'-begin');
global analysisParam;
allPeaks = getAllPeaks;
singleCells = allPeaks2singleCells(allPeaks);

singleCells2PlotsV2(singleCells,65000,0,0,1);
singleCells2PlotChannel(singleCells,6,65000);
singleCells2PlotsV2(singleCells,65000,1,0,0);
singleCells2PlotsV2(singleCells,65000,1,1,0);